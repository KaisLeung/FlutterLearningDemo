import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///打开第三方应用
class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('打开第三方应用'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///打开浏览器
            RaisedButton(
              onPressed: _launchURL,
              child: Text("打开浏览器"),
            ),
            RaisedButton(
              onPressed: _openMap,
              child: Text("打开地图"),
            ),
          ],
        ),
      ),
    );
  }

  ///打开浏览器
  _launchURL() async {
    const url = 'https://www.baidu.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///通过schema协议打开第三方应用
  _openMap() async {
    //Android
    const url = 'geo:118.118,118.118'; //Google地图提供的schema协议地址
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //IOS
      const url = 'http://maps.apple.com/?=118.118,118.118';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch Map:$url';
      }
    }
  }
}
