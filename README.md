# wan_new

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

/Users/gaoyang/Documents/flutter/.pub-cache/hosted/pub.flutter-io.cn/flutter_inappwebview-5.4.3+7

webview_flutter_plus 源码 890 行改成如下
try {
print("file===2222");
if (path.startsWith("/") ||
path.startsWith("data") ||
path.startsWith("var/")) {
File file = new File(path);
print("file===hell1");
body = file.readAsBytesSync();
print("file===3333");
} else {
body = (await rootBundle.load(path)).buffer.asUint8List();
}
} catch (e) {
print('Error: $e');
httpRequest.response.close();
return;
}



https://www.figma.com/design/fT4uXUQjJGPfhboW3kfJYE/CURV_App_V1?node-id=0-1&t=26D2Mo7rXRQkASJK-1

