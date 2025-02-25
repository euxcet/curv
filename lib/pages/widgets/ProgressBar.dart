import 'package:curv/pages/widgets/ArcPainter.dart';
import 'package:flutter/material.dart';
import 'package:curv/models/user.dart';
import 'package:curv/pages/widgets/MyButton.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/service/api2Service.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProgressBar extends StatefulWidget {
  final List<Map<String, double>>? values;

  const ProgressBar({Key? key, this.values}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      width: 200,
      height: 100,
      margin: EdgeInsets.only(top: 80),
      child: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(200, 100),
              painter: ArcPainter(),
            ),
          ),
          Positioned(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 15),
                MyText(
                  title: "30%",
                  fontSize: 20,
                ),
                MyText(
                  title: "完成度",
                  fontSize: 12,
                  color: Color(0xff999999),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
