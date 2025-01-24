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
import 'package:flutter_svg/svg.dart';

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

  void showMenu() {
    //iOS
    showDialog<void>(
        context: context,
        useSafeArea: false,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.only(top: 100, right: 30),
                decoration: BoxDecoration(
                    color: const Color(0x33000000),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/main/jinxing.png",
                                  width: 26,
                                  height: 26,
                                  color: const Color(0xff63B4F3),
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 10),
                                MyText(
                                  title: "金星",
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: const Color(0xffeeeeee),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/main/jinxing.png",
                                    width: 26,
                                    height: 26,
                                    color: const Color(0xff63B4F3),
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 10),
                                  MyText(
                                    title: "水星",
                                    color: Colors.black,
                                  )
                                ],
                              )),
                          const SizedBox(height: 10),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: const Color(0xffeeeeee),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.of(context).pop();
                                AppUtil.getTo(const SettingViewPage());
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/main/settingblue.png",
                                    width: 26,
                                    height: 26,
                                    color: const Color(0xff63B4F3),
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 10),
                                  MyText(
                                    title: "设置",
                                    color: Colors.black,
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

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
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Container(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.6 + 100,
                  decoration:
                      BoxDecoration(gradient: AppUtil.getMainLinearGradient()),
                  padding: EdgeInsets.fromLTRB(
                      AppUtil.getPadding(),
                      AppUtil.getPadding() +
                          MediaQuery.of(context).padding.top +
                          20,
                      AppUtil.getPadding(),
                      20),
                ),
                Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                        //路径裁切组件
                        painter: Sky(),
                        child: Container(
                          height: 60,
                        ))),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(color: Colors.white, height: 100)),
                Positioned(
                    bottom: 0,
                    left: AppUtil.getPadding(),
                    right: AppUtil.getPadding(),
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 160,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        AppUtil.user?.nickname ?? "",
                                        maxLines: 4,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "ID:" +
                                                AppUtil.user!.nickname
                                                    .toString(),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: AppConfig.font3),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF5FAFF),
                                  borderRadius: BorderRadius.circular(20)),
                              child: MyText(
                                title: "这个人有点懒，还没有什么值得记录的",
                                color: AppConfig.font3,
                              ),
                            ),
                          ],
                        ))),
                Positioned(
                    right: AppUtil.getPadding() + 10,
                    top: 60,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        AppUtil.getTo(const SettingViewPage());
                      },
                      child: Image.asset("images/shezhi.png",
                          width: 35, height: 35, fit: BoxFit.cover),
                    ))
              ]),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(
                    AppUtil.getPadding(), 10, AppUtil.getPadding(), 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showVip
                        ? GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              AppUtil.getTo(const Fankui());
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    AppUtil.getTo(const VipView());
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/viplogo.png",
                                          width: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        MyText(
                                          title: (AppUtil.user!.vipcate == 0 ||
                                                  AppUtil.user!.vipcate == null)
                                              ? "开通会员"
                                              : (AppUtil.user!.vipcate
                                                      .toString() +
                                                  "级会员"),
                                          fontSize: 14,
                                          weight: (AppUtil.user!.vipcate == 0 ||
                                                  AppUtil.user!.vipcate == null)
                                              ? null
                                              : FontWeight.bold,
                                        )
                                      ],
                                    ),
                                  ),
                                )))
                        : Container(),
                    showVip
                        ? GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              AppUtil.getTo(const InputInvitecode());
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Image.asset(
                                  //   "images/main/jianyue.png",
                                  //   width: 20,
                                  //   height: 20,
                                  // ),
                                  const SizedBox(width: 5),
                                  MyText(
                                    title: "输入邀请码",
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.navigate_next)
                                ],
                              ),
                            ))
                        : Container(),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          AppUtil.getTo(const Fankui());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image.asset(
                              //   "images/main/jianyue.png",
                              //   width: 20,
                              //   height: 20,
                              // ),
                              const SizedBox(width: 5),
                              MyText(
                                title: "意见反馈",
                              ),
                              const Spacer(),
                              const Icon(Icons.navigate_next)
                            ],
                          ),
                        )),

                    // Container(height: 1, color: AppConfig.grayBgColor),
                    // GestureDetector(
                    //     behavior: HitTestBehavior.opaque,
                    //     onTap: () {},
                    //     child: Container(
                    //       padding: const EdgeInsets.all(10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           // Image.asset(
                    //           //   "images/main/jianyue.png",
                    //           //   width: 20,
                    //           //   height: 20,
                    //           // ),
                    //           const SizedBox(width: 5),
                    //           MyText(
                    //             title: "简约模式",
                    //           ),
                    //           const Spacer(),
                    //           const Icon(Icons.navigate_next)
                    //         ],
                    //       ),
                    //     )),
                    // Container(height: 1, color: AppConfig.grayBgColor),
                    // GestureDetector(
                    //     behavior: HitTestBehavior.opaque,
                    //     onTap: () {},
                    //     child: Container(
                    //       padding: const EdgeInsets.all(10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           // Image.asset(
                    //           //   "images/main/secai.png",
                    //           //   width: 20,
                    //           //   height: 20,
                    //           // ),
                    //           const SizedBox(width: 5),
                    //           MyText(
                    //             title: "色彩模式",
                    //           ),
                    //           const Spacer(),
                    //           const Icon(Icons.navigate_next)
                    //         ],
                    //       ),
                    //     )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(0),
                margin: AppUtil.getCommonPadding(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(height: 1, color: AppConfig.grayBgColor),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          String url = Uri.encodeComponent(
                              "https://www.xiaowanwu.cn/safe/mysecret");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image.asset(
                              //   "images/main/shouji.png",
                              //   width: 20,
                              //   height: 20,
                              // ),
                              const SizedBox(width: 5),
                              MyText(title: "隐私政策"),
                              const Spacer(),
                              const Icon(Icons.navigate_next)
                            ],
                          ),
                        )),
                    Container(height: 1, color: AppConfig.grayBgColor),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          AppUtil.getTo(const WithUs());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image.asset(
                              //   "images/main/guanyu.png",
                              //   width: 20,
                              //   height: 20,
                              // ),
                              const SizedBox(width: 5),
                              MyText(title: "关于我们"),
                              const Spacer(),
                              const Icon(Icons.navigate_next)
                            ],
                          ),
                        )),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          AppUtil.getTo(const ContactUs());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image.asset(
                              //   "images/main/guanyu.png",
                              //   width: 20,
                              //   height: 20,
                              // ),
                              const SizedBox(width: 5),
                              MyText(title: "联系我们"),
                              const Spacer(),
                              const Icon(Icons.navigate_next)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
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
