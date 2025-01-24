import 'package:curv/models/figure.dart';
import 'package:curv/models/figure3d.dart';
import 'package:curv/models/sucai.dart';
import 'package:curv/models/figureAction.dart';
import 'package:curv/models/user.dart';
import 'package:curv/service/web2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';

class Api2Service extends Web2Service {
  static Future login(String username, String password) async {
    Map params = {};
    params['mobile'] = username;
    params['password'] = password;
    // var res = await getOneTimeToken();
    // params['token'] = res["token"];

    return Web2Service.post("/user/loginUserByMobile", params);
  }

  static Future queryResourceComment(String id) async {
    Map params = {};
    User user = await StorageUtil.getUser();
    params['user'] = user.id;
    params['resourceid'] = id;
    return Web2Service.post("/rscomment/query", params);
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

    return Web2Service.post("/rscomment/save", params);
  }

  static Future addResourceGood(String resourceid) async {
    Map params = {};
    User user = await StorageUtil.getUser();
    params['user'] = user.id;
    params['resourceid'] = resourceid;
    params['nickname'] = user.nickname;

    return Web2Service.post("/rsgood/save", params);
  }

  static Future saveSucai(
      int? id, String name, String? action, String content) async {
    Map params = {};
    params['name'] = name;
    params['id'] = id;
    params['action'] = action;
    params['content'] = content;
    User user = await StorageUtil.getUser();
    params['createid'] = user.id;
    return Web2Service.post("/sucai/save", params);
  }

  static Future saveFigure(
      int? id, String name, String? action, String content) async {
    Map params = {};
    params['name'] = name;
    params['id'] = id;
    params['action'] = action;
    params['content'] = content;
    User user = await StorageUtil.getUser();
    params['createid'] = user.id;
    return Web2Service.post("/figure/save", params);
  }

  static Future aidraw(
      String? prompt,
      String? navigateprompt,
      int style,
      String styleName,
      int width,
      int height,
      int seed,
      int step,
      String sampler_index,
      String? controlnetInputImage) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['userid'] = user.id;
    params['prompt'] = prompt;
    params['navigateprompt'] = navigateprompt;

    params['width'] = width;
    params['height'] = height;
    params['step'] = step;
    params['seed'] = seed;
    params['sampler_index'] = sampler_index;
    params['style'] = style;
    params['styleName'] = styleName;
    params['sampler_index'] = sampler_index;
    params['controlnetInputImage'] = controlnetInputImage;

