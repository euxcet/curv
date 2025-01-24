import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curv/models/user.dart';

import 'package:curv/service/api2Service.dart';
import 'package:curv/service/apiService.dart';
import 'package:curv/tools/AppUtil.dart';
import 'package:curv/tools/config.dart';
import 'package:curv/tools/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';

class DeployPage extends StatefulWidget {
  String? title;
  int? outerid;
  String? url;
  int? width;
  int? height;
  int? type; //资源类型,0:图片 1:视频
  DeployPage(
      {Key? key,
      this.title,
      this.outerid,
      this.url,
      this.type,
      this.width,
      this.height})
      : super(key: key);

  @override
  _DeployPageState createState() => _DeployPageState();
}

class _DeployPageState extends State<DeployPage> with TickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final picker = ImagePicker();
  // List<File> images = [];
  File? file;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      _contentController.text = widget.title!;
    }
  }

  String timeFormat(String time) {
    DateTime nowTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(nowTime);
  }

  void add() async {
    if (!AppUtil.isLogin(context)) {
      return;
    }
    if (_contentController.text.isEmpty) {
      EasyLoading.showToast("请输入内容");
      return;
    }

    if (file == null && widget.url == null) {
      EasyLoading.showToast("请选择视频");
      return;
    }
    EasyLoading.show(status: "发布中");
    String? url = widget.url;
    if (file != null) {
      User user = await StorageUtil.getUser();
      List imagesUploads = [];
      // for (int i = 0; i < images.length; i++) {
      //   File file = images[i];
      dynamic response = await ApiService.uploadFile(file);
      var map = response.rawData;
      var key = map["key"];
      // Map resource = {};
      // Map size = FileUtil.getImageSize(file);
      // resource["width"] = size["width"];
      // resource["height"] = size["height"];
      // resource["url"] = AppConfig.QINIUSUFFIX + key;
      // resource["type"] = "video";

      url = AppConfig.QINIUSUFFIX + key;
      // imagesUploads.add(resource);
      // }
    }

    Api2Service.addDeploy(
            _contentController.text,
            file != null
                ? int.parse(videoPlayerController.value.size.width.toString())
                : widget.width,
            file != null
                ? int.parse(videoPlayerController.value.size.height.toString())
                : widget.height,
            file != null ? 1 : widget.type,
            url,
            widget.outerid,
            file != null ? (AppConfig.DOMAIN2 + "?vframe/png/offset/0") : null)
        .then((value) {
      EasyLoading.showSuccess("发布成功");
      EasyLoading.dismiss();
    });
  }

  void chooseImage() async {
    // 1、读取系统权限的弹框
    PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isDenied) {
      EasyLoading.showError("请去设置中心开启访问相册权限");
      return;
    }

    XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      videoPlayerController = VideoPlayerController.file(File(pickedFile.path),
          videoPlayerOptions: VideoPlayerOptions())
        ..initialize().then((_) {
          videoPlayerController.play();

          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });

      if (pickedFile != null) {
        setState(() {
          file = File(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //导航栏右侧菜单
          ElevatedButton(
            child: Text("发送"),
            onPressed: () {
              add();
            },
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: 150,
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: TextField(
                maxLines: 6,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "请输入您想说的话",
                  hintStyle: TextStyle(
                      fontSize: 16, color: Color.fromRGBO(200, 200, 200, 1)),
                  isDense: true,
                  border: InputBorder.none,
                ),
                controller: _contentController,
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        chooseImage();
                      },
                      child: file == null
                          ? (widget.url == null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.add,
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    size: 60,
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      widget.url!,
                                    ),
                                  ),
                                ))
                          : Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child:
                                      videoPlayerController.value.isInitialized
                                          ? AspectRatio(
                                              aspectRatio: videoPlayerController
                                                  .value.aspectRatio,
                                              child: VideoPlayer(
                                                  videoPlayerController),
                                            )
                                          : Container()),
                            ),
                    ),
                    // ...images
                    //     .map((e) => )
                    //     .toList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
