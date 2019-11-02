import 'package:flutter/material.dart';

class AnimationLearningPage extends StatefulWidget {
  @override
  _AnimationLearningPageState createState() => _AnimationLearningPageState();
}

class _AnimationLearningPageState extends State<AnimationLearningPage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  Animation animationColor;
  AnimationController animationController;

  double animationValue;
  AnimationStatus animationState;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController)
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          animationState = status;
        });
      });
    animationColor = ColorTween(begin: Colors.blue[100], end: Colors.blue[900])
        .animate(animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((AnimationStatus status) {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animationColor.value,
      appBar: AppBar(
        title: Text("动画使用"),
        leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: <Widget>[
          ///开启动画
          Center(
              child: Container(
            height: 44,
            width: 120,
            child: RaisedButton(
              onPressed: () {
                _resetAnimation();
              },
              child: Text("开启动画"),
            ),
          )),
          Center(
            child: Text("动画属性值：$animationValue"),
          ),
          Center(
            child: Text("动画状态：$animationState"),
          ),
          Center(
            child: Container(
              child: Image.asset('images/xieyan.jpg'),
              height: animation.value,
              width: animation.value,
            ),
          ),
          Center(
            child: MyAnimationWidget(
              animation: animation,
            ),
          ),
          Center(
            child: GrowTransition(
                animation: animation,
                child: Icon(Icons.android,color: Colors.green)),
          ),
        ],
      ),
    );
  }

  ///重置动画并重新播放
  void _resetAnimation() {
    animationController.reset();
    animationController.forward();
  }

  @override
  void dispose() {
    this.animationController.stop();
    super.dispose();
  }
}

///使用AnimatedWidget实现动画
class MyAnimationWidget extends AnimatedWidget {
  MyAnimationWidget({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        child: FlutterLogo(
          colors: Colors.red,
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}

///使用AnimatedBuilder构造动画
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (context, child) => Container(
              child: this.child,
              height: animation.value,
              width: animation.value,
            ));
  }
}
