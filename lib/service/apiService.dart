import 'dart:io';

import 'package:curv/models/user.dart';
import 'package:curv/service/webService.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

class ApiService extends WebService {
  static Future login(String username) async {
    Map params = {};
    params['mobile'] = username;

    if (Platform.isAndroid) {
      params['clientostype'] = "android";
    } else if (Platform.isIOS) {
      params['clientostype'] = "ios";
    }

    // var res = await getOneTimeToken();
    // params['token'] = res["token"];

    return WebService.post("/user/loginUserByMobile", params);
  }

  static Future uploadFile(File? file) async {
    Client.init(
        ossEndpoint: "oss-cn-beijing.aliyuncs.com",
        bucketName: "staticgy",
        stsUrl: AppConfig.DOMAIN + "/getOssToken");
    var res = await getQiniuToken();
    var token = res["token"];
    var storage = Storage();
    // 使用 storage 的 putFile 对象进行文件上传
    return storage.putFile(file ?? File(""), token);
  }

  static Future getOneTimeToken() async {
    Map params = {};

    return WebService.post("/asdkkkk/ggtone", params);
  }

  static Future getQiniuToken() async {
    Map params = {};
    return WebService.post("/api/getQiniuToken2", params);
  }

  static Future confirmnick(String userId, String nickName) async {
    Map params = {};
    params['userId'] = userId;
    params['nickName'] = nickName;
    return WebService.post("/user/confirmnick", params);
  }

  static Future sendCode(String mobile) async {
    Map params = {};
    params['mobile'] = mobile;
    return WebService.post("/user/sendVCode", params);
  }

  static Future register(String username, String password) async {
    Map params = {};
    params['username'] = username;
    params['password'] = password;
    return WebService.post("/user/register", params);
  }

  static Future queryMessageLatest(String? userid) async {
    Map params = {};
    params["userid"] = userid;
    return WebService.post("/messagelatest/queryUser", params);
    // Map params = new Map();
    // // params["userid"] = userid;
    // return WebService.post("/messagelatest/query", params);
  }

  static Future queryChatCircle(String? userid) async {
    Map params = {};
    params["userid"] = userid;
    return WebService.post("/chatcircle/query", params);
    // Map params = new Map();
    // // params["userid"] = userid;
    // return WebService.post("/messagelatest/query", params);
  }

  static Future queryDeploy() async {
    Map params = {};
    return WebService.post("/deploy/query", params);
  }

  static Future queryGame() async {
    Map params = {};
    return WebService.post("/application/query", params);
  }

  static Future queryResource(String cate) async {
    Map params = {};
    User user = await StorageUtil.getUser();
    params['userId'] = user.id;
    return WebService.post("/resource/searchUserHotResource", params);
  }

  static Future queryResourceComment(String id) async {
    Map params = {};
    User user = await StorageUtil.getUser();
    params['user'] = user.id;
    params['resourceid'] = id;
    return WebService.post("/rscomment/query", params);
  }

  static Future getUserResources(String? id) async {
    Map params = {};
    params['createdid'] = id;
    User user = await StorageUtil.getUser();

    params['userid'] = user.id;

    return WebService.post("/resource/query", params);
  }

  static Future getUser(String? id) async {
    Map params = {};
    params["id"] = id;
    return WebService.post("/user/get", params);
  }

  static Future getResource(String resourceid) async {
    Map params = {};
    params['resourceid'] = resourceid;
    User user = await StorageUtil.getUser();
    params['userid'] = user.id;
    return WebService.post("/resource/get", params);
  }

  static Future queryTopic(String cate) async {
    Map params = {};
    params['cate'] = cate;
    return WebService.post("/resource/query", params);
  }

  static Future addResourceComment(String resourceid, String content,
      String? replyuser, String? replyuserNickname) async {
    Map params = {};
    params['resourceid'] = resourceid;
    User user = await StorageUtil.getUser();
    params['user'] = user.id;
    params['content'] = content;

    if (replyuser != null) {
      params['replyuser'] = replyuser;
      params['replyuserNickname'] = replyuserNickname;
    }

    return WebService.post("/rscomment/save", params);
  }

  static Future queryCat(int level) async {
    Map params = {};
    params["level"] = level;
    return WebService.post("/cate/query", params);
  }

  static Future addResourceGood(String resourceid) async {
    Map params = {};
    User user = await StorageUtil.getUser();
    params['user'] = user.id;
    params['resourceid'] = resourceid;
    params['nickname'] = user.nickname;

    return WebService.post("/rsgood/save", params);
  }

  static Future queryChatMessages(
      String? s, String? r, int offset, int pageSize) async {
    Map params = {};
    params['s'] = s;
    params['r'] = r;
    params['offset'] = offset;
    params['pageSize'] = pageSize;

    return WebService.post("/chatmessage/query", params);
  }

  static Future queryChatCircleMessages(
      String? circle, int offset, int pageSize) async {
    Map params = {};
    params['circle'] = circle;
    params['offset'] = offset;
    params['pageSize'] = pageSize;

    return WebService.post("/chatmessage/query", params);
  }

  static Future addDeploy(String? title, int width, int height, int? type,
      String? resourceurl, int? outerid) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['createdid'] = user.id;
    params['title'] = title;
    params['width'] = width;
    params['height'] = height;
    params['type'] = type;
    params['outerid'] = outerid;
    // params['resourceContent'] = resourceContent;
    params['resourceurl'] = resourceurl;

    return WebService.post("/resource/save", params);
  }

  static Future loginByWeixin(String? code) async {
    Map params = {};
    params['code'] = code;
    if (Platform.isAndroid) {
      params['clientostype'] = "android";
    } else if (Platform.isIOS) {
      params['clientostype'] = "ios";
    }
    return WebService.post("/loginByWeixin", params);
  }
}
