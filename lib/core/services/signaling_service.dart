import '../services/socket_service.dart';

class SignalingService {
  final SocketService _socketService;

  SignalingService(this._socketService);

  void sendSignal(String roomId, String type, dynamic data) {
    _socketService.emit(type, {
      'roomId': roomId,
      'sdp': type == 'offer' || type == 'answer' ? data : null,
      'candidate': type == 'candidate' ? data : null,
    });
  }

  void listenToSignals({
    required Function(dynamic) onOffer,
    required Function(dynamic) onAnswer,
    required Function(dynamic) onCandidate,
  }) {
    _socketService.on('offer', (data) => onOffer(data));
    _socketService.on('answer', (data) => onAnswer(data));
    _socketService.on('candidate', (data) => onCandidate(data));
  }
}