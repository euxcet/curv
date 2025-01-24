/// 用户实体类
class ChatMessage {
  //主键
  String? id;
  //发送人
  String? s;
  //接受人
  String? r;
  //类型
  String? t;
  //命令
  String? c;
  //消息内容
  String? m;
  //是否已读
  int? read;
  //发送时间
  String? stime;

  //描述
  String? desc;

  //描述
  String? ext1;
  String? ext2;

  //图标
  String? icon;

  //资源
  String? resource;

  String? suffix;

  //0 正在发送 1:已发送 2:发送失败
  int? status;

  String? circle;

  int? rankno;

  //发送者昵称
  String? nickname;

  //发送者头像
  String? headimg;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      's': s,
      'r': r,
      't': t,
      'c': "ms",
      'm': m,
      'stime': stime,
      'desc': desc??"",
      'suffix':suffix??"",
      'nickname': nickname,
      'resource': resource??"",
      'headimg': headimg,
      'icon': icon??""
    };
    if(circle!=null){
      map["circle"] = circle;
    }
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
