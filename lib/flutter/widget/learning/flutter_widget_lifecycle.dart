import 'package:flutter/material.dart';

///Flutter页面的生命周期
///Flutter Widget的生命周期重点讲解StatefulWidget的生命周期
///因为无状态的widget StatelessWidget只有createElement、与build两个生命周期方法
///StatefulWidget的生命周期方法按照时期不同可以分为三组：
///1.初始化时期
///createState、initState
///2.更新期间
///didChangeDependencies、build、didUpdateWidget
///3.销毁期
///deactivate、dispose
///扩展阅读：
///http://www.devio.org/io/flutter_app/img/blog/flutter-widget-lifecycle.png
///https://flutterbyexample.com/stateful-widget-lifecycle/
class WidgetLifeCyclePage extends StatefulWidget {
  @override
  _WidgetLifeCyclePageState createState() => _WidgetLifeCyclePageState();
}

class _WidgetLifeCyclePageState extends State<WidgetLifeCyclePage> {
  int _count = 0;

  ///创建页面widget时调用的第一个生命周期方法
  ///类似于Android的onCreate()和IOS的viewDidLoad()
  ///通常会在这个生命周期回调方法中做一些初始化工作，比如channel的初始化、监听器的初始化
  @override
  void initState() {
    super.initState();
    print("----initState----");
  }

  ///当一来的state对象改变时调用
  ///a.在第一次构建widget时，在initState()之后立即调用
  ///b.如果的StatefulWidgets依赖于InheritedWidget，那么当当前State所依赖InheritedWidget中的变量改变时会再次调用它
  ///拓展：InheritedWidget可以高效的将数据在Widget树中向下传递、共享，可参考：https://book.flutterchina.club/chapter7/inherited_widget.html
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("----didChangeDependencies----");
  }

  ///这是一个必须实现的方法，在这里实现你要呈现的页面内容：
  ///我们会在这个方法中实现页面布局的渲染
  ///它会在在didChangeDependencies()之后立即调用；
  ///另外当调用setState后也会再次调用该方法；
  @override
  Widget build(BuildContext context) {
    print('---build-----');
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Widget生命周期"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(onPressed: (){
              setState(() {
                ///改变页面的数据，变更状态值
                ///setState()方法会出发build()生命周期
                _count ++;
              });
            },child: Text("点击增加次数"),),
            Text("当前数值 ： $_count")
          ],
        ),
      ),
    );
  }

  ///这是一个不常用到的生命周期方法，当父组件需要重新绘制时才会调用；
  ///该方法会携带一个oldWidget参数，可以将其与当前的widget进行对比以便执行一些额外的逻辑，如：
  /// if (oldWidget.xxx != widget.xxx)...
  @override
  void didUpdateWidget(WidgetLifeCyclePage oldWidget) {
    print("----didUpdateWidget----");
    super.didUpdateWidget(oldWidget);
  }

  ///很少使用，在组件被移除时调用在dispose之前调用
  ///有点类似于Android中Fragment 的onDetachActivity()方法
  @override
  void deactivate() {
    print("----deactivate----");
    super.deactivate();
  }

  ///常用，组件被销毁时调用：
  ///通常在该方法中执行一些资源的释放工作比如，监听器的卸载，channel的销毁等
  @override
  void dispose() {
    print('-----dispose------');
    super.dispose();
  }

}
