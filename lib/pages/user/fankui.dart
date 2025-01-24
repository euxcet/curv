import 'package:flutter/material.dart';
import 'package:curv/models/user.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Fankui extends StatefulWidget {
  final Function? onSuccess;
  const Fankui({Key? key, this.onSuccess}) : super(key: key);

  @override
  _FankuiState createState() => _FankuiState();
}

class _FankuiState extends State<Fankui> with AutomaticKeepAliveClientMixin {
  var list = [];
  var cats = [];
  User? user;
  TextEditingController phoneController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    user = AppUtil.user;
  }

  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin

  void confirm() async {
    if (contentController.text.isEmpty) {
      EasyLoading.showToast("请输入意见");
      return;
    }
    var res = await Api2Service.fankui(
        AppUtil.user!.id, phoneController.text, contentController.text);

    EasyLoading.showSuccess("提交成功,正在耐心处理中");
  }

  void getUser() async {}

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: MyText(title: "意见反馈"),
        ),
        backgroundColor: const Color(0XFFeeeeee),
        body: Container(
            child: Column(children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    left: AppUtil.getPadding(), right: AppUtil.getPadding()),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextField(
                      textAlign: TextAlign.left,
                      controller: contentController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          hintStyle: TextStyle(color: AppConfig.font3),
                          hintText: "请写下您的意见或者反馈",
                          border: InputBorder.none),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                margin: AppUtil.getCommonPadding(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextField(
                      textAlign: TextAlign.left,
                      controller: phoneController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          hintStyle: TextStyle(color: AppConfig.font3),
                          hintText: "请填写手机号码(选填)",
                          border: InputBorder.none),
                    )),
                  ],
                ),
              ),
            ],
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
