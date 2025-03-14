import 'package:curv/pages/data/blood_page.dart';
import 'package:curv/pages/data/heart_bian_page.dart';
import 'package:curv/pages/data/heart_page.dart';
import 'package:curv/pages/data/hot_page.dart';
import 'package:curv/pages/data/press.dart';
import 'package:curv/pages/data/press_page.dart';
import 'package:curv/pages/data/sleep_page.dart';
import 'package:curv/pages/data/step_page.dart';
import 'package:curv/pages/data/temp_page.dart';
import 'package:curv/pages/widgets/ProgressBar.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:curv/pages/widgets/MyText.dart';

import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/event_bus.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DataTabView extends StatefulWidget {
  const DataTabView({Key? key}) : super(key: key);

  @override
  _DataTabViewState createState() => _DataTabViewState();
}

class _DataTabViewState extends State<DataTabView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var list = [];

  int tab = 0;
  bool keyboardShow = false;
  late SwiperController swiperController;

  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List sports = [
    {"image": "images/yujia.png", "name": "瑜伽\n普拉提"},
    {"image": "images/wudao.png", "name": "舞蹈\n健身操"},
    {"image": "images/qiulei.png", "name": "球类"},
    {"image": "images/paobu.png", "name": "跑步"},
    {"image": "images/huwai.png", "name": "户外"},
    {"image": "images/wuyang.png", "name": "无氧"}
  ];

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title: "数据检测",
                fontSize: 24,
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff000000)),
                    borderRadius: BorderRadius.circular(20)),
                child: MyText(
                  title: "立即测量",
                ),
              )
            ],
          ),
          leadingWidth: 0,
          toolbarHeight: 50,
          leading: Container(),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 阴影颜色
                      offset: Offset(4, 4), // 阴影的偏移
                      blurRadius: 10, // 阴影的模糊半径
                      spreadRadius: 1, // 阴影的扩散半径
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xffB561FF),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "images/sunset.png",
                            width: 28,
                          ),
                        ),
                        SizedBox(width: 10),
                        MyText(
                          title: "压力",
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MyText(title: "当前"),
                        MyText(
                          title: "62",
                          fontSize: 30,
                        ),
                        MyText(title: "偏高"),
                      ],
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Press(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyText(title: "基本数据"),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(HotPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.asset(
                                  "images/huo.png",
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "热量",
                                  fontSize: 16,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "1200",
                                  fontSize: 24,
                                ),
                                MyText(
                                  title: "千卡",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xffFF9F45),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      color: Color(0xffFF9F45),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xffFF9F45),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 30,
                                      color: Color(0xffFF9F45),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(SleepPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.asset(
                                  "images/sleep.png",
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "睡眠",
                                  fontSize: 16,
                                )
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "7",
                                  fontSize: 24,
                                ),
                                MyText(
                                  title: "时",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                                MyText(
                                  title: "37",
                                  fontSize: 24,
                                ),
                                MyText(
                                  title: "分",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 50,
                                      color: Color(0x664287FF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 50,
                                      color: Color(0xff4287FF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: Color(0xffFFA361),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: Color(0xff4287FF),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      color: Color(0xffFFA361),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    color: Color(0x664287FF),
                                  ),
                                  SizedBox(width: 4),
                                  MyText(
                                    title: "浅睡眠",
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(TempPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0XFF61CAFF),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.asset(
                                    "images/temp.png",
                                    width: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "体温",
                                  fontSize: 16,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "36.4",
                                  fontSize: 24,
                                ),
                                MyText(
                                  title: "°C",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/ind.png",
                                          width: 12,
                                          height: 12,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: Color(0x6637AFFF),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 40,
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: Color(0xaa37AFFF),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 40,
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: Color(0xff37AFFF),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        MyText(
                                          title: "低温",
                                          color: Color(0xff999999),
                                        ),
                                        MyText(
                                          title: "正常",
                                          color: Color(0xff999999),
                                        ),
                                        MyText(
                                          title: "高温",
                                          color: Color(0xff999999),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(PressPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.asset(
                                  "images/download.png",
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "压力",
                                  fontSize: 16,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "60",
                                  fontSize: 24,
                                ),
                                SizedBox(width: 10),
                                MyText(
                                  title: "偏高",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                )
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 100,
                                child: Press(),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(HeartPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFff221F),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.asset(
                                    "images/heart.png",
                                    width: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "心率",
                                  fontSize: 16,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "92",
                                  fontSize: 24,
                                ),
                                SizedBox(width: 10),
                                MyText(
                                  title: "次/分钟",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                )
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                height: 80,
                                child: Press(),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(BloodPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Image.asset(
                                  "images/huo.png",
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "血氧",
                                  fontSize: 16,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "78",
                                  fontSize: 24,
                                ),
                                MyText(
                                  title: "%",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xff0FBE97),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xff0FBE97),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      color: Color(0xff0FBE97),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xff0FBE97),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 30,
                                      color: Color(0xff0FBE97),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(HeartBianPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFffffff),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.asset(
                                    "images/xinlv.png",
                                    width: 25,
                                  ),
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "心率变异性",
                                  fontSize: 12,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 12,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "38",
                                  fontSize: 24,
                                ),
                                SizedBox(width: 10),
                                MyText(
                                  title: "毫秒",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                )
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xffFF6161),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      color: Color(0xffFF6161),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xffFF6161),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 30,
                                      color: Color(0xffFF6161),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          AppUtil.getTo(StepPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 阴影颜色
                                offset: Offset(4, 4), // 阴影的偏移
                                blurRadius: 10, // 阴影的模糊半径
                                spreadRadius: 1, // 阴影的扩散半径
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFFFC861),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.asset(
                                    "images/step2.png",
                                    width: 25,
                                  ),
                                ),
                                SizedBox(width: 5),
                                MyText(
                                  title: "步数",
                                  fontSize: 16,
                                ),
                                Spacer(),
                                MyText(
                                  title: "3min前",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                MyText(
                                  title: "1000",
                                  fontSize: 24,
                                ),
                                MyText(
                                  title: "步",
                                  fontSize: 16,
                                  color: Color(0xffaaaaaa),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xffC64EC8),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      color: Color(0xffC64EC8),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 10,
                                      color: Color(0xffC64EC8),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 30,
                                      color: Color(0xffC64EC8),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 50,
                                    color: Color(0xfff7f7f7),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          )),
        ));
  }
}
