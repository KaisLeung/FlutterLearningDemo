import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

///StatelessWidget与基础组件
///顾名思义，无状态组件，即其渲染结果与组件的生命周期无关，可以这么理解，就是一个静态组件
///其子类组件包含有Text、Icon、CloseButton、BackButton、Chip等等

class LessGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 25);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatelessWidget与基础组件'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('I am Text', style: textStyle),
              Icon(
                Icons.android,
                size: 50,
                color: Colors.green,
              ),
              CloseButton(),
              BackButton(),
              Divider(
                ///分割线（无法设置高度）
                height: 50, //设置容器高度（注意不是线的高度）
                indent: 10, //设置左侧间距
                endIndent: 10, //设置右侧间距
                //该组件无法设置分割线高度
                color: ColorUtil.color("#999999"),
              ),
              Container(

                  ///如果需要有高度的分割线，我们可以使用container并设置高度和背景色
                  height: 5,
                  color: ColorUtil.color("#999999")),
              Chip(

                  ///material design中的一个小部件，可以查看MD官网https://www.material.io/
                  ///并搜索chip组件
                  avatar: Icon(Icons.people),
                  label: Text("StatelessWidget与基组件")),
              Card(
                ///MD风格的卡片组件（在Android中类似于Card）
                color: Colors.blue,
                elevation: 5, //阴影宽度
                margin: EdgeInsets.all(10), //外间距
                child: Container(
                  padding: EdgeInsets.all(10), //内间距
                  child: Text("I am Card", style: textStyle),
                ),
              ),
              AlertDialog(
                ///弹窗组件
                title: Text("警告！"),
                content: Text("弹窗测试"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
