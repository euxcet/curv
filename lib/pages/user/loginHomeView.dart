import 'dart:async';

import 'package:curv/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/user/loginView.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHomeViewPage extends StatefulWidget {
  const LoginHomeViewPage({Key? key}) : super(key: key);

  @override
  _LoginHomeViewPageState createState() => _LoginHomeViewPageState();
}

class _LoginHomeViewPageState extends State<LoginHomeViewPage> {
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassWord = FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _vcodeController = TextEditingController();

  //表单状态
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _username = ''; // 用户名
  final _password = ''; // 验证码
  final _rightCode = '';
  int loginType = 0;

  final _isShowPwd = false; //是否显示验证码
  final _isShowClear = false; //是否显示输入框尾部的清除按钮
  bool _checkAgreement = false; //是否显示输入框尾部的清除按钮

  Timer? _timer;
  int seconds = 60;
  bool isWechatInstalled = false;
  bool passwordLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
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

  void registerHandler() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          leading: Container(),
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light)),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/scan.png"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 200,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/circle.png"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      title: "设备1",
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      "images/jiezhi.png",
                      width: 92,
                      height: 92,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/power.png",
                          width: 68,
                          height: 22,
                        ),
                        MyText(
                          title: "32%",
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
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
                    Text(
                      "CURV,",
                      style: TextStyle(color: Colors.black, fontSize: 36),
                    ),
                    Text(
                      "记录美一刻",
                      style: TextStyle(color: Colors.black, fontSize: 36),
                    ),
                    const SizedBox(height: 50),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        AppUtil.getTo(const LoginViewPage());
                      },
                      child: Container(
                          width: 180,
                          height: 48,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              boxShadow: AppUtil.getMainBoxShadow(),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.black),
                          child: MyText(
                            title: "注册/登录",
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          AppUtil.getTo(HomePage());
                        },
                        child: MyText(
                          title: "暂时跳过",
                          color: Color(0xff999999),
                        )),
                    const SizedBox(height: 40),
                  ],
                ),
              ))

              // InkWell(
              //   onTap: () {
              //     AppUtil.getTo(const RegisterViewPage());
              //   },
              //   child: Container(
              //       width: MediaQuery.of(context).size.width * 0.70,
              //       padding: const EdgeInsets.all(15),
              //       decoration: BoxDecoration(
              //           boxShadow: AppUtil.getMainBoxShadow(),
              //           borderRadius: BorderRadius.circular(13),
              //           color: const Color(0xffFFffff)),
              //       child: MyText(
              //         title: "注册",
              //         color: const Color(0xffA59DFF),
              //       )),
              // ),
            ],
          )),
    );
  }
}
