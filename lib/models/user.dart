/// 用户实体类
class User {
  static String dataBaseTableName = "prod_users";
  String id = "";
  late String? username;
  late String? password;
  late String? nickname;
  String? headimg;
  int? actionid;
  int? figureid;
  int? vipcate;

  String? mobile;
  String? userno;

  User(this.username, this.password, this.headimg);

  static User fromMap(Map<String, dynamic> map) {
    User user = User(null, null, "/images/headimg.jpg");
    if (map["id"] != null) {
      user.id = map['id'];
    }
    user.nickname = map['nickname'];
    user.username = map['username'];
    user.headimg = map['headimg'];
    user.userno = map['userno'];
    user.vipcate = map['vipcate'];

    user.mobile = map['mobile'];
    if (map["figureid"] != null && map["figureid"] != "xiaoputao") {
      try {
        user.figureid = int.parse(map['figureid'].toString());
      } catch (e) {}
    }
    if (map["actionid"] != null) {
      user.actionid = map['actionid'];
    }

    return user;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'user_name': username,
      'pass_word': password,
    };
    map['id'] = id;
    return map;
  }
}
