import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';

class LinkWebviewPage extends StatefulWidget {
  final String? url;
  final bool? landscape;
  const LinkWebviewPage({Key? key, this.url = "", this.landscape = false})
      : super(key: key);

  @override
  _LinkWebviewPageState createState() => _LinkWebviewPageState();
}

class _LinkWebviewPageState extends State<LinkWebviewPage> {
  @override
  void initState() {}

  back() {}

  @override
  Widget build(BuildContext context) {
    print("WebviewPage build ");
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url ?? "")),
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                applicationNameForUserAgent: "putao_app",
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
              ),
              android: AndroidInAppWebViewOptions(
                  allowFileAccess: true,
                  allowContentAccess: true,
                  hardwareAcceleration: true,
                  // useHybridComposition: true,
                  cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
                  networkAvailable: true)),
          onWebViewCreated: (InAppWebViewController controller) {},
          onProgressChanged: (InAppWebViewController controller, int progress) {
            if (progress == 100) {}
          },
        ),
      ),
    );
  }
}
