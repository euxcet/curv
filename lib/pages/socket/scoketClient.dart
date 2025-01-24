import 'package:flutter/material.dart';
import 'package:curv/models/ChatMessage.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/event_bus.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// 引入Socket.io
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScoketClient {
  static IO.Socket? socket;
  static init() {
    print('开始链接2222..');
    Map options = {
      'reconnection': true,
      'forceNew': true,
      'transports': ['websocket'],
    };
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    if (inProduction) {
      options['path'] = "/socket.io/social";
    }
    socket = IO.io(AppConfig.DOMAIN_SocketIO, options);
    // 连接事件
    socket?.on('connect', (_) {
      EasyLoading.dismiss();
      print('connect..');
      sendNew();
    });
    // 接受来自服务端的数据
    socket?.on('toClient', (data) {
      print('接受到消息..');
    });
    socket?.onError((data) {
      print('error');
      print(data);
    });
    // 断开连接
    socket?.on('disconnect', (_) {
      EasyLoading.show(status: "断线重连");
      print('disconnect');
    });
    List cmds = ["ret", 'ms'];
    cmds.forEach((element) {
      socket?.on(element, (data) {
        eventBus.fire(SocketEvent(data));
      });
    });
  }

  static send(ChatMessage chatMessage) {
    Map map = chatMessage.toMap();
    sendMap('ms', map);
  }

  static sendNew() async {
    var user = await StorageUtil.getUser();
    Map map = new Map();
    map["c"] = "new";
    map["s"] = user.id;
    sendMap('new', map);
  }

  static sendMap(cmd, map) {
    socket?.emit(cmd, map);
  }
}
