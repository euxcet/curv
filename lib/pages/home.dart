import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curv/pages/socket/scoketClient.dart';
import 'package:curv/pages/tabs/homeTabView.dart';
import 'package:curv/pages/tabs/mineTabView.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/event_bus.dart';
import 'package:curv/tools/message.dart';
import 'package:curv/tools/storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool check = false;
  bool enter = false;
  bool secretOpen = false;

  late TabController _tabController;
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> dataList = [];
  bool inited = false;

  final List<Map> _tabs = [
    {
      "name": "首页",
      "icon": "images/tabs/ai.png",
      "selectedIcon": "images/tabs/ai_sel.png",
    },
    {
      "name": "我的",
      "icon": "images/tabs/mine.png",
      "selectedIcon": "images/tabs/mine_sel.png",
    },
  ];
  late Map _selectedTab;
  bool _checkPwd = false; //是否显示输入框尾部的清除按钮
  int _currentIndex = 0;
  bool showTabbar = true;
  @override
  void initState() {
    super.initState();

    _selectedTab = _tabs[0];
    _pageController =
        PageController(initialPage: _currentIndex, keepPage: true);

    eventBus.on<HideKeyboard>().listen((event) {
      setState(() {
        showTabbar = true;
      });
    });

    _tabController = TabController(length: _tabs.length, vsync: this);
    init();
  }

  void _checkPwdHandler(check) async {
    setState(() {
      _checkPwd = check;
    });
  }

  void init() async {
    var user = await StorageUtil.getUser();
    if (user == null) {
      if (Platform.isIOS) {
        Map config = await Api2Service.getConfig();
        Map ios = config["ios"];
        if (ios["appstore_approve"]) {
          // 只是为审核
          Map user =
              await Api2Service.getUser("D7B82959FFFFFF836D61D255ED9B3896");
          await StorageUtil.saveUser(user);
          AppUtil.user = await StorageUtil.getUser();
          ScoketClient.init();
        }
      }
      // AppUtil.getReplaceTo(const LoginHomeViewPage());
    } else {
      AppUtil.user = user;
      // if (user!.figureid == 0 || user!.figureid == null) {
      //   //跳转到设置形象界面
      //   NavigatorUtil.goPageReplace(context, "/figure3dSetting");
      // } else {
      ScoketClient.init();
    }

    setState(() {
      inited = true;
    });
  }

  String timeFormat(String time) {
    DateTime nowTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(nowTime);
  }

  void unagreeHandler() {}

  void agreeHandler() async {
    if (!_checkPwd) {
      Message.info("请先阅读协议");
      return;
    }
    AppUtil.back();
    await StorageUtil.saveSecretOpen();
    AppUtil.getReplaceTo(const HomePage());
    // setState(() {
    //   secretOpen = true;
    //   enter = true;
    // });
    // init();
  }

  @override
  Widget build(BuildContext context) {
    // if (AppUtil.user == null) {
    //   return Container();
    // }
    if (!inited) {
      return Container();
    }
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;

    double size = 20;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(), // 禁止左右滑动切换页面
              controller: _pageController,
              children: [HomeTabViewPage(), MineTabViewPage()],
            ),
          ),
          !isKeyboardOpen
              ? Container(
                  color: const Color(0x0ff0f5f0),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 10,
                      top: 10),
                  child: Row(
                      children: _tabs.map((e) {
                    int index = _tabs.indexOf(e);

                    return Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            if (index == 1 || index == 4) {
                              if (!AppUtil.isLogin(context)) {
                                return;
                              }
                            }
                            _currentIndex = index;
                            _pageController.jumpToPage(index);
                            setState(() {});
                            if (index != 3) {
                              if (AppUtil.videoPlayerController != null) {
                                AppUtil.videoPlayerController!.pause();
                              }
                            } else {
                              if (AppUtil.videoPlayerController != null) {
                                AppUtil.videoPlayerController!.play();
                              }
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Image.asset(
                                  _currentIndex == index
                                      ? e["selectedIcon"]
                                      : e["icon"],
                                  width: size,
                                  color: _currentIndex == index
                                      ? AppConfig.mainColor
                                      : const Color(0xffaaaaaa),
                                  height: size,
                                ),
                                const SizedBox(height: 5),
                                MyText(
                                  title: e["name"],
                                  fontSize: 13,
                                  color: _currentIndex == index
                                      ? AppConfig.mainColor
                                      : const Color(0xffaaaaaa),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }).toList()),
                )
              : Container(),
        ],
      ),
    );
  }
}