    return Web2Service.post("/aidraw/draw", params);
  }

  static Future aihumanSay(
      String? word, String image, int human, int style) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['userid'] = user.id;
    params['image'] = image;
    params['human'] = human;
    params['word'] = word;
    params['style'] = style;
    return Web2Service.post("/aihuman/say", params);
  }

  static Future playWord(String? word, String name, String? emotion) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['word'] = word;
    params['name'] = name;
    params['emotion'] = emotion;
    params['userid'] = user.id;
    return Web2Service.post("/createAudio", params);
  }

  static Future addDeploy(String? title, int? width, int? height, int? type,
      String? resourceurl, int? outerid, String? thumb) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['createdid'] = user.id;
    params['title'] = title;
    params['width'] = width;
    params['height'] = height;
    params['type'] = type;
    params['outerid'] = outerid;
    params["thumb"] = thumb;
    // params['resourceContent'] = resourceContent;
    params['resourceurl'] = resourceurl;

    return Web2Service.post("/resource/save", params);
  }

  static Future aidrawResult(int? id) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['userid'] = user.id;
    params['id'] = id;
    return Web2Service.post("/aidraw/getTaskResult", params);
  }

  static Future deleteAidrawResult(int? id) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['userid'] = user.id;
    params['id'] = id;
    return Web2Service.post("/aidraw/delete", params);
  }

  static Future getAihumantask(int? id) async {
    User user = await StorageUtil.getUser();
    Map params = {};
    params['userid'] = user.id;
    params['id'] = id;
    return Web2Service.post("/aihumantask/get", params);
  }

  static Future queryUserAihumantask(String? userid) async {
    Map params = {};
    params['userid'] = userid;
    return Web2Service.post("/aihumantask/queryUser", params);
  }

  static Future queryUserAidraw(String? userid) async {
    Map params = {};
    params['userid'] = userid;
    return Web2Service.post("/aidraw/queryUser", params);
  }

  static Future aihumanAdd(String? url, int type) async {
    Map params = {};
    params['userid'] = AppUtil.user!.id;
    params['type'] = type;
    params['image'] = url;
    params['cover'] = type == 1 ? "" : (url! + "?vframe/png/offset/0");
    return Web2Service.post("/aihuman/add", params);
  }

  static Future saveAction(String name) async {
    Map params = {};
    params['name'] = name;
    User user = await StorageUtil.getUser();
    params['createid'] = user.id;
    return Web2Service.post("/action/save", params);
  }

  static Future queryHotSucai() async {
    Map params = {};
    return Web2Service.post("/sucai/queryHot", params);
  }

  static Future querySucai() async {
    Map params = {};
    return Web2Service.post("/sucai/query", params);
  }

  static Future querySucai3d() async {
    Map params = {};
    return Web2Service.post("/sucai3d/query", params);
  }

  static Future queryAction() async {
    Map params = {};
    return Web2Service.post("/action/query", params);
  }

  static Future getApplication(String? id) async {
    Map params = {"id": id};
    return Web2Service.post("/application/get", params);
  }

  static Future getConfig() async {
    return Web2Service.post("/config", {});
  }

  static Future queryFigure3D() async {
    Map params = {};
    List res = await Web2Service.post("/figure3d/query", params);
    return Figure3D.toList(res);
  }

  static Future queryFigure() async {
    Map params = {};
    List res = await Web2Service.post("/figure/query", params);
    return Figure.toList(res);
  }

  static Future clearUnread(String? userid, String? outerid) async {
    Map params = {"userid": userid, "outerid": outerid};
    Map res = await Web2Service.post("/messagelatest/clearUnread", params);
    return res;
  }

  static Future clearMessageUnread(String? userid) async {
    Map params = {"userid": userid};
    Map res = await Web2Service.post("/message/clearUnread", params);
    return res;
  }

  static Future queryUnread(String? userid) async {
    Map params = {"userid": userid};
    var res = await Web2Service.post("/message/queryUnread", params);
    return res;
  }

  static Future updateFigure(String userid, int? figureid, int? hair,
      int? clothes, int? pant, int? shoes, String lines) async {
    Map params = {};
    params["userid"] = userid;
    params["figureid"] = figureid;
    params["hair"] = hair;
    params["clothes"] = clothes;
    params["pant"] = pant;
    params["shoes"] = shoes;
    params["lines"] = lines;

    return Web2Service.post("/user/updateFigure", params);
  }

  static Future updateFigure2(String userid, int? figureid) async {
    Map params = {};
    params["userid"] = userid;
    params["figureid"] = figureid;
    return Web2Service.post("/user/updateFigure", params);
  }

  static Future updateUserFigureAction(String userid, int? actionid) async {
    Map params = {};
    params["userid"] = userid;
    params["actionid"] = actionid;
    return Web2Service.post("/user/updateUserFigureAction", params);
  }

  static Future querySucaiByType(String type) async {
    Map params = {};
    params["type"] = type;

    List res = await Web2Service.post("/sucai/queryByType", params);
    return Sucai.toList(res);
  }

  static Future<Sucai> getSucai(int? id) async {
    Map params = {};
    params["id"] = id;

    Map res = await Web2Service.post("/sucai/get", params);
    return Sucai.toSucai(res);
  }

  static Future<Figure> getFigure(int? id) async {
    Map params = {};
    params["id"] = id;

    Map res = await Web2Service.post("/figure/get", params);
    return Figure.toFigure(res);
  }

  static Future<Figure3D> getFigure3d(int? id) async {
    Map params = {};
    params["id"] = id;

    Map res = await Web2Service.post("/figure3d/get", params);
    return Figure3D.toFigure3D(res);
  }

  static Future queryMessageLatest(String? userid) async {
    Map params = {};
    params["userid"] = userid;
    return Web2Service.post("/messagelatest/queryUser", params);
    // Map params = new Map();
    // // params["userid"] = userid;
    // return WebService.post("/messagelatest/query", params);
  }

  static Future queryVipcates(String? userid) async {
    Map params = {};
    params["userid"] = userid;
    return Web2Service.post("/vipcate/query", params);
    // Map params = new Map();
    // // params["userid"] = userid;
    // return WebService.post("/messagelatest/query", params);
  }

  static Future getOrder(int? id) async {
    Map params = {};
    params["id"] = id;
    return Web2Service.post("/aiorder/get", params);
  }

  static Future aitoolOrderSubmit(int cate, String userid, int paytype) async {
    Map params = {};
    params["cate"] = cate;
    params["userid"] = userid;
    params["paytype"] = paytype;
    return Web2Service.post("/aitool/order/submit", params);
  }

  static Future queryMessages(String? userid) async {
    Map params = {};
    params["userid"] = userid;
    return Web2Service.post("/message/query", params);
  }

  static Future updateSucai(String userid, int? sucaiid) async {
    Map params = {};
    params["userid"] = userid;
    params["Sucaiid"] = sucaiid.toString();
    Map res = await Web2Service.post("/user/updateSucai", params);
    return res;
  }

  static Future queryChatMessages(
      String? s, String? r, int offset, int pageSize) async {
    Map params = {};
    params['s'] = s;
    params['r'] = r;
    params['offset'] = offset;
    params['pageSize'] = pageSize;

    return Web2Service.post("/chatmessage/query", params);
  }

  static Future queryUser(String key) async {
    Map params = {};
    params["key"] = key;
    Map res = await Web2Service.post("/user/searchUser", params);
    return res;
  }

  static Future<FigureAction> getFigureAction(int? id) async {
    Map params = {};
    params["id"] = id;

    Map res = await Web2Service.post("/FigureAction/get", params);
    return FigureAction.toFigureAction(res);
  }

  // 获取用户的形象动作
  static Future<FigureAction> getUserFigureAction(int? id) async {
    Map params = {};
    params["id"] = id;
    Map res = await Web2Service.post("/figure/getUserFigureAction", params);
    return FigureAction.toFigureAction(res);
  }

  static Future<Map> getUsersFigureActions(
      String? leftId, String? rightId) async {
    Map params = {};
    params["leftId"] = leftId;
    params["rightId"] = rightId;
    Map res = await Web2Service.post("/user/getUsersFigureActions", params);
    return res;
  }

  static Future saveFigureAction(int? id, int? figureid, String name,
      int? actionid, String keyframes, int loop) async {
    Map params = {};
    params['name'] = name;
    params['id'] = id;
    params['actionid'] = actionid;
    params['figureid'] = figureid;
    params['keyframes'] = keyframes;
    User user = await StorageUtil.getUser();
    params['createid'] = user.id;
    params['loop'] = loop;

    return Web2Service.post("/figureAction/save", params);
  }

  static Future? getFigureActionByUserid(String? id) async {
    Map params = {};
    params["id"] = id;
    var res = await Web2Service.post("/figureAction/getByUserid", params);
    if (res == null) {
      return null;
    }
    return FigureAction.toFigureAction(res);
  }

  static Future queryFigureAction(int? figureid) async {
    Map params = {};
    params["figureid"] = figureid;
    List res = await Web2Service.post("/figureAction/query", params);
    return FigureAction.toList(res);
  }

  static Future aichatuserConfig(String userid) async {
    Map params = {};
    params["userid"] = userid;
    Map res = await Web2Service.post("/aichatuser/config", params);
    return res;
  }

  static Future sendCheck(String userid) async {
    Map params = {};
    params["userid"] = userid;
    Map res = await Web2Service.post("/sendCheck/config", params);
    return res;
  }

  static Future sendCheckShare(String userid) async {
    Map params = {};
    params["userid"] = userid;
    Map res = await Web2Service.post("/sendCheck/share", params);
    return res;
  }

  static Future confirmnick(String userid, String nickname) async {
    Map params = {};
    params['userid'] = userid;
    params['nickname'] = nickname;
    return Web2Service.post("/user/confirmnick", params);
  }

  static Future confirmInvitecode(String userid, String invitecode) async {
    Map params = {};
    params['userid'] = userid;
    params['invitecode'] = invitecode;
    return Web2Service.post("/user/confirmInvitecode", params);
  }

  static Future fankui(String userid, String phone, String content) async {
    Map params = {};
    params['userid'] = userid;
    params['phone'] = phone;
    params['content'] = content;
    return Web2Service.post("/fankui/add", params);
  }

  static Future getInputInvitecode(String userid) async {
    Map params = {};
    params['userid'] = userid;

    return Web2Service.post("/user/getInputInvitecode", params);
  }

  static Future getUser(String id) async {
    Map params = {};
    params['id'] = id;

    return Web2Service.post("/user/get", params);
  }

  static Future aichatuserShare(String userid) async {
    Map params = {};
    params["userid"] = userid;
    Map res = await Web2Service.post("/aichatuser/share", params);
    return res;
  }

  static Future queryResourceHot(String? userid, int? type) async {
    Map params = {};
    params["userid"] = userid;
    params["type"] = type;

    List res = await Web2Service.post("/resource/queryHot", params);
    return res;
  }

  static Future getUserResources(String? id) async {
    Map params = {};
    params['createdid'] = id;
    User user = await StorageUtil.getUser();

    params['userid'] = user.id;

    return Web2Service.post("/resource/query", params);
  }

  static Future getResource(String id) async {
    Map params = {};

    params["id"] = id;
    if (AppUtil.user != null) {
      params["userid"] = AppUtil.user!.id;
    }

    Map res = await Web2Service.post("/resource/get", params);

    return res;
  }

  static Future getMyInviteCode(String userid) async {
    Map params = {};
    params["userid"] = userid;
    params["iosVersion"] = AppConfig.version;
    params["androidVersion"] = AppConfig.version;

    Map res = await Web2Service.post("/invite/getInviteCode", params);
    return res;
  }

  static Future queryAidrawModel() async {
    Map params = {};
    List res = await Web2Service.post("/aidraw/model/query", params);
    return res;
  }

  static Future queryAihuman() async {
    Map params = {};
    List res = await Web2Service.post("/aihuman/query", params);
    return res;
  }

  static Future queryAudioStyle() async {
    Map params = {};
    List res = await Web2Service.post("/audioStyle/query", params);
    return res;
  }
}
