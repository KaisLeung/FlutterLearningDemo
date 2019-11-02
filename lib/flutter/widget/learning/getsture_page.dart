import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetSturePage extends StatefulWidget {
  @override
  _GetSturePageState createState() => _GetSturePageState();
}

class _GetSturePageState extends State<GetSturePage> {
  String printString = '';
  double moveX = 0, moveY = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("手势检测"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ///flutter中，手势操作委托给GestureDetector处理
                  GestureDetector(
                    onTap: () => _printMsg('点击'),
                    onDoubleTap: () => _printMsg('双击'),
                    onLongPress: () => _printMsg('长按'),
                    onTapCancel: () => _printMsg('点击后取消'),
                    onTapUp: (e) => _printMsg('点击后松开---手势'),
                    onTapDown: (e) => _printMsg('点击后按下---手势'),
                    child: Container(
                      padding: EdgeInsets.all(60),
                      decoration: BoxDecoration(color: Colors.blueAccent),
                      child: Text(
                        '测试点击事件',
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                    ),
                  ),

                  ///输出点击后拼接的字符串
                  Text(printString)
                ],
              ),

              ///拖动小球：监听手指的滑动事件
              Positioned(
                left: moveX,
                top: moveY,
                child: GestureDetector(
                  onPanUpdate: (e) => _doMove(e),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(36)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _printMsg(String s) {
    setState(() {
      printString += ' , $s';
    });
  }

  _doMove(DragUpdateDetails e) {
    setState(() {
      moveX += e.delta.dx;
      moveY += e.delta.dy;
    });
  }
}
