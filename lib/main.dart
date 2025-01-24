import 'package:curv/pages/start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/home.dart';
import 'package:curv/tools/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'common/color.dart';

import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:fluwx/fluwx.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  AppConfig.init();

  runApp(const MyApp());
  registerWxApi(
      appId: AppConfig.WXAppId, universalLink: AppConfig.UniversalLink);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, //这里替换你选择的颜色
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color primaryColor = Colors.tealAccent;

  @override
  void initState() {
    // WindowManager windowManager = (WindowManager) applicationContext.getSystemService(Context.WINDOW_SERVICE))
    // float fps = windowManager.getDefaultDisplay().getRefreshRate();
    // setMode();
  }

  void setMode() async {
    try {
      var modes = await FlutterDisplayMode.supported;
      modes.forEach(print);

      await FlutterDisplayMode.setPreferredMode(modes[1]);

      await FlutterDisplayMode.setHighRefreshRate();

      // setFrameRate(90);

      /// On OnePlus 7 Pro:
      /// #0 0x0 @0Hz // Automatic
      /// #1 1080x2340 @ 60Hz
      /// #2 1080x2340 @ 90Hz
      /// #3 1440x3120 @ 90Hz
      /// #4 1440x3120 @ 60Hz

      /// On OnePlus 8 Pro:
      /// #0 0x0 @0Hz // Automatic
      /// #1 1080x2376 @ 60Hz
      /// #2 1440x3168 @ 120Hz
      /// #3 1440x3168 @ 60Hz
      /// #4 1080x2376 @ 120Hz
    } on PlatformException {
      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
    }
  }

  @override
  Widget build(BuildContext context) {
    final easyload = EasyLoading.init();

    return RefreshConfiguration(
        headerBuilder: () => ClassicHeader(
              height: 45.0,
              releaseText: '松开手刷新',
              refreshingText: '刷新中...',
              completeText: '刷新完成',
              failedText: '刷新失败',
              idleText: '下拉刷新',
              // refreshingIcon: Container(
              //   height: 45,
              //   child: Lotti.asset('assets/loading.json'),
              // ),
            ),
        // 配置头部默认下拉刷新视图
        footerBuilder: () => ClassicFooter(
            loadingText: "加载中",
            noDataText: "",
            failedText: "失败",
            idleText: "加载更多",
            canLoadingText: "更够加载更多"),
        // 配置底部默认上拉加载视图
        headerTriggerDistance: 80.0,
        // 头部触发刷新的距离
        springDescription:
            SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        // 自定义弹回动画
        maxOverScrollExtent: 100,
        //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
        maxUnderScrollExtent: 0,
        // Maximum dragging range at the bottom
        enableScrollWhenRefreshCompleted: true,
        //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
        enableLoadingWhenFailed: true,
        //In the case of load failure, users can still trigger more loads by gesture pull-up.
        hideFooterWhenNotFull: false,
        // Disable pull-up to load more functionality when Viewport is less than one screen
        enableBallisticLoad: true,
        // trigger load more by BallisticScrollActivity
        child: GetMaterialApp(
          title: 'CURV',
          builder: (BuildContext context, Widget? child) {
            return easyload(context, child);
          },
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: createMaterialColor(AppConfig.mainColor),
              primaryColor: AppConfig.mainColor,
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                      color: Color.fromARGB(255, 65, 57, 57), fontSize: 20.0),
                  color: Colors.white)),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate, //指定本地化的字符串和一些其他的值
            GlobalWidgetsLocalizations.delegate, //定义 widget 默认的文本方向，从左到右或从右到左。
          ],
          supportedLocales: const [
            Locale('zh', 'CH'),
            Locale('en', 'US'),
          ],
          home: StartPage(),
          // supportedLocales: const <Locale>[
          //   Locale('zh'), // Chinese
          //   // Locale('iw'), // Hebrew
          // ],
          // locale: const Locale('zh')
        ));
  }
}
