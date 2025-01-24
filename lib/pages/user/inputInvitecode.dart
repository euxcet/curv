import 'package:flutter/material.dart';
import 'package:curv/models/user.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class InputInvitecode extends StatefulWidget {
  final Function? onSuccess;
  const InputInvitecode({Key? key, this.onSuccess}) : super(key: key);

  @override
  _InputInvitecodeState createState() => _InputInvitecodeState();
}

class _InputInvitecodeState extends State<InputInvitecode>
    with AutomaticKeepAliveClientMixin {
  var list = [];
  var cats = [];
  User? user;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    user = AppUtil.user;
    query();
  }

  void query() async {
    var res = await Api2Service.getInputInvitecode(AppUtil.user!.id);
    if (res != null) {
      textEditingController.text = res["code"];
    }
  }

  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin

  void confirm() async {
    var res = await Api2Service.confirmInvitecode(
        AppUtil.user!.id, textEditingController.text);

    EasyLoading.showSuccess("确认成功");
    await AppUtil.refreshUser();
    if (widget.onSuccess != null) {
      widget.onSuccess!();
    }
  }

  void getUser() async {}

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: MyText(title: "输入邀请码"),
        ),
        backgroundColor: AppConfig.grayBgColor,
        body: Container(
            child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: AppUtil.getCommonPadding(),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextField(
                          textAlign: TextAlign.left,
                          controller: textEditingController,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: AppConfig.font3),
                              hintText: "请输入邀请码",
                              border: InputBorder.none),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
              width: 200,
              child: MyButton(
                "确定",
                onTap: () {
                  confirm();
                },
              ))
        ])));
  }
}
