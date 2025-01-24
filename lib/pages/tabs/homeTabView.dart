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

class HomeTabViewPage extends StatefulWidget {
  const HomeTabViewPage({Key? key}) : super(key: key);

  @override
  _HomeTabViewPageState createState() => _HomeTabViewPageState();
}

class _HomeTabViewPageState extends State<HomeTabViewPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var models = [];

  var tuijians = [];

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
    models = await Api2Service.queryFigure3D();
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
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 50,
          title: Row(
            children: [
              MyText(
                title: "茧化",
                weight: FontWeight.bold,
              ),
              const SizedBox(width: 5),
              Expanded(
                  child: Container(
                height: 35,
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: AppConfig.font3,
                    ),
                    SizedBox(width: 4),
                    MyText(
                      title: "搜素",
                      color: AppConfig.font3,
                    )
                  ],
                ),
              )),
            ],
          ),
          actions: [
            MyButton(
              "上传视频",
              onTap: () {
                AppUtil.getTo(DeployPage());
              },
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: new BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin: AppUtil.getCommonPadding(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "绘画",
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/caipu.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                              SizedBox(width: 5),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/biaobai.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )))
                            ],
                          )
                        ],
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "聊天",
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/quming.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                )),
            Container(
                margin: AppUtil.getCommonPadding(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "数字人",
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/shenghuo.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                              SizedBox(width: 5),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/zongjie.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )))
                            ],
                          )
                        ],
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "ai视频-无限想象",
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // EasyLoading.showToast("内测中，暂未开放!");
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/shici.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                              SizedBox(width: 5),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // EasyLoading.showToast("内测中，暂未开放!");

                                        // AppUtil.getTo(AIDrawPage());
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/zuowen.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )))
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                )),
            Container(
                margin: AppUtil.getCommonPadding(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "换脸-娱乐",
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // EasyLoading.showToast("内测中，暂未开放!");
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/duilian.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                              SizedBox(width: 5),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // EasyLoading.showToast("内测中，暂未开放!");
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/fayan.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )))
                            ],
                          )
                        ],
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            title: "生成音乐",
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // EasyLoading.showToast("内测中，暂未开放!");
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/qingjia.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))),
                              SizedBox(width: 5),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // EasyLoading.showToast("内测中，暂未开放!");
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.asset(
                                            "images/cates/qinghua.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )))
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ))
          ]),
        ));
  }
}
