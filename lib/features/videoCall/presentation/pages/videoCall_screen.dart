import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/services/signaling_service.dart';
import '../../../../core/services/socket_service.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import '../../data/repository/webRTCRepository.dart';


class VideoCallScreen extends StatefulWidget {
  final String roomId;
  const VideoCallScreen({super.key, required this.roomId});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  late WebRTCRepository _repository;

  @override
  void initState() {
    super.initState();
    _initRenderers();

    _repository = WebRTCRepository(SignalingService(SocketService()));


    _repository.remoteStream.listen((stream) {
      if (stream != null) {
        setState(() {
          _remoteRenderer.srcObject = stream;
        });
      }
    });

    getUserMedia();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> getUserMedia() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    final Map<String, dynamic> constraints = {
      'audio': true,
      'video': {'facingMode': 'user'},
    };

    try {
      MediaStream stream = await navigator.mediaDevices.getUserMedia(constraints);
      setState(() {
        _localRenderer.srcObject = stream;
      });

      await _repository.initConnection(widget.roomId, stream);
    } catch (e) {
      print("Error getting user media: $e");
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _repository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           leading: IconButton(onPressed: (){
             Navigator.pop(context);
           }, icon: Icon(Icons.arrow_back,
           color: AppColors.white,
           )),
          title: Text("Call: ${widget.roomId}",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          elevation: 10,

          backgroundColor: AppColors.black,

          centerTitle: true,

          shape: const RoundedRectangleBorder(

            borderRadius: BorderRadius.vertical(

              bottom: Radius.circular(12),

            ),

          ),

          actions: [

            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: IconButton(
                onPressed: () {
                  String myRoomId = "order_123_abc";

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoCallScreen(roomId: myRoomId),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.video_camera_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],

        ),

      body: Stack(
        children: [
          RTCVideoView(_remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),

          Positioned(
            right: 20, top: 20,
            width: 120, height: 160,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
              child: RTCVideoView(_localRenderer, mirror: true),
            ),
          ),

          Positioned(
            bottom: 30, left: 0, right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () => _repository.createCall(widget.roomId),
                child: const Icon(Icons.call),
              ),
            ),
          ),
        ],
      ),
    );
  }
}