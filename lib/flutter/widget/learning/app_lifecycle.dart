import 'dart:math';

import 'package:flutter/material.dart';

///如何获取Flutter应用维度生命周期
///WidgetsBindingObserver：是一个Widgets绑定观察器，通过它我们可以监听应用的生命周期、语言等的变化
class AppLifeCycle extends StatefulWidget {
  @override
  _AppLifeCycleState createState() => _AppLifeCycleState();
}

class _AppLifeCycleState extends State<AppLifeCycle>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App应用声明周期监听"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          child: Text("App生命周期"),
        ),
      ),
    );
  }

  ///监听App的生命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("state = $state");
    if (state == AppLifecycleState.paused) {
      print("App进入后台");
    } else if (state == AppLifecycleState.resumed) {
      print("App进入前台");
    } else if (state == AppLifecycleState.inactive) {
      //不常用：应用程序处于非活动状态，并且未接收用户输入时调用，比如：来了个电话
    } else if (state == AppLifecycleState.suspending) {
      //不常用：应用程序被挂起是调用，它不会在iOS上触发
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
