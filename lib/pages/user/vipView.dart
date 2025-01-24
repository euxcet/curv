import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class VipView extends StatefulWidget {
  const VipView({Key? key}) : super(key: key);

  @override
  _VipViewState createState() => _VipViewState();
}

class _VipViewState extends State<VipView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var cates = [];
  var selectCate;
  var list = [];
  var tuijians = [];
  var nowMessageLatest;

  int nowIndex = 0;
  int pay = 0;
  Map? orderRes;

  bool keyboardShow = false;

  TabController? _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///see AutomaticKeepAliveClientMixin

  @override
  void initState() {
    queryData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除焦点监听

    if (_timer != null) {
      _timer!.cancel();
    }
    EasyLoading.dismiss();
    super.dispose();
  }

  checkPayFinish() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        Api2Service.getOrder(orderRes!["id"]).then((value) {
          if (value["status"] == 1) {
            _timer!.cancel();
            EasyLoading.showSuccess("恭喜你成为会员!");
          }
        });
      },
    );
  }

  initData() async {
    var res = StorageUtil.getMessageLatests();
    setState(() {
      list = res;
      if (list.isNotEmpty) {
        nowMessageLatest = list[0];
      }
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

  void queryData() async {
    Api2Service.queryVipcates(AppUtil.user?.id).then((value) {
      setState(() {
        cates = value;
        selectCate = value[0];
      });
    });
  }

  void alipay() async {
    EasyLoading.show(status: "等待支付完成...");
    checkPayFinish();

    launch(orderRes?["url"]);
    // var isInstalled = await tobias.isAliPayInstalled();
    // if (!isInstalled) {
    //   EasyLoading.showInfo("请先安装支付宝");
    //   return;
    // }

    // tobias.aliPay(orderRes?["url"]).then((payRes) {
    //   //result是请求接口返回的字符串直接放进去就好了
    //   if (payRes['resultStatus'] == 9000 || payRes['resultStatus'] == '9000') {
    //     EasyLoading.showInfo("支付成功");
    //   } else {}
    // });
  }

  //微信支付
  Future<void> openWxPay() async {
    EasyLoading.show(status: "等待支付完成...");
    checkPayFinish();
    launch(orderRes?["url"]);

    //是否安装微信
    // bool isInstalled = await fluwx.isWeChatInstalled;
    // if (!isInstalled) {
    //   EasyLoading.showInfo("请先安装微信");
    //   return;
    // }
    // //调起支付
    // fluwx.payWithWeChat(
    //   appId: "wx6ade98a616eff449",
    //   partnerId: "1305372501",
    //   prepayId: orderRes!["prepay_id"],
    //   packageValue: orderRes!["packageValue"],
    //   nonceStr: orderRes!["onece_str"],
    //   timeStamp: orderRes!["timestamp"],
    //   sign: "sign",
    // );
    // //监听微信回调
    // fluwx.weChatResponseEventHandler.listen((event) {
    //   if (event.isSuccessful) {
    //     EasyLoading.showInfo("微信支付成功");
    //   } else {
    //     EasyLoading.showInfo(event.errStr ?? "微信支付成功");
    //   }
    // });
  }

  void submit() {
    Api2Service.aitoolOrderSubmit(selectCate["id"], AppUtil.user!.id, pay)
        .then((value) {
      setState(() {
        orderRes = value;
        if (pay == 0) {
          openWxPay();
        } else if (pay == 1) {
          alipay();
        }
      });
    });
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

    Map? item = list.isNotEmpty ? list[0] : null;

    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          // title: Text(user != null ? user["nickname"] : "",style:TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        //渐变位置
                        begin: Alignment.topLeft, //右上
                        end: Alignment.bottomCenter, //左下
                        stops: [
                      0.0,
                      0.8,
                      1.0
                    ], //[渐变起始点, 渐变结束点]
                        //渐变颜色[始点颜色, 结束颜色]
                        colors: [
                      AppConfig.mainColor,
                      Color(0xffffffff),
                      Color(0xffffffff)
                    ])),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: AppUtil.getPadding(),
                        bottom: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            AppUtil.back();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    //渐变位置
                                    begin: Alignment.bottomLeft, //右上
                                    end: Alignment.topRight, //左下
                                    stops: [
                                      0.0,
                                      1.0
                                    ], //[渐变起始点, 渐变结束点]
                                    //渐变颜色[始点颜色, 结束颜色]
                                    colors: [
                                      AppConfig.mainColor,
                                      Color(0xffE9cFFF)
                                    ])),
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Expanded(
                            child: MyText(
                          title: "会员NPC超市",
                          fontSize: 17,
                          weight: FontWeight.bold,
                        )),
                        Container(
                          width: 40,
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    "images/viptop.png",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.3,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 178,
                      child: Row(
                        children: cates.map((e) {
                          return getItem(e);
                        }).toList(),
                      ),
                    ),
                  ),
                  selectCate != null
                      ? Container(
                          margin: EdgeInsets.only(left: AppUtil.getPadding()),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            textAlign: TextAlign.start,
                            title: "支付完成后获得" +
                                selectCate["days"].toString() +
                                "天会员特权,不会自动续期",
                            color: AppConfig.font1,
                          ),
                        )
                      : Container(),
                  Container(
                    padding: AppUtil.getCommonPadding(),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  pay = 0;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 70,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/wepay.png",
                                      width: 30,
                                    ),
                                    const SizedBox(width: 5),
                                    MyText(
                                      title: "微信支付",
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      pay == 0
                                          ? "images/radio_checked.png"
                                          : "images/radio_unchecked.png",
                                      width: 16,
                                    )
                                  ],
                                ),
                              )),
                        ),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    pay = 1;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "images/alipay.png",
                                        width: 30,
                                      ),
                                      const SizedBox(width: 5),
                                      MyText(
                                        title: "支付宝支付",
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        pay == 1
                                            ? "images/radio_checked.png"
                                            : "images/radio_unchecked.png",
                                        width: 16,
                                      )
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: AppUtil.getPadding()),
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      title: "会员权益",
                      fontSize: 18,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    "images/quanyi.png",
                    width: double.infinity,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                      "立即支付" +
                          (selectCate != null
                              ? " ¥" + selectCate["price"].toString()
                              : ""),
                      width: 200,
                      fontSize: 18, onTap: () {
                    submit();
                  }, fontWeight: FontWeight.bold, height: 45),
                ]))));
  }

  Widget getItem(Map item) {
    int index = cates.indexOf(item);

    return GestureDetector(
        onTap: () {
          setState(() {
            selectCate = item;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
              color: selectCate == item
                  ? const Color(0xfff7e9ad)
                  : const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              MyText(
                title: item["name"],
                color:
                    selectCate == item ? const Color(0xff7f141b) : Colors.black,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  MyText(
                    title: "¥",
                    color: selectCate == item
                        ? const Color(0xffef644b)
                        : Colors.black,
                    fontSize: 18,
                  ),
                  const SizedBox(width: 5),
                  MyText(
                    title: item["price"].toString(),
                    color: selectCate == item
                        ? const Color(0xffef644b)
                        : Colors.black,
                    fontSize: 30,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              MyText(
                title: "约" +
                    AppUtil.formartNum(item["price"] / item["days"], 1)
                        .toString() +
                    "/天",
                fontSize: 13,
                color:
                    selectCate == item ? const Color(0xff7f141b) : Colors.black,
              ),
              const SizedBox(height: 5),
              Container(
                  width: 100,
                  decoration: const BoxDecoration(color: Color(0xffdddddd)),
                  height: 1),
              const SizedBox(height: 5),
              Container(
                child: MyText(
                  title: item["days"] > 10000
                      ? "终身可用"
                      : (item["days"].toString() + "有效期"),
                  fontSize: 13,
                  color: selectCate == item
                      ? const Color(0xff7f141b)
                      : const Color(0xff888888),
                ),
              )
            ],
          ),
        ));
  }
}
