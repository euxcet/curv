import 'package:curv/pages/home/curv_run_item.dart';
import 'package:curv/pages/widgets/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/widgets/MyButton.dart';

import 'package:curv/pages/widgets/MyText.dart';

import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/event_bus.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActiveTabView extends StatefulWidget {
  const ActiveTabView({Key? key}) : super(key: key);

  @override
  _ActiveTabViewState createState() => _ActiveTabViewState();
}

class ChartData {
  final String? x;
  final double? y;
  final Color? pointColor;
  final String? text;
  ChartData(this.x, this.y, this.pointColor, this.text);
}

class _ActiveTabViewState extends State<ActiveTabView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var list = [];

  int tab = 0;
  int tab2 = 0;

  bool keyboardShow = false;
  late SwiperController swiperController;

  @override
  bool get wantKeepAlive => true;
  List<ChartData> chartData = [];
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
    chartData = [
      ChartData("全部计划", 10, Color(0xff0FBE97), "h1"),
    ];
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          leadingWidth: 0,
          toolbarHeight: 0,
          leading: Container(),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            tab = 0;
                          });
                        },
                        child: Column(
                          children: [
                            MyText(
                              title: "运动",
                              color: Color(tab == 0 ? 0xff000000 : 0xff999999),
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color:
                                  tab == 0 ? Colors.black : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            tab = 1;
                          });
                        },
                        child: Column(
                          children: [
                            MyText(
                              title: "计划",
                              color: Color(tab == 1 ? 0xff000000 : 0xff999999),
                            ),
                            Container(
                              height: 2,
                              width: double.infinity,
                              color:
                                  tab == 1 ? Colors.black : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: tab == 0 ? renderSport() : renderPlan(),
              ))
            ],
          ),
        ));
  }

  Widget renderSport() {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyText(
                title: "今日运动目标",
              ),
              Spacer(),
              Image.asset(
                "images/edit.png",
                width: 20,
                height: 20,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                ProgressBar(values: [
                  {"value": 1500, "maxValue": 3000},
                  {"time": 100, "maxValue": 100},
                  {"step": 5000, "maxValue": 8000}
                ]),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset("images/huo.png",
                                  width: 20, height: 20),
                              SizedBox(width: 5),
                              MyText(
                                title: "热量消耗",
                                color: Color(0xff999999),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              MyText(
                                title: "1500",
                                color: Color(0xff000000),
                              ),
                              MyText(
                                title: "/3000千卡",
                                color: Color(0xff999999),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("images/ju.png", width: 20, height: 20),
                            SizedBox(width: 5),
                            MyText(
                              title: "锻炼时间",
                              color: Color(0xff999999),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            MyText(
                              title: "100",
                              color: Color(0xff000000),
                            ),
                            MyText(
                              title: "/100mins",
                              color: Color(0xff999999),
                            ),
                          ],
                        )
                      ],
                    )),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("images/step.png",
                                width: 20, height: 20),
                            SizedBox(width: 5),
                            MyText(
                              title: "行走步数",
                              color: Color(0xff999999),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            MyText(
                              title: "5000",
                              color: Color(0xff000000),
                            ),
                            MyText(
                              title: "/8000步",
                              color: Color(0xff999999),
                            ),
                          ],
                        )
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              MyText(
                title: "运动",
                fontSize: 18,
              ),
              Spacer(),
              Image.asset(
                "images/category.png",
                width: 20,
                height: 20,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 160,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 每行显示3个子项
                  crossAxisSpacing: 5, // 子项之间的水平间距
                  mainAxisSpacing: 5, // 子项之间的垂直间距
                  childAspectRatio: 2,
                ),
                itemCount: sports.length, // 总共显示50个子项

                itemBuilder: (context, index) {
                  Map sport = sports[index];
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffff7f7f7),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Image.asset(
                          sport["image"],
                          width: 50,
                          height: 50,
                        ),
                        MyText(
                          title: sport["name"],
                          fontSize: 14,
                        )
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xff000000),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                MyText(
                  title: "开始",
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderPlan() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xffF7F7F7),
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: "计划概览",
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        MyText(
                          title: "健康",
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          height: 20,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0x3337AFFF),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff37AFFF),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(width: 5),
                        MyText(
                          title: "2/3",
                          color: Color(0xff999999),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        MyText(
                          title: "运动",
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          height: 20,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0x33F89D58),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(0xffF89D58),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(width: 5),
                        MyText(
                          title: "1/2",
                          color: Color(0xff999999),
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Container(
                  width: 120,
                  height: 120,
                  child: SfCircularChart(series: <CircularSeries>[
                    // Renders radial bar chart
                    RadialBarSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, int index_) => data.x,
                      yValueMapper: (ChartData data, int index) => data.y,
                      pointRadiusMapper: (ChartData data, int index) =>
                          data.text,
                      pointColorMapper: (ChartData data, int index) =>
                          data.pointColor,
                      dataLabelMapper: (ChartData data, int index) => data.x,
                      maximumValue: 15,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: false,
                        textStyle: TextStyle(fontSize: 10.0),
                      ),
                      cornerStyle: CornerStyle.bothCurve,
                      gap: '10%',
                      radius: '90%',
                    )
                  ]),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      tab2 = 0;
                    });
                  },
                  child: MyText(
                    title: "全部计划",
                    color:
                        tab2 == 0 ? Colors.black : Colors.black.withAlpha(100),
                  )),
              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    setState(() {
                      tab2 = 1;
                    });
                  },
                  child: MyText(
                    title: "健康",
                    color:
                        tab2 == 1 ? Colors.black : Colors.black.withAlpha(100),
                  )),
              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    setState(() {
                      tab2 = 2;
                    });
                  },
                  child: MyText(
                    title: "运动",
                    color:
                        tab2 == 2 ? Colors.black : Colors.black.withAlpha(100),
                  )),
              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    setState(() {
                      tab2 = 3;
                    });
                  },
                  child: MyText(
                    title: "美丽",
                    color:
                        tab2 == 3 ? Colors.black : Colors.black.withAlpha(100),
                  )),
              SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    setState(() {
                      tab2 = 4;
                    });
                  },
                  child: MyText(
                    title: "技能",
                    color:
                        tab2 == 4 ? Colors.black : Colors.black.withAlpha(100),
                  )),
              SizedBox(width: 10),
              Spacer(),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 2, vertical: 2), // 设置内边距
                  ),
                  onPressed: () {
                    setState(() {
                      tab2 = 4;
                    });
                  },
                  child: MyText(
                    title: "+",
                    fontSize: 30,
                  ))
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xff37AFFF), width: 8)),
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    MyText(
                      title: "一天喝八杯水",
                    ),
                    Spacer(),
                    MyText(
                      title: "每天",
                      color: Color(0xff999999),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Image.asset('images/shuibei.png', width: 20, height: 20),
                    Spacer(),
                    MyText(
                      title: "750",
                      fontSize: 24,
                    ),
                    MyText(
                      title: "ml/1.5L",
                      color: Color(0xffaaaaaaa),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffFF6161), width: 8)),
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    MyText(
                      title: "睡美容觉",
                    ),
                    Spacer(),
                    MyText(
                      title: "每天",
                      color: Color(0xff999999),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 120,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0X33FF6161),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 80,
                            height: 20,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0XffFF6161),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              title: "22:00",
                              color: Color(0XFF999999),
                              fontSize: 12,
                            ),
                            SizedBox(width: 20),
                            MyText(
                              title: "07:00",
                              color: Color(0XFF999999),
                              fontSize: 12,
                            )
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    MyText(
                      title: "7",
                      fontSize: 24,
                    ),
                    MyText(
                      title: "/15天",
                      color: Color(0xffaaaaaaa),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffFF6161), width: 8)),
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    MyText(
                      title: "有氧运动",
                    ),
                    Spacer(),
                    MyText(
                      title: "周一、周三、周五",
                      color: Color(0xff999999),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 20,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color(0X33FF6161),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: 20,
                                height: 20,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Color(0XffFF6161),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(width: 3),
                            MyText(
                              title: "0.5/1小时",
                              color: Color(0xff999999),
                              fontSize: 12,
                            ),
                            SizedBox(width: 3),
                            Container(
                              width: 50,
                              height: 20,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color(0X33FF6161),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: 30,
                                height: 20,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Color(0XffFF6161),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(width: 10),
                            MyText(
                              title: "200/300千卡",
                              color: Color(0xff999999),
                              fontSize: 12,
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(
                              title: "锻炼时长",
                              color: Color(0XFF999999),
                              fontSize: 12,
                            ),
                            SizedBox(width: 20),
                            MyText(
                              title: "燃烧热量",
                              color: Color(0XFF999999),
                              fontSize: 12,
                            )
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    MyText(
                      title: "7",
                      fontSize: 24,
                    ),
                    MyText(
                      title: "/15天",
                      color: Color(0xffaaaaaaa),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
