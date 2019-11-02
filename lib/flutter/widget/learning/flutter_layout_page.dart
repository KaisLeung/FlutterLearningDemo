import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

///Flutter的布局组件

class FlutterLayoutPage extends StatefulWidget {
  @override
  _FlutterLayoutPageState createState() => _FlutterLayoutPageState();
}

class _FlutterLayoutPageState extends State<FlutterLayoutPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          title: Text('StatefulWidget的学习'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex, //设置当前所指向的item
            onTap: (index) {
              //点击事件
              setState(() {
                //通过setState方法来改变当前页面的渲染状态
                _currentIndex = index;
              });
            },

            ///设置底部导航栏
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  title: Text("首页")),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.menu,
                    color: Colors.blue,
                  ),
                  title: Text("列表")),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.camera,
                    color: Colors.blue,
                  ),
                  title: Text("朋友圈")),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.chat,
                    color: Colors.blue,
                  ),
                  title: Text("消息")),
            ]),

        ///悬浮按钮
        floatingActionButton:
            FloatingActionButton(child: Text("点我"), onPressed: null),
        body: _currentIndex == 0

            ///刷新组件 RefreshIndicator
            ? RefreshIndicator(

                ///RefreshIndicator刷新组件必须搭配ListView组件使用
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      "https://img4.mukewang.com/545862440001cef302200220-140-140.jpg"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    //裁切圆角，弧度为10
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Opacity(
                                      //设置透明度为0.5
                                      opacity: 0.5,
                                      child: Image.network(
                                          "https://img4.mukewang.com/545862440001cef302200220-140-140.jpg",
                                          width: 100,
                                          height: 100),
                                    )),
                              ),
                            ],
                          ),
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onRefresh: _handleRefresh)
            : _currentIndex == 1
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Text("我是列表页"),
                        ///加载本地图片
                        Image(image: AssetImage('images/test.jpg'),width: 100,height: 100,),

                        ///输入框组件
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              hintText: "请输入文字",
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: ColorUtil.color("#999999"))),
                        ),
                        Container(
                          height: 100,
                          margin: EdgeInsets.all(20),
                          child: PhysicalModel(
                            //设置有圆角弧度的pageview
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            clipBehavior: Clip.antiAlias, //抗锯齿裁切圆角
                            ///PageView 轮播图控件
                            child: PageView(
                              children: <Widget>[
                                _item("page1", Colors.blue),
                                _item("page2", Colors.green),
                                _item("page3", Colors.red),
                                _item("page4", Colors.yellowAccent),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.greenAccent),
                                child: Text("宽度撑满"),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          //堆栈布局，类似于Android中的FrameLayout
                          children: <Widget>[
                            Image.network(
                              "https://img4.mukewang.com/545862440001cef302200220-140-140.jpg",
                              width: 100,
                              height: 100,
                            ),
                            Positioned(
                              //位置布局：设置图片位于父布局中的左下角位置（相对于父布局使用）
                              child: Image.network(
                                "https://flutter.dev/images/flutter-mono-81x100.png",
                                width: 30,
                                height: 30,
                              ),
                              left: 5,
                              bottom: 5,
                            )
                          ],
                        ),
                        Wrap(
                          spacing: 10, //水平边距
                          runSpacing: 6, //垂直边距
                          //创建一个Wrap布局，从左到右排列，可以自动换行（常用于实现标签流布局）
                          children: <Widget>[
                            _chip("flutter"),
                            _chip("好朋友"),
                            _chip("愿圣光指引着你"),
                            _chip("魔兽世界"),
                            _chip("新年好"),
                            _chip("大地母亲在忽悠着你"),
                            _chip("Hello World"),
                          ],
                        )
                      ],
                    ),
                  )
                : _currentIndex == 2
                    ? Column(
                        children: <Widget>[
                          Text("界面3：列表"),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.red),
                              child: Text("拉伸填满布局高度"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Text("拉伸填满布局高度"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.green),
                              child: Text("拉伸填满布局高度"),
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Text("界面4：列表横向填满"),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.red),
                              child: Text("拉伸填满布局高度"),
                            ),
                          )
                        ],
                      ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  _item(String s, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        s,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(0, 1),
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
