import 'package:curv/pages/home/curv_document.dart';
import 'package:curv/pages/home/curv_run_item.dart';
import 'package:curv/pages/user/loginHomeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/resource/deploy.dart';
import 'package:curv/pages/widgets/MyButton.dart';

import 'package:curv/pages/widgets/MyText.dart';

import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/event_bus.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DaylyPage extends StatefulWidget {
  const DaylyPage({Key? key}) : super(key: key);

  @override
  _DaylyPageState createState() => _DaylyPageState();
}

class _DaylyPageState extends State<DaylyPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var list = [
    {
      "id": 1,
      "title": "你跑了3km，达成了今日有氧目标！",
      "kilo": 3000,
      "hot": 300,
      "time": 30
    }
  ];

  int nowIndex = 0;
  bool keyboardShow = false;
  late SwiperController swiperController;

  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///see AutomaticKeepAliveClientMixin

  @override
  void initState() {
    super.initState();
    swiperController = SwiperController();
    eventBus.on<SocketEvent>().listen((event) {
      //queryData();
    });
    print("home initState");
    initData();
    // selectCate = cates[0];
    queryData();
    //this.queryChatCircle();
  }

  initData() async {}

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  void queryData() async {
    list = await Api2Service.queryTodays();
    int a = 0;
    setState(() {});
  }

  void _onPageChange(int index) {
    nowIndex = index;
    setState(() {});
    // _tabController?.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    AppConfig.actionChatHeight = size.height -
        MediaQuery.of(context).padding.top -
        AppConfig.messageLatestHeight -
        AppConfig.bottomBarHeight -
        80;

    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 50,
          title: MyText(
            title: "CURV日记",
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        AppUtil.getTo(CurvDocument());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFCC),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Image.asset(
                              "images/sun.png",
                              width: 20,
                              height: 20,
                            ),
                            Column(
                              children: [
                                MyText(title: "CURV档案"),
                                MyText(
                                  title: "你的健康档案",
                                  color: Color(0xff999999),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                        color: Color(0xFFFFFFCC),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/sun.png",
                          width: 20,
                          height: 20,
                        ),
                        Column(
                          children: [
                            MyText(title: "CURV日记"),
                            MyText(
                              title: "你的精致日记",
                              color: Color(0xff999999),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyText(
                          title: "今日CURV",
                        ),
                        SizedBox(width: 20),
                        MyText(
                          title: "未记录（0）",
                          color: Color(0xff999999),
                        ),
                        Spacer(),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.navigate_before),
                              MyText(
                                title: "01.17 周五",
                                color: Color(0xff000000),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Expanded(
                        child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            onLoading: _onLoading,
                            cacheExtent: 1000,
                            physics: const BouncingScrollPhysics(),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              itemBuilder: (context, index) {
                                return CurvRunItem();
                              },
                              itemCount: list.length,
                            ))),
                    list.length == 0
                        ? Image.asset("images/empty.png", height: 150)
                        : Container(),
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // 阴影颜色，透明度调整
                              spreadRadius: 5, // 阴影扩散范围
                              blurRadius: 7, // 模糊程度
                              offset: Offset(3, 3), // 阴影偏移
                            ),
                          ],
                          color: Colors.white),
                      child: Row(
                        children: [
                          MyText(
                            title: "注册登录，解锁更多CURV精彩",
                          ),
                          Spacer(),
                          MyButton(
                            "去登录",
                            onTap: () {
                              AppUtil.getTo(LoginHomeViewPage());
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
