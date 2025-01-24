import 'package:flutter_easyloading/flutter_easyloading.dart';

class Message {
  static info(String msg) {
    EasyLoading.showToast(msg);
  }

  static error(String msg) {
    EasyLoading.showToast(msg);
  }
}

// class LoadingDialog extends Dialog {
//   final String text="";

//   // LoadingDialog({Key key, @required this.text}) : super(key: key);

//   // @override
//   // Widget build(BuildContext context) {
//   //   return new Material(
//   //     type: MaterialType.transparency,
//   //     child: new Center(
//   //       child: new SizedBox(
//   //         width: 120.0,
//   //         height: 120.0,
//   //         child: new Container(
//   //           decoration: ShapeDecoration(
//   //             color: Color(0xff000000),
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.all(
//   //                 Radius.circular(8.0),
//   //               ),
//   //             ),
//   //           ),
//   //           child: new Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             crossAxisAlignment: CrossAxisAlignment.center,
//   //             children: <Widget>[
//   //               new CircularProgressIndicator(),
//   //               new Padding(
//   //                 padding: const EdgeInsets.only(
//   //                   top: 20.0,
//   //                 ),
//   //                 child: new Text(text,style: TextStyle(color: Colors.white),),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }