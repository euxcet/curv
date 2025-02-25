import 'package:flutter/material.dart';
import 'package:curv/tools/AppUtil.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final int? color;
  double fontSize;
  Function? onTap;
  int? backgroundColor;
  TextAlign textAlign;
  bool gradient;
  double radius;
  double width;
  double? height;
  FontWeight fontWeight;
  EdgeInsets margin;
  MyButton(this.title,
      {Key? key,
      this.color = 0xffffffff,
      this.gradient = true,
      this.backgroundColor = 0xffA59DFF,
      this.fontSize = 18,
      this.onTap,
      this.radius = 0,
      this.width = 100,
      this.height = 36,
      this.fontWeight = FontWeight.normal,
      this.margin = EdgeInsets.zero,
      this.textAlign = TextAlign.center})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build'
    // return Container(
    //     margin: margin,
    //     width: width,
    //     height: height,
    //     child: ElevatedButton(
    //         // highlightColor: Colors.blue,
    //         autofocus: true,
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: Color(backgroundColor!),
    //           foregroundColor: Color(0xffaaaaaa),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(20)),
    //         ),
    //         // splashColor: Colors.red,
    //         onPressed: () {
    //           if (onTap != null) {
    //             onTap!();
    //           }
    //         },
    //         child: Text(
    //           title ?? "",
    //           style: TextStyle(
    //               color: Color(color!),
    //               fontSize: fontSize,
    //               fontWeight: fontWeight),
    //         )));
    return InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Container(
            margin: margin,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Container(
                    width: width,
                    height: height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(0)),
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                          color: Color(color!),
                          fontSize: fontSize,
                          fontWeight: fontWeight),
                    )))));
  }
}
