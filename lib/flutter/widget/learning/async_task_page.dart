import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image/image.dart';

///异步任务
///async Future FutureBuilder
///什么是Future？
///Future表示在接下来的某个时间的值或错误，借助Future我们可以在Flutter实现异步操作。
//
///它类似于ES6中的Promise，提供then和catchError的链式调用；
//
///Future是dart:async包中的一个类，使用它时需要导入dart:async包，Future有两种状态：
//
///pending - 执行中；
///completed - 执行结束，分两种情况要么成功要么失败；
///Future的常见用法？
///使用future.then获取future的值与捕获future的异常
///结合async,await
///future.whenComplete
///future.timeout
///使用future.then获取future的值与捕获future的异常
class AsyncTaskPage extends StatefulWidget {
  @override
  _AsyncTaskPageState createState() => _AsyncTaskPageState();
}

class _AsyncTaskPageState extends State<AsyncTaskPage> {
  String _count = '0';
  String logStr = '';

  Future<String> _getFutureValue() {
    return Future.value("welcome to future!");
  }

  ///异步任务
  ///延时获取数据
  ///Future是异步的，如果我们要将异步转同步，那么可以借助async await来完成。
  Future<String> _getAsyncValue() async {
    String result = await Future.delayed(Duration(milliseconds: 2000), () {
      return Future.value("100");
    });
    setState(() {
      logStr += "time3:" + DateTime.now().toString() + ",value :$result\n";
    });
  }

  ///模拟网络请求
  ///延时返回数据
  Future<String> _mockNetworkData() async{
    //2秒后返回数据
    return Future.delayed(Duration(milliseconds: 2000),(){
      return Future<String>.value("future builder");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("异步任务 Demo"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  logStr += "time1:" +
                      DateTime.now().toString() +
                      ",value :$_count\n";
                  _getAsyncValue();

                  ///有时候我们需要在Future结束的时候做些事情
                  ///我们知道then().catchError()的模式类似于try-catch，try-catch有个finally代码块
                  ///而future.whenComplete就是Future的finally。
                  _getFutureValue()
                      .then((s) {
                        print(s);
                      }, onError: (error) {
                        print(error);
                      })
                      .catchError(print)
                      .whenComplete(() {
                        print("complete");
                      });
                  logStr += "time2:" +
                      DateTime.now().toString() +
                      ",value :$_count\n";
                });
              },
              child: Text('开始任务'),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  child: Text(logStr),
                ),
              ),
            ),
            ///什么是FutureBuilder？
            ///FutureBuilder是一个将异步操作和异步UI更新结合在一起的类，通过它我们可以将网络请求，数据库读取等的结果更新的页面上。
            ///FutureBuilder的构造方法
            ///
            /// future： Future对象表示此构建器当前连接的异步计算；
            ///initialData： 表示一个非空的Future完成前的初始化数据；
            ///builder： AsyncWidgetBuilder类型的回到函数，是一个基于异步交互构建widget的函数；
            ///这个builder函数接受两个参数BuildContext context 与 AsyncSnapshot<T> snapshot，它返回一个widget。AsyncSnapshot包含异步计算的信息，它具有以下属性：
            ///
            ///connectionState - 枚举ConnectionState的值，表示与异步计算的连接状态，ConnectionState有四个值：none，waiting，active和done；
            ///data - 异步计算接收的最新数据；
            ///error - 异步计算接收的最新错误对象；
            ///
            ///AsyncSnapshot还具有hasData和hasError属性，以分别检查它是否包含非空数据值或错误值。
            ///
            ///现在我们可以看到使用FutureBuilder的基本模式。 在创建新的FutureBuilder对象时，我们将Future对象作为要处理的异步计算传递。 在构建器函数中，我们检查connectionState的值，并使用AsyncSnapshot中的数据或错误返回不同的窗口小部件。
            FutureBuilder<String>(

                ///注意要传入future异步计算器
                future: _mockNetworkData(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("please start a url request!");
                    case ConnectionState.active:
                      return Text("active");
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      } else {
                        return Text("error");
                      }
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return Text("default");
                  }
                }),
          ],
        ));
  }
}
