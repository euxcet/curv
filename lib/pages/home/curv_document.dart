import 'dart:io';

import 'package:curv/pages/home/curv_run_item.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:curv/tools/AppUtil.dart';

class CurvDocument extends StatefulWidget {
  const CurvDocument({Key? key}) : super(key: key);

  @override
  _CurvDocumentState createState() => _CurvDocumentState();
}

class _CurvDocumentState extends State<CurvDocument> {
  var list = [];

  ///see AutomaticKeepAliveClientMixin

  @override
  void initState() {
    super.initState();
  }

  void queryData() async {
    await AppUtil.refreshUser();
    setState(() {});
    // Api2Service.userinfo().then((value) {
    //   StorageUtil.saveUser(value);
    //   getUser();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          title: MyText(
            title: "CURV档案",
          ),
          elevation: 0.0,
          toolbarHeight: 50,
          actions: [],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              MyText(
                title: "健康数据",
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: "身高",
                          color: Color(0xff999999),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            MyText(
                              title: "160",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "cm",
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Color(0xffaaaaaa),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: "身高",
                          color: Color(0xff999999),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            MyText(
                              title: "160",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "cm",
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Color(0xffaaaaaa),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: "步长",
                          color: Color(0xff999999),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            MyText(
                              title: "60",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "kg",
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/file.png",
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            MyText(
                              title: "健康指数",
                              fontSize: 12,
                              color: Color(0xff999999),
                            ),
                            Row(
                              children: [
                                MyText(
                                  title: "80",
                                  fontSize: 20,
                                ),
                                MyText(
                                  title: "分",
                                  fontSize: 12,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/age.png",
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            MyText(
                              title: "身体年龄",
                              fontSize: 12,
                              color: Color(0xff999999),
                            ),
                            Row(
                              children: [
                                MyText(
                                  title: "32",
                                  fontSize: 20,
                                ),
                                MyText(
                                  title: "岁",
                                  fontSize: 12,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                    title: "代谢健康",
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "images/question.png",
                        width: 15,
                      ))
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "基础代谢",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "1450",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "大卡/天",
                              color: Color(0xff999999),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "日常消耗",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "2100",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "大卡/天",
                              color: Color(0xffaaaaaa),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "运动代谢",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "中等",
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Color(0xff888888),
                    ),
                    SizedBox(height: 20),
                    MyText(
                      title: "健康建议：适度运动可提升代谢效率",
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                    title: "运动追踪",
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "images/question.png",
                        width: 15,
                      ))
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Color(0x1AFF854D)),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "平均心率",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "135",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "次/分钟",
                              color: Color(0xff999999),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "平均燃脂",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "350",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "大卡/小时",
                              color: Color(0xffaaaaaa),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "心肺功能",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "良好",
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "运动疲劳",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "中等",
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Color(0xff888888),
                    ),
                    SizedBox(height: 20),
                    MyText(
                      title: "运动建议：运动后朵朵拉伸，缓解肌肉疲劳",
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                    title: "睡眠质量",
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "images/question.png",
                        width: 15,
                      ))
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Color(0x1A37AFFF)),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "平均睡眠",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "5",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "小时/天",
                              color: Color(0xff999999),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "觉醒次数",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "2",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "次/夜",
                              color: Color(0xffaaaaaa),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "深度睡眠",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "25%",
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "觉醒状态",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "较好",
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Color(0xff888888),
                    ),
                    SizedBox(height: 20),
                    MyText(
                      title: "睡眠建议：睡前喝一杯牛奶有助于快速入眠",
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  MyText(
                    title: "情绪调节",
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "images/question.png",
                        width: 15,
                      ))
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: Color(0x1AFF854D)),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "负面情绪",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "5",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "小时/天",
                              color: Color(0xff999999),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "压力触点",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "10:30",
                              fontSize: 20,
                            ),
                            MyText(
                              title: "上午频繁",
                              color: Color(0xffaaaaaa),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "情绪纬度",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "积极",
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Color(0xffaaaaaa),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              title: "情绪波动",
                              color: Color(0xff999999),
                            ),
                            SizedBox(height: 5),
                            MyText(
                              title: "稳定",
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Color(0xff888888),
                    ),
                    SizedBox(height: 20),
                    MyText(
                      title: "情绪建议：在上午多晒晒太阳有助于驱逐坏心情",
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
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
