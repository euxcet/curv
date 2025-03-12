import 'dart:io';

import 'package:curv/pages/chat/chat_page.dart';
import 'package:curv/pages/widgets/MyText.dart';
import 'package:curv/pages/widgets/ProgressBar.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:flutter/material.dart';

class DailyItem extends StatefulWidget {
  final Map? data;
  const DailyItem({Key? key, this.data}) : super(key: key);

  @override
  _DailyItemState createState() => _DailyItemState();
}

class _DailyItemState extends State<DailyItem> {
  ///see AutomaticKeepAliveClientMixin

  @override
  void initState() {
    super.initState();
  }

  void registerHandler() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppUtil.getTo(ChatPage());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset("images/run.png", width: 30, fit: BoxFit.cover),
                Container(
                  height: 100,
                  width: 1,
                  child: Image.asset("images/dashed.png",
                      width: 30, fit: BoxFit.cover),
                )
              ],
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyText(
                      title: "运动",
                    ),
                    Spacer(),
                    MyText(
                      title: "09:00",
                      color: Color(0xff999999),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xfff7f7f7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyText(
                            title: "你跑了3km，达成了今日有氧目标！",
                          ),
                          Spacer(),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          MyText(
                            title: "里程：",
                            color: Color(0xff999999),
                          ),
                          MyText(
                            title: "3KM",
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 1,
                            height: 15,
                            color: Color(0xff999999),
                          ),
                          SizedBox(width: 5),
                          MyText(
                            title: "热量:",
                            color: Color(0xff999999),
                          ),
                          MyText(
                            title: "300kcal",
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 1,
                            height: 15,
                            color: Color(0xff999999),
                          ),
                          SizedBox(width: 5),
                          MyText(
                            title: "时长:",
                            color: Color(0xff999999),
                          ),
                          MyText(
                            title: "30min",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
