import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../../core/services/signaling_service.dart';

class WebRTCRepository {
  final SignalingService _signalingService;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  Stream<MediaStream?> get remoteStream => _remoteStreamController.stream;

  final Map<String, dynamic> _config = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ]
  };

  String? _currentRoomId;

  WebRTCRepository(this._signalingService) {
    _initSignalingListeners();
  }

  void _initSignalingListeners() {
    _signalingService.listenToSignals(
      onOffer: (data) => _handleOffer(data['roomId'], data['sdp']),
      onAnswer: (data) => _handleAnswer(data['sdp']),
      onCandidate: (data) => _handleCandidate(data['candidate']),
    );
  }

  Future<void> initConnection(String roomId, MediaStream localStream) async {
    _currentRoomId = roomId;
    _localStream = localStream;
    _peerConnection = await createPeerConnection(_config);

    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    _peerConnection!.onIceCandidate = (candidate) {
      _signalingService.sendSignal(_currentRoomId!, 'candidate', candidate.toMap());
    };

    _peerConnection!.onAddStream = (stream) {
      _remoteStreamController.add(stream);
    };
  }

  Future<void> createCall(String roomId) async {
    _currentRoomId = roomId;
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    _signalingService.sendSignal(roomId, 'offer', offer.toMap());
  }

  Future<void> _handleOffer(String roomId, dynamic sdp) async {
    _currentRoomId = roomId;
    await _peerConnection!.setRemoteDescription(RTCSessionDescription(sdp['sdp'], sdp['type']));
    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    _signalingService.sendSignal(roomId, 'answer', answer.toMap());
  }

  Future<void> _handleAnswer(dynamic sdp) async {
    await _peerConnection!.setRemoteDescription(RTCSessionDescription(sdp['sdp'], sdp['type']));
  }

  Future<void> _handleCandidate(dynamic candidate) async {
    await _peerConnection!.addCandidate(RTCIceCandidate(
      candidate['candidate'],
      candidate['sdpMid'],
      candidate['sdpMLineIndex'],
    ));
  }

  void dispose() {
    _peerConnection?.dispose();
    _remoteStreamController.close();
  }
}