import 'package:socket_io_client/socket_io_client.dart' as io;

import '../constant.dart';

class SocketClient{
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal(){
    socket =io.io(url,<String ,dynamic>{
      'transport':['websocket'],
      'autoConnect':false
    });
    socket!.connect();
  }


    static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}