import 'package:flutter/material.dart';
import 'package:curv/pages/home.dart';
import 'package:curv/pages/user/fankui.dart';
import 'package:curv/pages/user/updateNickname.dart';
import 'package:curv/pages/user/withUs.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/message.dart';
import 'package:curv/tools/storage.dart';

class SettingViewPage extends StatefulWidget {
  const SettingViewPage({Key? key}) : super(key: key);

  @override
  _SettingViewPageState createState() => _SettingViewPageState();
}

class _SettingViewPageState extends State<SettingViewPage> {
  void registerHandler() {}

  void logout() async {
    AppUtil.user = null;
    await StorageUtil.clearUser();
    AppUtil.getReplaceTo(const HomePage());
  }

  void zhuxiao() async {
    Message.info("您的账号已经注销");
    AppUtil.user = null;
    await StorageUtil.clearUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffFAFAFA),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            AppUtil.getPadding(), 10, AppUtil.getPadding(), 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(height: 1, color: AppConfig.grayBgColor),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  AppUtil.getTo(UpdateNickname(
                                    onSuccess: () {
                                      setState(() {});
                                    },
                                  ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "images/user.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      MyText(title: "昵称"),
                                      const Spacer(),
                                      MyText(
                                        title: AppUtil.user!.nickname,
                                        color: AppConfig.font3,
                                      ),
                                    ],
                                  ),
                                )),
                            Container(height: 1, color: AppConfig.grayBgColor),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "images/miid.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      MyText(title: "ID"),
                                      const Spacer(),
                                      MyText(
                                        title: AppUtil.user!.userno.toString(),
                                        color: AppConfig.font3,
                                      ),
                                    ],
                                  ),
                                )),
                            // Container(height: 1, color: AppConfig.grayBgColor),
                            // GestureDetector(
                            //     behavior: HitTestBehavior.opaque,
                            //     onTap: () {},
                            //     child: Container(
                            //       padding: const EdgeInsets.all(10),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Image.asset(
                            //             "images/phone2.png",
                            //             width: 20,
                            //             height: 20,
                            //           ),
                            //           const SizedBox(width: 5),
                            //           MyText(title: "手机号"),
                            //           const Spacer(),
                            //           MyText(
                            //             title: AppUtil.user!.mobile.toString(),
                            //             color: const Color.fromARGB(
                            //                 255, 254, 246, 246),
                            //           ),
                            //         ],
                            //       ),
                            //     )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            AppUtil.getPadding(), 10, AppUtil.getPadding(), 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  AppUtil.getTo(const Fankui());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Image.asset(
                                      //   "images/main/jianyue.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      const SizedBox(width: 5),
                                      MyText(
                                        title: "意见反馈",
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  ),
                                )),
                            // Container(height: 1, color: AppConfig.grayBgColor),
                            // GestureDetector(
                            //     behavior: HitTestBehavior.opaque,
                            //     onTap: () {},
                            //     child: Container(
                            //       padding: const EdgeInsets.all(10),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           // Image.asset(
                            //           //   "images/main/jianyue.png",
                            //           //   width: 20,
                            //           //   height: 20,
                            //           // ),
                            //           const SizedBox(width: 5),
                            //           MyText(
                            //             title: "简约模式",
                            //           ),
                            //           const Spacer(),
                            //           const Icon(Icons.navigate_next)
                            //         ],
                            //       ),
                            //     )),
                            // Container(height: 1, color: AppConfig.grayBgColor),
                            // GestureDetector(
                            //     behavior: HitTestBehavior.opaque,
                            //     onTap: () {},
                            //     child: Container(
                            //       padding: const EdgeInsets.all(10),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           // Image.asset(
                            //           //   "images/main/secai.png",
                            //           //   width: 20,
                            //           //   height: 20,
                            //           // ),
                            //           const SizedBox(width: 5),
                            //           MyText(
                            //             title: "色彩模式",
                            //           ),
                            //           const Spacer(),
                            //           const Icon(Icons.navigate_next)
                            //         ],
                            //       ),
                            //     )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(0),
                        margin: AppUtil.getCommonPadding(),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(height: 1, color: AppConfig.grayBgColor),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  String url = Uri.encodeComponent(
                                      "https://www.xiaowanwu.cn/safe/mysecret");
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Image.asset(
                                      //   "images/main/shouji.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      const SizedBox(width: 5),
                                      MyText(title: "隐私政策"),
                                      const Spacer(),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  ),
                                )),
                            Container(height: 1, color: AppConfig.grayBgColor),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  AppUtil.getTo(const WithUs());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Image.asset(
                                      //   "images/main/guanyu.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      const SizedBox(width: 5),
                                      MyText(title: "关于我们"),
                                      const Spacer(),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(0),
                          margin: EdgeInsets.fromLTRB(
                              AppUtil.getPadding(), 0, AppUtil.getPadding(), 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  AppUtil.showConfirm(context, title: "确认注销账号?",
                                      onConfirm: () {
                                    logout();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Image.asset(
                                      //   "images/main/zhuxiao.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      const SizedBox(width: 5),
                                      MyText(title: "注销账号"),
                                      const Spacer(),
                                      const Icon(Icons.navigate_next)
                                    ],
                                  ),
                                )),
                          ])),
                      const SizedBox(height: 20),
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            AppUtil.showConfirm(context, title: "确认退出账号?",
                                onConfirm: () {
                              logout();
                            });
                          },
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              margin: EdgeInsets.fromLTRB(AppUtil.getPadding(),
                                  0, AppUtil.getPadding(), 0),
                              decoration: AppUtil.getMainButtonDecoration(),
                              child: MyText(
                                title: "退出账号",
                                color: Colors.white,
                                fontSize: 17,
                              ))),
                      const SizedBox(height: 20),
                    ])))),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //      String url = Uri.encodeComponent("https://www.xiaowanwu.cn/pc/us/with");
            //     NavigatorUtil.jump(context, "/linkWeb?url="+url);
            //   },
            //   child: Container(
            //       padding: EdgeInsets.fromLTRB(
            //           AppUtil.getPadding(), 20, AppUtil.getPadding(), 20),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Container(
            //             alignment: Alignment.center,
            //             child: Text(
            //               "关于我们",
            //               textAlign: TextAlign.left,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           Expanded(child: Container()),
            //           Icon(
            //             Icons.arrow_forward_ios,
            //             size: 20,
            //           )
            //         ],
            //       )),
            // ),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     zhuxiao();
            //   },
            //   child: Container(
            //       padding: EdgeInsets.fromLTRB(
            //           AppUtil.getPadding(), 20, AppUtil.getPadding(), 20),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Container(
            //             alignment: Alignment.center,
            //             child: const Text(
            //               "账号注销",
            //               textAlign: TextAlign.left,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           )
            //         ],
            //       )),
            // ),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     StorageUtil.clear();
            //     Message.info("清除成功!");
            //   },
            //   child: Container(
            //       padding: EdgeInsets.fromLTRB(
            //           AppUtil.getPadding(), 20, AppUtil.getPadding(), 20),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Container(
            //             alignment: Alignment.center,
            //             child: const Text(
            //               "清除缓存",
            //               textAlign: TextAlign.left,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           Expanded(child: Container()),
            //           // Icon(
            //           //   Icons.arrow_forward_ios,
            //           //   size: 20,
            //           // )
            //         ],
            //       )),
            // ),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     String url = Uri.encodeComponent(
            //         "https://www.xiaowanwu.cn/safe/mysecret");
            //     NavigatorUtil.jump(context, "/linkWeb?url=" + url);
            //   },
            //   child: Container(
            //       margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            //       padding: EdgeInsets.fromLTRB(
            //           AppUtil.getPadding(), 20, AppUtil.getPadding(), 20),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Container(
            //             alignment: Alignment.center,
            //             child: const Text(
            //               "隐私政策",
            //               textAlign: TextAlign.left,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           Expanded(child: Container()),
            //           const Icon(
            //             Icons.arrow_forward_ios,
            //             size: 20,
            //           )
            //         ],
            //       )),
            // ),
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     logout();
            //   },
            //   child: Container(
            //     child: Container(
            //       padding: const EdgeInsets.all(10),
            //       alignment: Alignment.center,
            //       child: const Text(
            //         "退出登录",
            //         textAlign: TextAlign.left,
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 18,
            //             color: Color(0xffff7000)),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
