import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/models/user.dart';

import 'package:curv/pages/user/contactUs.dart';
import 'package:curv/pages/user/fankui.dart';
import 'package:curv/pages/user/inputInvitecode.dart';
import 'package:curv/pages/user/settingView.dart';
import 'package:curv/pages/user/vipView.dart';
import 'package:curv/pages/user/withUs.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';

class MineTabViewPage extends StatefulWidget {
  const MineTabViewPage({Key? key}) : super(key: key);

  @override
  _MineTabViewPageState createState() => _MineTabViewPageState();
}

class _MineTabViewPageState extends State<MineTabViewPage> {
  var list = [];
  User? user;
  int selectTab = 0;
  late PageController _pageController;
  String? time;
  bool showVip = false;

  ///see AutomaticKeepAliveClientMixin

  @override
  void initState() {
    getUser();
    _pageController = PageController(initialPage: selectTab, keepPage: true);
    // showVip = !Platform.isIOS;
    queryData();
  }

  void getUser() async {
    user = await StorageUtil.getUser();

    Map res = await Api2Service.getMyInviteCode(AppUtil.user!.id);
    // showVip = Platform.isIOS ? res["iosShowVip"] : true;

    setState(() {});
  }

  void queryData() async {
    await AppUtil.refreshUser();
    setState(() {});
    // Api2Service.userinfo().then((value) {
    //   StorageUtil.saveUser(value);
    //   getUser();
    // });
  }

  void registerHandler() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 86,
                    height: 86,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/avatar.png"),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyText(
                              title: "蓝蓝蓝",
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "images/female.png",
                              width: 10,
                            ),
                            SizedBox(width: 20),
                            MyText(
                              title: "2025-02-22",
                            ),
                            SizedBox(width: 10),
                            Image.asset(
                              "images/edit.png",
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0x3337AFFF),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MyText(
                                title: "清纯女大",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0x33F89D58),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MyText(
                                title: "天选牛马",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0x1AC34DC5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MyText(
                                title: "精致女王",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0x1AC34DC5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: MyText(
                                title: "清纯女大",
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color(0x1AC34DC5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Color(0xfff7f7f7)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyText(
                              title: "小蓝的AI Ring",
                            ),
                            SizedBox(width: 10),
                            Image.asset(
                              "images/edit.png",
                              width: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Color(0xff0FBE97),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            SizedBox(width: 10),
                            MyText(
                              title: "已连接",
                              color: Color(0xff999999),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              title: "CURV已经陪伴你",
                            ),
                            MyText(
                              title: "500",
                              fontSize: 30,
                            ),
                            MyText(
                              title: "天了",
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(10),
                          child: MyText(
                            title: "解除绑定",
                            color: Color(0xff999999),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "images/dianliang.png",
                              width: 20,
                            ),
                            MyText(
                              title: "30%",
                            )
                          ],
                        ),
                        Image.asset(
                          "images/jiezhi.png",
                          width: 91,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color(0xfff7f7f7)),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "images/shoushi.png",
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: MyText(
                              title: "自定义手势",
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "images/book-open.png",
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: MyText(
                              title: "操作说明",
                            ),
                          )),
                          Icon(
                            Icons.navigate_next,
                            color: Color(0xff999999),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "images/question.png",
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: MyText(
                              title: "问题反馈",
                            ),
                          )),
                          Icon(
                            Icons.navigate_next,
                            color: Color(0xff999999),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            "images/info.png",
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: MyText(
                              title: "关于CURV",
                            ),
                          )),
                          Icon(
                            Icons.navigate_next,
                            color: Color(0xff999999),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(10),
                child: MyText(
                  title: "退出登录",
                  color: Color(0xff999999),
                ),
              )
            ],
          ),
        )));
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

    var startPoint = const Offset(0, 60); //开始位置
    var controlPoint1 = Offset(size.width / 4, 0); //控制点
    var controlPoint2 = Offset(3 * size.width / 4, 0); //控制点
    var endPoint = Offset(size.width, 60); //结束位置

    var path = Path();

    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
