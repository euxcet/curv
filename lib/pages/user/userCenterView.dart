import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:curv/service/api2Service.dart';
import 'package:curv/service/apiService.dart';
import 'package:curv/tools/AppUtil.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class UserCenterViewPage extends StatefulWidget {
  final String? id;

  const UserCenterViewPage({
    Key? key,
    this.id = "",
  }) : super(key: key);

  @override
  _UserCenterViewPageState createState() => _UserCenterViewPageState();
}

class _UserCenterViewPageState extends State<UserCenterViewPage>
    with AutomaticKeepAliveClientMixin {
  var list = [];
  var cats = [];
  var user;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this.getUser();
    this.queryData();
  }

  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin

  void queryData() async {
    Api2Service.getUserResources(widget.id).then((value) {
      this.setState(() {
        this.list = value;
      });
    });
  }

  void getUser() async {
    ApiService.getUser(widget.id).then((value) {
      this.setState(() {
        this.user = value;
      });
    });
  }

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

  void registerHandler() {}

  void clickGood(item) {
    ApiService.addResourceGood(item["id"]).then((value) {
      this.setState(() {
        item["isgood"] = !item["isgood"];
        item["goodnum"] = item["goodnum"] + (item["isgood"] ? 1 : -1);
      });
    });
  }

  void share() {
    /// 分享到好友
    var model = fluwx.WeChatShareWebPageModel(
      "https://www.xiaowanwu.cn/games/#/",
      title: "这里的画师很高级-欢迎体验ai绘画",
      thumbnail:
          fluwx.WeChatImage.network("https://u.xiaowanwu.cn/logo216.png"),
      scene: fluwx.WeChatScene.SESSION,
    );
    fluwx.shareToWeChat(model);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Color color = Color(0xff313131);
    if (user == null) {
      return Container();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Colors.transparent),
        // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              onPressed: () {
                AppUtil.showMorePop(context, share: share, notInterested: () {
                  AppUtil.back();
                });
              }),
        ],
      ),
      body: Container(
          decoration: new BoxDecoration(color: Color(0xfff7f7f7)),
          child: Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Row(
                      children: cats.map((item) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(
                              AppUtil.getPadding(), 10, 0, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(
                                item["name"],
                                style: TextStyle(
                                    color: Color(0xff000000), fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: 2,
                        // itemExtent: 170.0, //强制高度为50.0
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Image(
                                        image:
                                            AssetImage("images/userzone.jpg"),
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(
                                          AppUtil.getPadding(), 10, 10, 10),
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    user['nickname'],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff000000)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 5, 5, 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    child: Text(
                                                      user['score'].toString() +
                                                          "分",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                              0xff000000)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white),
                                                child: Text(
                                                  user['signname'] ??
                                                      "他还没有给自己写个签名",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xff888888)),
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            width: 80,
                                            height: 80,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 5, 0),
                                            child: ClipRRect(
                                                // ClipRRect
                                                borderRadius:
                                                    BorderRadius.circular((40)),
                                                child: Image(
                                                    image: NetworkImage(
                                                        user["headimg"]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          } else {
                            return MasonryGridView.count(
                              // 展示几列
                              crossAxisCount: 2,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              // 元素总个数
                              itemCount: list.length,
                              // 单个子元素
                              itemBuilder: (BuildContext context, int index) {
                                Map item = list[index];
                                return Container();
                              },
                              // 纵向元素间距
                              mainAxisSpacing: 5,
                              // 横向元素间距
                              crossAxisSpacing: 10,
                              //本身不滚动，让外面的singlescrollview来滚动
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true, //收缩，让元素宽度自适应
                            );
                          }
                        })),
              )
            ],
          )),
    );
  }
}
