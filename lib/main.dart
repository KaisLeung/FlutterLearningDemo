import 'package:flutter/material.dart';
import 'package:flutter_app/dart/learning/dart_oop.dart';
import 'package:flutter_app/flutter/widget/learning/animation_learning_page.dart';
import 'package:flutter_app/flutter/widget/learning/flutter_layout_page.dart';
import 'package:flutter_app/flutter/widget/learning/less_group_page.dart';
import 'package:flutter_app/flutter/widget/learning/stateful_group_page.dart';

import 'flutter/widget/learning/app_lifecycle.dart';
import 'flutter/widget/learning/async_task_page.dart';
import 'flutter/widget/learning/flutter_widget_lifecycle.dart';
import 'flutter/widget/learning/getsture_page.dart';
import 'flutter/widget/learning/hero_animation_page.dart';
import 'flutter/widget/learning/hero_animation_page_2.dart';
import 'flutter/widget/learning/http_learning_page.dart';
import 'flutter/widget/learning/image_page.dart';
import 'flutter/widget/learning/launch_page.dart';
import 'flutter/widget/learning/photo_page.dart';
import 'flutter/widget/learning/pub_learning.dart';
import 'flutter/widget/learning/shared_preferences_page.dart';

void main() => runApp(MainPage());

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Data',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text("main"),
//        ),
//        body: Container(
//          child: RouteNavigatePage(),
//        ),
//      ),
//      //设置路由
//      routes: <String, WidgetBuilder>{
//        'less': (BuildContext context) => LessGroupPage(),
//        'stateful': (BuildContext context) => StatefulGroupPage(),
//        'flutterlayout': (BuildContext context) => FlutterLayoutPage(),
//        'plugin': (BuildContext context) => PubLearning(),
//      },
//    );
//  }
//}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data',
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("main"),
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  _brightness = _brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light;
                });
              },
              child: Text("切换主题"),
            ),
            RouteNavigatePage(),
          ],
        ),
      ),
      //设置路由
      routes: <String, WidgetBuilder>{
        'less': (BuildContext context) => LessGroupPage(),
        'stateful': (BuildContext context) => StatefulGroupPage(),
        'flutterlayout': (BuildContext context) => FlutterLayoutPage(),
        'widgetlifecycle': (BuildContext context) => WidgetLifeCyclePage(),
        'applifecycle': (BuildContext context) => AppLifeCycle(),
        'plugin': (BuildContext context) => PubLearning(),
        'getsture': (BuildContext context) => GetSturePage(),
        'imageLoad': (BuildContext context) => ImagePage(),
        'animation': (BuildContext context) => AnimationLearningPage(),
        'hero': (BuildContext context) => HeroAnimationPage(),
        'hero2': (BuildContext context) => HeroRadialExpansionDemoPage(),
        'openUrl': (BuildContext context) => LaunchPage(),
        'asyncTask': (BuildContext context) => AsyncTaskPage(),
        'http': (BuildContext context) => HttpLearningPage(),
        'spdemo': (BuildContext context) => SharedpreferencesLearningPage(),
        'pickphoto': (BuildContext context) => PhotoPage(),
      },
    );
  }
}

class RouteNavigatePage extends StatefulWidget {
  @override
  _RouteNavigatePageState createState() => _RouteNavigatePageState();
}

class _RouteNavigatePageState extends State<RouteNavigatePage> {
  int _counter = 0;
  bool byName = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///工厂构造方法的演示
//    Logger().l("工厂构造方法 Logger：====test====");
//    _factoryLearn();
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
              value: byName,
              title: Text('${byName ? '' : '不'}通过路由名进行跳转'),
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              }),
          _buttonItem("StateLessWidget基础组件", LessGroupPage(), "less"),
          _buttonItem("StateFulWidget基础组件", StatefulGroupPage(), "stateful"),
          _buttonItem("Flutter布局DEMO", FlutterLayoutPage(), "flutterlayout"),
          _buttonItem(
              "Flutter Widget生命周期", WidgetLifeCyclePage(), "widgetlifecycle"),
          _buttonItem("Flutter App生命周期", AppLifeCycle(), "applifecycle"),
          _buttonItem("Flutter插件引用DEMO", PubLearning(), "plugin"),
          _buttonItem("手势操作DEMO", GetSturePage(), "getsture"),
          _buttonItem("图片加载DEMO", ImagePage(), "imageLoad"),
          _buttonItem("动画演示DEMO", AnimationLearningPage(), "animation"),
          _buttonItem("Hero动画演示DEMO", HeroAnimationPage(), "hero"),
          _buttonItem("Hero动画演示DEMO-2", HeroRadialExpansionDemoPage(), "hero2"),
          _buttonItem("异步任务Demo", AsyncTaskPage(), "asyncTask"),
          _buttonItem("Http网络请求", HttpLearningPage(), "http"),
          _buttonItem("SP缓存本地数据", SharedpreferencesLearningPage(), "spdemo"),
          _buttonItem("打开第三方应用DEMO", LaunchPage(), "openUrl"),
          _buttonItem("相机、相册DEMO", PhotoPage(), "pickphoto"),
        ],
      ),
    );
  }

  _buttonItem(String buttonName, page, String routeName) {
    return Container(
      child: RaisedButton(
          onPressed: () {
            if (byName) {
              //通过路由名跳转
              Navigator.pushNamed(context, routeName);
            } else {
              //使用navigation跳转
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            }
          },
          child: Directionality(
              textDirection: TextDirection.ltr, child: Text(buttonName))),
    );
  }

  void _factoryLearn() {
    Logger l1 = Logger();
    Logger l2 = Logger();
    bool b = l1 == l2;
    print("验证Logger是否为工厂构造方法：" + b.toString());
    Student stu1 =
        Student.getInstance(Student(1, "kai", "13800000000", "1001"));
    Student stu2 =
        Student.getInstance(Student(1, "kai", "13800000000", "1002"));
    Student stu3 = Student.newStudent(
        Student(1, "kai", "13800000000", "1003", teacherName: "teacherLi"),
        "12345");
    bool b2 = stu1 == stu2;
    print("验证Student1和Student2是否为同一个对象：" + b2.toString());
    print("stu3：" + stu3.toString());
  }
}
