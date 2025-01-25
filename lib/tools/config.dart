import 'dart:io';

import 'package:flutter/material.dart';

const AGORA_APP_ID = 'afee5a5da5244c8aa723c6788accb821';

// String DOMAIN = "http://127.0.0.1:8099/majiang_zxw";
// String SERVER = "127.0.0.1";

Color fontColor = const Color.fromARGB(255, 94, 61, 33);

const String ShareRoomUrl =
    "http://www.xiaowanwu.cn/h5_majiang_zxw_static/index.html#/room/";

// const String DOMAIN2 = "http://192.168.0.115:8112/social";

const String SERVER = "139.196.40.161";

Color themeBgColor = const Color(0xfff2da2a);

class AppConfig {
  static const String QINIUSUFFIX = "http://u.xiaowanwu.cn/";
  static const String WXAppId = 'wx4eb06224c3aad1b5';
  static const String UniversalLink = 'https://www.xiaowanwu.cn/';
  static const Color font1 = Color(0xff222222);
  static const Color font2 = Color(0xff666666);
  static const Color font3 = Color(0xff999999);
  static const Color mainColor = Color(0xff000000);
  static const Color blue = Color(0xff6980ff);
  static double messageLatestHeight = Platform.isIOS ? 135 : 120;
  static const double bottomBarHeight = 49;
  static const double height = 90;
  static const double padding = 15;

  static const String version = "1.0.7";
  static const String iosVersion = "1.0.2";

  static double actionChatHeight = 0;
  static String DOMAIN = "http://10.0.6.143:8080";
  static String DOMAIN2 = "";
  static String DOMAIN_SocketIO = "";
  static String DomainFigure = "";
  static init() {
    const bool inProduction = bool.fromEnvironment("dart.vm.product");
    if (inProduction) {
      DOMAIN2 = "https://www.xiaowanwu.cn/social";
      DOMAIN_SocketIO = "https://www.xiaowanwu.cn";
      DomainFigure = "https://www.xiaowanwu.cn/threeh5/index.html";
    } else {
      DOMAIN2 = "http://192.168.0.115:8113/social";
      DOMAIN_SocketIO = "ws://192.168.0.115:8113";
      DomainFigure = "http://192.168.0.115:8080";
    }
  }

  static const Color grayBgColor = Color(0xfff8f8f8);
  static Rect leftFigureRect = const Rect.fromLTWH(0.05, 0.1, 0.4, 0.4);
  static Rect rightFigureRect = const Rect.fromLTWH(0.55, 0.1, 0.4, 0.4);
  static Rect figureAreaDefaultRect = const Rect.fromLTWH(0, 0, 0, 0);
  static Rect getLeftFigureRect(double x, double y) {
    return Rect.fromLTWH(
        figureAreaDefaultRect.width * leftFigureRect.left + x,
        figureAreaDefaultRect.width * leftFigureRect.top + y,
        figureAreaDefaultRect.width * leftFigureRect.width,
        figureAreaDefaultRect.width * leftFigureRect.height);
  }

  static Rect getRightFigureRect(double x, double y) {
    return Rect.fromLTWH(
        figureAreaDefaultRect.width * rightFigureRect.left + x,
        figureAreaDefaultRect.width * rightFigureRect.top + y,
        figureAreaDefaultRect.width * rightFigureRect.width,
        figureAreaDefaultRect.width * rightFigureRect.height);
  }
}
