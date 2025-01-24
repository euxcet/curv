import 'package:dio/dio.dart';
import 'package:curv/tools/message.dart';
import 'package:curv/tools/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Dio dio = Dio();

class Web2Service {
  static String defaultErrMsg = "系统错误";
  // get
  static Future get(String url) async {
    Response response;
    try {
      response = await dio.get(AppConfig.DOMAIN2 + url);
      return dealData(response);
    } catch (e) {
      // Message.error(defaultErrMsg);
      rethrow;
    }
  }

  // post
  static Future post(String url, Map params) async {
    Response response;
    try {
      response = await dio.post(AppConfig.DOMAIN2 + url, data: params);
      return dealData(response);
    } catch (e) {
      // Message.error(defaultErrMsg);
      rethrow;
    }
  }

  //处理数据
  static dealData(Response response) {
    var data = response.data;
    int code = data["code"];

    if (code != 0) {
      String msg = response.data['msg'];
      if (msg.isEmpty) {
        msg = defaultErrMsg;
      }
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      Message.error(msg);
      throw Exception();
    }
    return data["data"];
  }
}
