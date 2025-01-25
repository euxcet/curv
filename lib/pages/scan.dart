import 'package:curv/pages/user/loginHomeView.dart';
import 'package:curv/pages/user/loginView.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          leading: Container(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("绑定CURV",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  Text("正在扫描，请稍等...",
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 50,
                child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,

                    /// Required, The loading type of the widget
                    colors: const [Colors.white],

                    /// Optional, The color collections
                    strokeWidth: 2,

                    /// Optional, The stroke of the line, only applicable to widget which contains line

                    /// Optional, Background of the widget
                    pathBackgroundColor: Colors.black

                    /// Optional, the stroke backgroundColor
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                AppUtil.getTo(LoginHomeViewPage());
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
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
                    Text("扫描不到或者连接不上？",
                        style:
                            TextStyle(color: Color(0xffE33636), fontSize: 14)),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 154,
                      height: 1,
                      color: Color(0xffE33636),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
