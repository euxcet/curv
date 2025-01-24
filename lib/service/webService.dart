import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:curv/tools/message.dart';
import 'package:curv/tools/config.dart';

Dio dio = Dio();

class WebService {
  static String defaultErrMsg = "系统错误";
  // get
  static Future get(String url) async {
    Response response;
    try {
      response = await dio.get(AppConfig.DOMAIN + url);
      return dealData(response);
    } catch (e) {
      Message.error(defaultErrMsg);
      throw e;
    }
  }

  // post
  static Future post(String url, Map params) async {
    Response response;
    try {
      response = await dio.post(AppConfig.DOMAIN + url, data: params);
      return dealData(response);
    } catch (e) {
      Message.error(defaultErrMsg);
      // throw e;
    }
  }

  //处理数据
  static dealData(Response response) {
    try {
      var data = jsonDecode(response.data);
      int code = data["code"];

      if (code != 0) {
        String msg = data['msg'];
        if (msg == null || msg.isEmpty) {
          msg = defaultErrMsg;
        }
        Message.error(msg);
        throw new Exception();
      }
      return data["data"];
    } catch (e) {
      //Message.error(defaultErrMsg);
      throw e;
    }
  }
}
