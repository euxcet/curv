import 'package:curv/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class StorageUtil {
  static saveUser(Map map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", convert.jsonEncode(map));
  }

  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static saveGamesDownload(Map map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("games_download", convert.jsonEncode(map));
  }

  static getGamesDownload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("games_download");
    if (userJson != null && userJson.isNotEmpty) {
      Map<String, dynamic> map = convert.jsonDecode(userJson);
      return map;
    }
    return {};
  }

  static saveApplication(String? id, Map map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("application_" + id.toString(), convert.jsonEncode(map));
  }

  static getApplication(String? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("application_" + id.toString());
    if (userJson != null && userJson.isNotEmpty) {
      Map<String, dynamic> map = convert.jsonDecode(userJson);
      return map;
    }
    return {};
  }

  static saveActionVersion(String id, String version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("action_version_" + id, version.toString());
  }

  static getActionVersion(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? version = prefs.getString("action_version_" + id);
    if (version != null && version.isNotEmpty) {
      return version;
    }
    return null;
  }

  static saveFiguresDownload(Map map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("figures_download", convert.jsonEncode(map));
  }

  static getFiguresDownload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("figures_download");
    if (userJson != null && userJson.isNotEmpty) {
      Map<String, dynamic> map = convert.jsonDecode(userJson);
      return map;
    }
    return {};
  }

  static saveMessageLatests(List list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("messageLatests", convert.jsonEncode(list));
  }

  static getMessageLatests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("messageLatests");
    if (userJson != null && userJson.isNotEmpty) {
      List list = convert.jsonDecode(userJson);
      return list;
    }
    return [];
  }

  static saveChatmessages(String? outerid, List list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("chat_" + outerid.toString(), convert.jsonEncode(list));
  }

  static getChatmessages(String? outerid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("chat_" + outerid.toString());
    if (userJson != null && userJson.isNotEmpty) {
      List list = convert.jsonDecode(userJson);
      return list;
    }
    return [];
  }

  static saveUsersFigureActions(String? outerid, Map? map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "UsersFigureActions_" + outerid.toString(), convert.jsonEncode(map));
  }

  static getUsersFigureActions(String? outerid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson =
        prefs.getString("UsersFigureActions_" + outerid.toString());
    if (userJson != null && userJson.isNotEmpty) {
      Map map = convert.jsonDecode(userJson);
      return map;
    }
    return null;
  }

  static clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool("secretOpen", true);
  }

  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("user");
    if (userJson != null && userJson.isNotEmpty) {
      Map<String, dynamic> userMap = convert.jsonDecode(userJson);
      User user = User.fromMap(userMap);
      return user;
      // user = new User();
      // user.id = userMap['id'];
      // user.mobile = userMap['mobile'];
      // user.nickname = userMap['nickname'];
      // user.headimg = userMap['headimg'];
      // if(userMap['gold']!=null){
      //   user.gold = userMap['gold'];
      //   user.diamond = userMap['diamond'];
      // }
      // return user;
    }
    return null;
  }

  static getSecretOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? secretOpen = prefs.getBool("secretOpen");

    return secretOpen ?? false;
  }

  static saveSecretOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("secretOpen", true);
  }
}
