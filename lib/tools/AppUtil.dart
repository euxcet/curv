import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/user/fankui.dart';
import 'package:curv/pages/user/loginHomeView.dart';
import 'package:curv/pages/user/vipView.dart';
import 'package:curv/pages/web/linkWebview.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:curv/models/user.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'dart:convert';

class AppUtil {
  static List games = [];
  static User? user;
  static String? token;
  static VideoPlayerController? videoPlayerController;
  static String getUUID() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color toColor(String code) {
    if (code.isEmpty) {
      return const Color(0xff000000);
    }
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }

  static double getPadding() {
    return 14;
  }

  /// fluro 传递中文参数前，先转换，fluro 不支持中文传递
  static String paramsEncode(String originalCn) {
    return jsonEncode(const Utf8Encoder().convert(originalCn));
  }

  static invite(BuildContext context) async {
    if (!AppUtil.isLogin(context)) {
      return;
    }

    Map res = await Api2Service.getMyInviteCode(AppUtil.user!.id);
    String invitecode = res["invitecode"];
    bool showVip = Platform.isIOS ? res["iosShowVip"] : true;

    int vip1Count = res["vip1Count"];
    int vip2Count = res["vip2Count"];

    int vip3Count = res["vip3Count"];

    int vip4Count = res["vip4Count"];

    int vip5Count = res["vip5Count"];

    // String invitecode = "20903209320";
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage("images/diglogbg.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/sharelaba.png",
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        MyText(
                          title: "邀请" + vip5Count.toString() + "个好友即可免费使用",
                          weight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              AppUtil.back();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyText(
                      title: "您的邀请码:",
                      fontSize: 20,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xffeeeeee),
                          borderRadius: BorderRadius.circular(10)),
                      child: MyText(
                        title: invitecode,
                        fontSize: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "邀请" + vip1Count.toString() + "个好友可以免费使用1个月",
                            fontSize: 15,
                          ),
                          const SizedBox(height: 5),
                          MyText(
                            title:
                                "邀请" + vip2Count.toString() + "个好友可以免费使用1个季度",
                            fontSize: 15,
                          ),
                          const SizedBox(height: 5),
                          MyText(
                            title: "邀请" + vip3Count.toString() + "个好友可以免费使用1年",
                            fontSize: 15,
                          ),
                          const SizedBox(height: 5),
                          MyText(
                            title: "邀请" + vip4Count.toString() + "个好友可以免费使用2年",
                            fontSize: 15,
                          ),
                          const SizedBox(height: 5),
                          MyText(
                            title:
                                "邀请" + vip5Count.toString() + "个好友可以免费使用500年",
                            fontSize: 15,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    showVip
                        ? Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                AppUtil.getTo(const VipView());
                              },
                              child: Container(
                                width: 200,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                        //渐变位置
                                        begin: Alignment.bottomLeft, //右上
                                        end: Alignment.topRight, //左下
                                        stops: [
                                          0.0,
                                          1.0
                                        ], //[渐变起始点, 渐变结束点]
                                        //渐变颜色[始点颜色, 结束颜色]
                                        colors: [
                                          Color(0xffE9fF3F),
                                          Color(0xffE9cFFF)
                                        ])),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/viplogo.png",
                                      width: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    MyText(
                                      title: "[或者]开通会员,不限次数",
                                      fontSize: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                AppUtil.copy(invitecode);
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xffA59DFF),
                                    borderRadius: BorderRadius.circular(10)),
                                child: MyText(
                                  title: "复制邀请码",
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            flex: 3,
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  /// 分享到好友
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffA59DFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MyText(
                                    title: "去分享",
                                    color: Colors.white,
                                  ),
                                )))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// fluro 传递后取出参数，解析
  static String paramsDecode(String encodeCn) {
    List<int> list = [];

    ///字符串解码
    for (var data in jsonDecode(encodeCn)) {
      list.add(data);
    }
    return const Utf8Decoder().convert(list);
  }

  static EdgeInsets getCommonPadding() {
    return EdgeInsets.fromLTRB(getPadding(), 10, getPadding(), 10);
  }

  static Future download(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    dynamic? data,
    Options? options,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Dio _dioInstance = Dio();
    try {
      return await _dioInstance.download(
        url,
        savePath,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        EasyLoading.showInfo('下载已取消！');
      } else {
        if (e.response != null) {
          // _handleErrorResponse(e.response);
        } else {
          EasyLoading.showError(e.message);
        }
      }
    } on Exception catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  static String getQiniuUrl(String url, double imagewidth, double imageheight) {
    int w = imagewidth.toInt();
    int h = imageheight.toInt();

    if (!url.contains("u.xiaowanwu.cn")) {
      return url;
    }
    if (url.indexOf("?") != -1) {
      return url + "/w/${w}/h/${h}";
    }
    String imageurl = url +
        "?imageView/1/w/" +
        w.toInt().toString() +
        "/h/" +
        h.toInt().toString() +
        "/format/webp";
    return imageurl;
  }

  static String getMsgType(int type) {
    String typeText = "";
    if (type == 5) {
      typeText = "点赞了您";
    } else if (type == 6) {
      typeText = "评论了您";
    }
    return typeText;
  }

  static String getTimeString(String date, String end) {
    if (date.isEmpty) {
      return "";
    }
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();
    int nowTime = now.millisecondsSinceEpoch;
    int timestamp = dateTime.millisecondsSinceEpoch;
    int dis = nowTime - timestamp;
    if (dis < 30 * 60 * 1000) {
      return "刚刚" + end;
    } else if (dis > 30 * 60 * 1000 && dis < 60 * 60 * 1000) {
      return "半小时前" + end;
    } else if (dis > 60 * 60 * 1000 && dis < 24 * 60 * 60 * 1000) {
      int h = dis ~/ (60 * 60 * 1000);
      return h.toString() + "小时前" + end;
    } else if (dis > 24 * 60 * 60 * 1000 && dis < 5 * 24 * 60 * 60 * 1000) {
      int d = dis ~/ (24 * 60 * 60 * 1000);
      return d.toString() + "天前" + end;
    }
    return DateFormat('MM-dd HH:mm').format(dateTime) + end;
  }

  static String formateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  static String formateDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  static String formateDateByDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formateTimeByTime(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  static String geIntTimeString2(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String end = "";
    DateTime now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat('HH:mm').format(dateTime) + end;
    } else {
      return DateFormat('MM-dd HH:mm').format(dateTime) + end;
    }
  }

  static String geIntTimeString(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String end = "";
    DateTime now = DateTime.now();
    int nowTime = now.millisecondsSinceEpoch;
    int timestamp = dateTime.millisecondsSinceEpoch;
    int dis = nowTime - timestamp;
    if (dis < 30 * 60 * 1000) {
      return "刚刚" + end;
    } else if (dis > 30 * 60 * 1000 && dis < 60 * 60 * 1000) {
      return "半小时前" + end;
    } else if (dis > 60 * 60 * 1000 && dis < 24 * 60 * 60 * 1000) {
      int h = dis ~/ (60 * 60 * 1000);
      return h.toString() + "小时前" + end;
    } else if (dis > 24 * 60 * 60 * 1000 && dis < 5 * 24 * 60 * 60 * 1000) {
      int d = dis ~/ (24 * 60 * 60 * 1000);
      return d.toString() + "天前" + end;
    }
    return DateFormat('MM-dd HH:mm').format(dateTime) + end;
  }

  static void showConfirm(BuildContext context,
      {Function? onCancel,
      Function? onConfirm,
      String title = "",
      String cancelText = "取消",
      String confirmText = "确认"}) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff000000),
          content: Container(
            height: 50,
            child: Column(
              children: [
                Text(
                  "提示",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffaaaaaa), fontSize: 14),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onCancel != null) {
                      onCancel();
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff5555555),
                        borderRadius: BorderRadius.circular(20)),
                    child: MyText(
                      title: "取消",
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                MyButton(
                  "确认",
                  width: 80,
                  height: 35,
                  fontSize: 14,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) {
                      onConfirm();
                    }
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  static void showConfirmContent(BuildContext context, Widget content,
      {Function? onCancel,
      Function? onConfirm,
      String title = "",
      String cancelText = "取消",
      String confirmText = "确认"}) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              content,
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (onCancel != null) {
                            onCancel();
                          }
                          AppUtil.back();
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xffCCCCCC),
                              borderRadius: BorderRadius.circular(5)),
                          child: MyText(
                            title: cancelText,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (onConfirm != null) {
                              onConfirm();
                            }
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppConfig.mainColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: MyText(
                              title: confirmText,
                              color: Colors.white,
                            ),
                          )))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static getTo(Widget widget) {
    Get.to(widget, transition: Transition.cupertino);
  }

  static getReplaceTo(Widget widget) {
    Get.offAll(widget);
  }

  /// target  要转换的数字
  /// postion 要保留的位数
  /// isCrop  true 直接裁剪 false 四舍五入
  static String formartNum(num target, int postion, {bool isCrop = false}) {
    String t = target.toString();
    // 如果要保留的长度小于等于0 直接返回当前字符串
    if (postion < 0) {
      return t;
    }
    if (t.contains(".")) {
      String t1 = t.split(".").last;
      if (t1.length >= postion) {
        if (isCrop) {
          // 直接裁剪
          return t.substring(0, t.length - (t1.length - postion));
        } else {
          // 四舍五入
          return target.toStringAsFixed(postion);
        }
      } else {
        // 不够位数的补相应个数的0
        String t2 = "";
        for (int i = 0; i < postion - t1.length; i++) {
          t2 += "0";
        }
        return t + t2;
      }
    } else {
      // 不含小数的部分补点和相应的0
      String t3 = postion > 0 ? "." : "";

      for (int i = 0; i < postion; i++) {
        t3 += "0";
      }
      return t + t3;
    }
  }

  static DecorationImage? getDecorationImage(String? url) {
    if (url != null && url.isNotEmpty && url.startsWith("http")) {
      return DecorationImage(image: NetworkImage(url), fit: BoxFit.cover);
    } else if (url != null) {
      return DecorationImage(image: AssetImage(url), fit: BoxFit.cover);
    } else {
      return null;
    }
  }

  static back() {
    Get.back();
  }

  static isLogin(BuildContext context) {
    if (AppUtil.user == null) {
      AppUtil.showConfirmContent(
          context,
          MyText(
            title: "登录后才能使用此功能,立即登录?",
          ), onConfirm: () {
        AppUtil.getTo(const LoginHomeViewPage());
      });

      return false;
    }
    return true;
  }

  static refreshUser() async {
    var res = await Api2Service.getUser(AppUtil.user!.id);
    await StorageUtil.saveUser(res);
    AppUtil.user = await StorageUtil.getUser();
  }

  static copy(String data) {
    if (data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
    EasyLoading.showSuccess("复制成功");
  }

  static BoxDecoration getMainButtonDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: const LinearGradient(
            //渐变位置
            begin: Alignment.bottomLeft, //右上
            end: Alignment.topRight, //左下
            stops: [0.0, 1.0], //[渐变起始点, 渐变结束点]
            //渐变颜色[始点颜色, 结束颜色]
            colors: [Color(0xffA59DFF), Color(0xffE9cFFF)]));
  }

  static showVip(BuildContext context, String message, String shareTitle,
      String logo) async {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage("images/diglogbg.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      title: "使用次数提示",
                      weight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 30),
                    MyText(
                      title: message,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                AppUtil.back();
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xffEDEDED),
                                    borderRadius: BorderRadius.circular(10)),
                                child: MyText(
                                  title: "取消",
                                  color: AppConfig.font3,
                                ),
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            flex: 3,
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  /// 分享到好友
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffA59DFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MyText(
                                    title: "去分享",
                                    color: Colors.white,
                                  ),
                                )))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static LinearGradient getMainLinearGradient() {
    return const LinearGradient(
        //渐变位置
        begin: Alignment.topLeft, //右上
        end: Alignment.bottomRight, //左下
        stops: [0.0, 1.0], //[渐变起始点, 渐变结束点]
        //渐变颜色[始点颜色, 结束颜色]
        colors: [Color(0xffaea0ff), Color(0xfff8f8f8)]);
  }

  static List<BoxShadow> getMainBoxShadow() {
    return const [
      BoxShadow(
        color: Color(0x09000000), //底色,阴影颜色
        offset: Offset(0, 2), //阴影位置,从什么位置开始
        blurRadius: 3, // 阴影模糊层度
        spreadRadius: 3, //阴影模糊大小
      )
    ];
  }

  static saveVideo(String url) async {
    try {
      var appDocDir = await getTemporaryDirectory();
      String savePath = appDocDir.path + "/temp.mp4";
      await Dio().download(url, savePath);
      final result = await ImageGallerySaver.saveFile(savePath);
      print(result);

      print("保存成功");
      EasyLoading.showToast("保存成功");
    } catch (e) {
      EasyLoading.showToast("保存失败");
    }
  }

  /// 保存图片到相册
  ///
  /// 默认为下载网络图片，如需下载资源图片，需要指定 [isAsset] 为 `true`。
  static Future<void> saveImage(String? imageUrl, {bool isAsset: false}) async {
    try {
      if (imageUrl == null) throw '保存失败，图片不存在！';

      /// 权限检测
      PermissionStatus storageStatus = await Permission.storage.status;
      if (storageStatus != PermissionStatus.granted) {
        storageStatus = await Permission.storage.request();
        if (storageStatus != PermissionStatus.granted) {
          throw '无法存储图片，请先授权！';
        }
      }

      /// 保存的图片数据
      Uint8List imageBytes;

      if (isAsset == true) {
        /// 保存资源图片
        ByteData bytes = await rootBundle.load(imageUrl);
        imageBytes = bytes.buffer.asUint8List();
      } else {
        /// 保存网络图片
        CachedNetworkImage image = CachedNetworkImage(imageUrl: imageUrl);
        DefaultCacheManager manager = DefaultCacheManager();
        // Map<String, String> headers = image.httpHeaders;
        File file = await manager.getSingleFile(
          image.imageUrl,
          // headers: headers,
        );
        imageBytes = await file.readAsBytes();
      }

      /// 保存图片
      final result = await ImageGallerySaver.saveImage(imageBytes);

      if (result == null || result == '') throw '图片保存失败';
      EasyLoading.showSuccess("保存成功");
      print("保存成功");
    } catch (e) {
      EasyLoading.showToast("保存失败");
      print(e.toString());
    }
  }

  // 弹出底部菜单包括举报，分享，收藏这些
  static Future<int?> showMorePop(BuildContext context,
      {Function? share, Function? notInterested}) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 180,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: "更多操作"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        share!();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff7687dd),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "分享",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        String url = "https://www.xiaowanwu.cn/safe/jubao";
                        AppUtil.getTo(LinkWebviewPage(url: url));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffff7700),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.warning,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "举报",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        notInterested!();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff00ff22),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.heart_broken,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "不感兴趣",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                        AppUtil.getTo(Fankui());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff7687dd),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.back_hand,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            const Text(
                              "反馈",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
