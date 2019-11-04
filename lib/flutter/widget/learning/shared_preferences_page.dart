import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///使用Sharedpreferences保存数据到本地
///简单的，异步的，持久化的key-value存储系统；
///在Android上它是基于SharedPreferences的；
///在iOS上它是基于NSUserDefaults的；
class SharedpreferencesLearningPage extends StatefulWidget {
  @override
  _SharedpreferencesLearningPageState createState() =>
      _SharedpreferencesLearningPageState();
}

class _SharedpreferencesLearningPageState
    extends State<SharedpreferencesLearningPage> {
  int _count = 0;
  int _spCount = 0;

  _setSpData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("count", _count);
  }

  _getSpData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _spCount = sp.getInt("count") ?? 0;
    });
  }

  _clearSpData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("count");
    setState(() {
      _spCount = sp.getInt("count") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("使用Sharedpreferences缓存数据"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _count++;

                ///将数据缓存到SP文件中
                _setSpData();
              });
            },
            child: Text("count加1"),
          ),
          RaisedButton(
            onPressed: () {
              ///获取缓存的数据
              _getSpData();
            },
            child: Text("获取本地数据"),
          ),
          RaisedButton(
            onPressed: () {
              ///清空缓存数据
              _clearSpData();
            },
            child: Text("清空sp数据"),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text("数据：$_count"),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text("SP文件缓存的数据：$_spCount"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
