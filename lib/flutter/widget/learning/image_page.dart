import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  File _imageFile;

  @override
  void didChangeDependencies() {
    FlutterDownloader.initialize();
    _checkPermission();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    FlutterDownloader.cancelAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片加载"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ///下载图片
          Center(
              child: Container(
            height: 44,
            width: 120,
            child: RaisedButton(
              onPressed: () {
                _fetchImage();
              },
              child: Text("下载图片"),
            ),
          )),

          ///加载本地图片
          Image.asset(
            'images/fluttertest.jpg',
            height: 100,
            width: 150,
          ),

          _imageFile != null ? Image.file(_imageFile) : Text("不存在文件"),

          ///加载相对路径下的图片
          FutureBuilder(
              future: _getLocalFile("dart.jpg"),
              builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                return snapshot.data != null
                    ? Image.file(snapshot.data)
                    : Container(
                        child: Text("相对路径下不存在指定图片"),
                      );
              }),

          ///设置placeholder
          Center(
            child: FadeInImage.assetNetwork(
                placeholder: 'assets/timg.gif',
                image:
                    'http://www.agri35.com/UploadFiles/img_1_1763134258_2725158469_26.jpg'),
          )
        ],
      ),
    );
  }

  Future<String> _getLocalDownloadPath() async {
    Directory tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  Future<File> _getLocalFile(String filename) async {
    String dir = await _getLocalDownloadPath();
    print("加载相对路径目录$dir filename:$filename");
    return new File('$dir/app_flutter/$filename');
  }

  _fetchImage() async {
    final url =
        'http://www.agri35.com/UploadFiles/img_1_1763134258_2725158469_26.jpg';
    final res = await http.get(url);
    final image = img.decodeImage(res.bodyBytes);

    String dowloadPath = await _getLocalDownloadPath() + "/app_flutter";
    print("下载路径：$dowloadPath ");
    Directory downloadDirectory = Directory(dowloadPath);
    bool exists = await downloadDirectory.exists();
    if (!exists) {
      downloadDirectory.create();
    }
    final imageFile = File(path.join(dowloadPath, 'dart.jpg')); // 保存在应用文件夹内
    await imageFile.writeAsBytes(img.encodePng(image)); // 需要使用与图片格式对应的encode方法

    setState(() {
      _imageFile = imageFile;
    });

    // 打印各种属性以验证文件保存成功
    print(imageFile.path);
    print(imageFile.statSync());
  }

  ///获取权限
  Future<bool> _checkPermission() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      //判断是否为android平台，调取android平台的权限获取方法
      //获取读写权限
      PermissionStatus permissionStatus = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permissionStatus != PermissionStatus.granted) {
        //未拥有权限
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          //申请权限通过
          return true;
        }
      } else {
        //已拥有权限
        return true;
      }
    } else {
      ///获取IOS的读写权限
      ///todo 暂不实现
      return false;
    }
    return false;
  }
}
