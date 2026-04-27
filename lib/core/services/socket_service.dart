import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;

  IO.Socket get socket {
    if (_socket == null) {
      print("⚠️ السوكيت لم يكن متصلاً، سأقوم بالاتصال الآن...");
      connect();
    }
    return _socket!;
  }

  void connect() {
    if (_socket == null) {
      _socket = IO.io('http://192.168.1.109:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      _socket!.connect();
      _socket!.onConnect((_) => print('✅ تم الاتصال بالسيرفر!'));
    }
  }

  void joinRoom(String orderId) {
    socket.emit('join_room', orderId);
  }

  void sendMessageToRoom(String orderId, String message) {
    socket.emit('send_room_message', {
      'roomId': orderId,
      'message': message,
      'timestamp': DateTime.now().toString(),
    });
  }

  void listenToRoomMessages(Function(Map<String, dynamic>) onMessage) {
    socket.on('receive_room_message', (data) {
      onMessage(data);
    });
  }


  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }
}