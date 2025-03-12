import 'package:curv/pages/data/heart_page.dart';
import 'package:curv/pages/data/hot_chart.dart';
import 'package:curv/pages/home/curv_document.dart';
import 'package:curv/pages/home/curv_run_item.dart';
import 'package:curv/pages/home/daily_item.dart';
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

class HotPage extends StatefulWidget {
  const HotPage({Key? key}) : super(key: key);

  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int tab = 0;

  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///see AutomaticKeepAliveClientMixin

  @override
  void initState() {
    super.initState();
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
    int a = 0;
    setState(() {});
  }

  void _onPageChange(int index) {
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
            title: "热量",
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Color(0xffF7F7F7),
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                tab = 0;
                              });
                            },
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Color(tab == 0 ? 0XFF000000 : 0x00000000),
                                  borderRadius: BorderRadius.circular(10)),
                              child: MyText(
                                title: "日",
                                color:
                                    tab == 0 ? Colors.white : Color(0xff999999),
                              ),
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                tab = 1;
                              });
                            },
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Color(tab == 1 ? 0XFF000000 : 0x00000000),
                                  borderRadius: BorderRadius.circular(10)),
                              child: MyText(
                                title: "周",
                                color:
                                    tab == 1 ? Colors.white : Color(0xff999999),
                              ),
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                tab = 2;
                              });
                            },
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Color(tab == 2 ? 0XFF000000 : 0x00000000),
                                  borderRadius: BorderRadius.circular(10)),
                              child: MyText(
                                title: "月",
                                color:
                                    tab == 2 ? Colors.white : Color(0xff999999),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    MyText(
                      title: "总计",
                    ),
                    MyText(
                      title: "1200",
                      fontSize: 30,
                    ),
                    MyText(
                      title: "千卡",
                    ),
                    Spacer(),
                    Icon(Icons.navigate_before),
                    MyText(
                      title: "2024.12.21",
                    ),
                    Icon(Icons.navigate_next),
                  ],
                ),
                HotChart(),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0x1AFF854D),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "今日最高",
                            color: Color(0xff999999),
                          ),
                          SizedBox(height: 5),
                          MyText(
                            title: "135",
                            fontSize: 20,
                          ),
                          MyText(
                            title: "千卡",
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
                            title: "本周平均",
                            color: Color(0xff999999),
                          ),
                          SizedBox(height: 5),
                          MyText(
                            title: "1000",
                            fontSize: 20,
                          ),
                          MyText(
                            title: "千卡/天",
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
                            title: "基础代谢",
                            color: Color(0xff999999),
                          ),
                          SizedBox(height: 5),
                          MyText(
                            title: "2000",
                            fontSize: 20,
                          ),
                          MyText(
                            title: "千卡/天",
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
                            title: "2500",
                            fontSize: 20,
                          ),
                          MyText(
                            title: "千卡/天",
                            color: Color(0xffaaaaaa),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0x1AFF854D),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyText(
                            title: "燃脂参考",
                          ),
                          Spacer(),
                          Image.asset(
                            "images/question.png",
                            width: 15,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                title: "今日最高",
                                color: Color(0xff999999),
                              ),
                              SizedBox(height: 5),
                              MyText(
                                title: "135",
                                fontSize: 20,
                              ),
                              MyText(
                                title: "千卡",
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
                                title: "本周平均",
                                color: Color(0xff999999),
                              ),
                              SizedBox(height: 5),
                              MyText(
                                title: "1000",
                                fontSize: 20,
                              ),
                              MyText(
                                title: "千卡/天",
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
                                title: "基础代谢",
                                color: Color(0xff999999),
                              ),
                              SizedBox(height: 5),
                              MyText(
                                title: "2000",
                                fontSize: 20,
                              ),
                              MyText(
                                title: "千卡/天",
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
                                title: "2500",
                                fontSize: 20,
                              ),
                              MyText(
                                title: "千卡/天",
                                color: Color(0xffaaaaaa),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0x1AFF854D),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: "燃脂趋势",
                      ),
                      SizedBox(height: 10),
                      MyText(
                        title: "在过去20周中，日均燃烧的千卡数增加",
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 1,
                        color: Color(0xff9999999),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 10,
                              color: Color(0xffFF9F45),
                            ),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 20,
                              color: Color(0xffFF9F45),
                            ),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 10,
                              color: Color(0xffFF9F45),
                            ),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 30,
                              color: Color(0xffFF9F45),
                            ),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          ),
                          Container(
                            width: 4,
                            height: 50,
                            color: Color(0xffD9D9D9),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          MyText(
                            title: "8周平均",
                            color: Color(0xff999999),
                          ),
                          Spacer(),
                          MyText(
                            title: "20周平均",
                            color: Color(0xffaaaaaa),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
