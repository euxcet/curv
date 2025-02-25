import 'dart:io';

import 'package:curv/pages/home/curv_run_item.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:curv/tools/AppUtil.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
            title: "CURV一下",
          ),
          elevation: 0.0,
          toolbarHeight: 50,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "images/chat.png",
                  width: 20,
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),

          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(20),
                child: CurvRunItem(),
              ),
              Expanded(child: Column()),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5)),
                    height: 38,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "images/record.png",
                      width: 30,
                    ),
                  )
                ]),
              )
            ]),
          ),
        ));
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
