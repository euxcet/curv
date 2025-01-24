import 'package:flutter/material.dart';
import 'package:curv/tools/config.dart';

class MyText extends StatelessWidget {
  final String? title;
  final Color? color;
  double fontSize;
  FontWeight? weight;
  TextAlign textAlign;
  int? maxLines;
  MyText(
      {Key? key,
      this.title = "",
      this.color,
      this.maxLines,
      this.fontSize = 15,
      this.textAlign = TextAlign.center,
      this.weight = FontWeight.normal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      title ?? "",
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          height: 1.4,
          color: color ?? AppConfig.font1,
          fontWeight: weight),
    );
  }
}
