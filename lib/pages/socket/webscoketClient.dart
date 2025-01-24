import 'dart:convert' as convert;

import 'package:curv/models/ChatMessage.dart';
import 'package:curv/tools/event_bus.dart';
import 'package:curv/tools/storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebscoketClient {
  static var channel;
  static init() {
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://139.196.40.161:8080/tongxiang/websocket/engine'));

    channel.stream.listen((message) {
      Map msg = convert.jsonDecode(message);
      eventBus.fire(SocketEvent(msg));
      // channel.sink.close(status.goingAway);
    });
    sendNew();
  }

  static send(ChatMessage chatMessage) {
    Map map = chatMessage.toMap();
    String josnNameString = convert.jsonEncode(map);
    channel.sink.add(josnNameString);
  }

  static sendNew() async {
    var user = await StorageUtil.getUser();
    Map map = new Map();
    map["c"] = "new";
    map["s"] = user.id;
    String josnNameString = convert.jsonEncode(map);
    channel.sink.add(josnNameString);
  }
}
