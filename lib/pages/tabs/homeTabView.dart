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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/scan.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Image.asset(
                          "images/sun.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        MyText(
                          title: "紫外线较强",
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MyText(
                      title: "CURV，美一刻",
                      color: Colors.white,
                      fontSize: 26,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
