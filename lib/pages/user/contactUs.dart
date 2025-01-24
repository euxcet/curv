import 'package:flutter/material.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';

import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({
    Key? key,
  }) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
    with AutomaticKeepAliveClientMixin {
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
          title: MyText(title: "联系我们"),
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
                      // Image.network(
                      //   "https://u.xiaowanwu.cn/aiweixin.jpeg",
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   height: MediaQuery.of(context).size.width * 0.9,
                      //   fit: BoxFit.contain,
                      // ),
                      const SizedBox(height: 10),
                      MyText(
                        title: "微信号:feng3766665",
                        fontSize: 16,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      MyButton("复制微信", onTap: () {
                        AppUtil.copy("feng3766665");
                      }),
                      const SizedBox(height: 20),
                      MyText(
                        title: "QQ群:287020234",
                        fontSize: 16,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      MyButton("复制QQ", onTap: () {
                        AppUtil.copy("feng287020234");
                      }),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ])),
        ])));
  }
}
