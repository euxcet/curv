import 'package:curv/pages/scan.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
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
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/start.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  AppUtil.getTo(ScanPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  width: 180,
                  height: 48,
                  alignment: Alignment.center,
                  child: MyText(
                    title: "开启旅程",
                    color: Colors.white,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Text("探索商城", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 70,
              height: 1,
              color: Colors.white,
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
