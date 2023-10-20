import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:appfood/style.dart';

import '../services/preferences_service.dart';

class RealTimeSocket {
  late IO.Socket socket;
  final _preferencesService = PreferencesService();
  var id = "";
  bool connected = false;

  RealTimeSocket() { 
    initSocket();
  }

  IO.Socket getSocket() => socket;

  bool isConnected() => connected;

  Future initSocket() async {
    // ignore: unnecessary_null_comparison
    try {
      Set set = await _preferencesService.getToken();
      id = set.elementAt(1);
      socket = IO.io('http://' + urlServer,
          IO.OptionBuilder().setTransports(['websocket']).build());

      socket.onConnect((_) {
        connected = true;
        socket.emit('getUser', id);
      });
    } catch (e) {
      print(e);
    }
  }

  void reloadScreen(f) {
    socket.on("reload", f);
  }
}
