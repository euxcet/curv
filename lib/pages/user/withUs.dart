import 'package:flutter/material.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WithUs extends StatefulWidget {
  const WithUs({
    Key? key,
  }) : super(key: key);

  @override
  _WithUsState createState() => _WithUsState();
}

class _WithUsState extends State<WithUs> with AutomaticKeepAliveClientMixin {
  bool validate = false;
  bool mobileSearch = false;
  @override
  void initState() {
    getUser();
    queryData();
  }

  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin

  void queryData() async {}

  void getUser() async {}
  void logout() {
    StorageUtil.clearUser();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: MyText(title: "关于我们"),
        ),
        backgroundColor: AppConfig.grayBgColor,
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(
                  AppUtil.getPadding(), 0, AppUtil.getPadding(), 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "images/logo216.png",
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      MyText(
                        title: "茧化AI元宇宙",
                        fontSize: 16,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      MyText(
                        title: "V 1.0.0",
                        fontSize: 16,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ])),
          Container(
            padding: const EdgeInsets.all(10),
            margin: AppUtil.getCommonPadding(),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      EasyLoading.showToast("已是最新版本");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "检测更新"),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ])));
  }
}
