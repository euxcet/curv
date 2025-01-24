import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/home.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/apiService.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/message.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({Key? key}) : super(key: key);

  @override
  _LoginViewPageState createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassWord = FocusNode();
  final FocusNode _inviteNode = FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _inviteController = TextEditingController();

  //表单状态
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _rightCode = '';

  final _isShowPwd = false; //是否显示验证码
  final _isShowClear = false; //是否显示输入框尾部的清除按钮
  bool _checkAgreement = false; //是否显示输入框尾部的清除按钮

  Timer? _timer;
  int seconds = 60;
  bool isWechatInstalled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFlux();

    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
      if (res is fluwx.WeChatAuthResponse) {
        int errCode = res.errCode;
        print('微信登录返回值：ErrCode :$errCode  code:${res.code}');
        if (errCode == 0) {
          String? code = res.code;
          EasyLoading.show();
          ApiService.loginByWeixin(code).then((value) {
            StorageUtil.saveUser(value);
            EasyLoading.dismiss();
            AppUtil.getTo(HomePage());
            // ApiServic
            Message.info("微信授权成功");
          }).catchError((e) {
            Message.error("登录错误");
          });
        } else if (errCode == -4) {
          Message.info("用户拒绝授权");
        } else if (errCode == -2) {
          Message.info("用户取消授权");
        }
      }
    });
  }

  void initFlux() async {
    var result = await fluwx.isWeChatInstalled;
    setState(() {
      isWechatInstalled = result;
    });
  }

  void wechatLoginClick() {
    if (!_checkAgreement) {
      Message.info("请阅读并同意用户协议");
      return;
    }
    fluwx
        .sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
        .then((data) {
      if (!data) {
        Message.info('没有安装微信，请安装微信后使用该功能');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }

    super.dispose();
  }

  void _checkAgreementHandler(check) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _checkAgreement = check;
    });
  }

  // 监听焦点
  Future<void> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      // 取消验证码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  /// 验证用户名
  String? validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    }
    // else if (!exp.hasMatch(value)) {
    //   return '请输入正确手机号';
    // }
    return null;
  }

  /// 验证验证码
  String? validatePassWord(value) {
    if (value.isEmpty) {
      return '验证码不能为空';
    }
    return null;
  }

  void sendCodeHandler() {
    if (!_checkAgreement) {
      Message.info("请阅读并同意用户协议");
      return;
    }
    if (seconds != 60) {
      return;
    }
    setState(() {
      seconds--;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds < 1) {
          timer.cancel();
          setState(() {
            seconds = 60;
          });
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );

    if (_userNameController.text.isEmpty) {
      EasyLoading.showError("请输入手机号");
      return;
    }
    ApiService.sendCode(_userNameController.text).then((value) {
      print("value");
      _rightCode = value["vcode"];
      debugPrint("_rightCode==" + _rightCode);
    }).catchError((e) {
      EasyLoading.showError("用户名或者验证码错误");
    });
  }

  void loginHandler() {
    //点击登录按钮，解除焦点，回收键盘
    _focusNodePassWord.unfocus();
    _focusNodeUserName.unfocus();
    if (_userNameController.text.isEmpty) {
      EasyLoading.showError("请输入手机号");
      return;
    }

    if (_passWordController.text.isEmpty) {
      EasyLoading.showError("请输入验证码");
      return;
    }

    if (!_checkAgreement) {
      Message.info("请阅读并同意用户协议");
      return;
    }
    ApiService.login(_userNameController.text, _passWordController.text,
            _inviteController.text)
        .then((value) {
      StorageUtil.saveUser(value);
      // ApiServic
      EasyLoading.showSuccess("登录成功");
    }).catchError((e) {
      EasyLoading.showError("系统错误");
    });
  }

  void registerHandler() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              AppUtil.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark)),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/scan.png"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  MyText(
                    title: "CURV登录",
                    color: const Color(0xffffffff),
                    fontSize: 30,
                    weight: FontWeight.bold,
                  ),
                  MyText(
                    title: "未注册的手机号验证通过后将自动注册",
                    color: const Color(0xffffffff),
                    fontSize: 16,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/phone.png",
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 5),
                      MyText(
                        title: "手机号码",
                        color: const Color(0xffffffff),
                        fontSize: 16,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 48,
                      decoration: BoxDecoration(
                          color: const Color(0xffFAFAFA),
                          borderRadius: BorderRadiusDirectional.circular(0)),
                      child: TextField(
                        controller: _userNameController,
                        focusNode: _focusNodeUserName,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "请输入手机号",
                            hintStyle: TextStyle(color: Color(0xff999999))),
                      )),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        "images/pocket.png",
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 5),
                      MyText(
                        title: "验证码",
                        color: const Color(0xffffffff),
                        fontSize: 16,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      height: 48,
                      decoration: BoxDecoration(
                          color: const Color(0xffFAFAFA),
                          borderRadius: BorderRadiusDirectional.circular(0)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: _passWordController,
                            focusNode: _focusNodePassWord,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "请输入验证码",
                                hintStyle: TextStyle(color: Color(0xff999999))),
                          )),
                          MyButton(
                              (seconds == 60
                                  ? "发送验证码"
                                  : (seconds.toString() + "秒")),
                              fontSize: 13,
                              width: 100,
                              backgroundColor: 0xff000000,
                              radius: 0,
                              onTap: sendCodeHandler)
                        ],
                      )),
                  SizedBox(height: 50),
                ],
              )),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0x00ffffff),
                    Color(0xffffffff),
                    Color(0xffffffff)
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      loginHandler();
                    },
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Color(0xffD9D9D9)),
                        child: MyText(
                          title: "登录",
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                          value: _checkAgreement,
                          activeColor: Colors.black, // 选中时的颜色
                          checkColor: Colors.white, // 复选框中勾选的颜色
                          shape: CircleBorder(), // 使复选框为圆形

                          onChanged: _checkAgreementHandler),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            children: [
                              TextSpan(
                                text: '已阅读并同意', // 这个部分文本是蓝色并加粗
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              ),
                              TextSpan(
                                text: '用户协议', // 这个部分文本是绿色并斜体
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff000000)),
                              ),
                              TextSpan(
                                text: '和', // 这个部分文本是绿色并斜体
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              ),
                              TextSpan(
                                text: '隐私政策', // 这个部分文本是绿色并斜体
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff000000)),
                              ),
                              TextSpan(
                                text: '以及', // 这个部分文本是绿色并斜体
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              ),
                              TextSpan(
                                text: '运营商服务协议', // 这个部分文本是绿色并斜体
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff000000)),
                              ),
                              TextSpan(
                                text: '运营商将对你提供的手机号进行验证', // 这个部分文本是绿色并斜体
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Sky extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.white //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    // ..isAntiAlias = true //是否启动抗锯齿
    // ..blendMode = BlendMode.exclusion //颜色混合模式
    ..style = PaintingStyle.fill //绘画风格，默认为填充
    // ..colorFilter = ColorFilter.mode(Colors.redAccent,
    //     BlendMode.exclusion) //颜色渲染模式，一般是矩阵效果来改变的,但是flutter中只能使用颜色混合模式
    // ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果，flutter中只有这个
    ..filterQuality = FilterQuality.high //颜色渲染模式的质量
    ..strokeWidth = 1.0; //

  @override
  void paint(Canvas canvas, Size size) {
    // Path path = new Path();
    // path.moveTo(0, 0);
    // path.lineTo(100, 100);
    // path.lineTo(200, 200);
    // path.lineTo(0, 0);
    // path.close();
    // canvas.drawPath(path, _paint);
    // canvas.drawCircle(Offset(100, 100), 50, _paint);
    canvas.drawLine(
        const Offset(20.0, 20.0), const Offset(100.0, 100.0), _paint);
    const PI = 3.1415926;
    // Rect rect2 = Rect.fromCircle(center: Offset(100.0, 50.0), radius: 200.0);
    // canvas.drawArc(rect2, -PI, PI, false, _paint,);

    // Rect rect1 = Rect.fromPoints(Offset(150.0, 200.0), Offset(300.0, 250.0));
    // canvas.drawOval(rect1, _paint);

    var startPoint = const Offset(0, 0); //开始位置
    var controlPoint2 = Offset(size.width / 4, size.height * 0.7); //控制点
    var controlPoint1 = Offset(3 * size.width / 4, size.height * 0.7); //控制点
    var endPoint = Offset(size.width, 0); //结束位置

    var path = Path();

    path.moveTo(startPoint.dx, startPoint.dy);
    path.lineTo(startPoint.dx, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.moveTo(size.width, 0);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, 0, 0);

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
