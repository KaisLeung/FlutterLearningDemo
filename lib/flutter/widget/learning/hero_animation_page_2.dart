import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/scheduler.dart' show timeDilation;

///自定义的photo按钮组件
class PhotoButton extends StatelessWidget {
  final String res;
  final Color color;
  final VoidCallback onTap;

  const PhotoButton({Key key, this.res, this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///构建一个图标
    ///点击事件为onTap
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints box) {
            return Image.asset(res, fit: BoxFit.contain);
          },
        ),
      ),
    );
  }
}

///hero展开页的图片组件
class RadialExpansion extends StatelessWidget {
  final double maxRadius; //最大直径
  final clipRectSize; //圆角弧度
  final Widget child;

  const RadialExpansion({Key key, this.maxRadius, this.child})
      : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: child
        ),
      ),
    );
  }
}

class HeroRadialExpansionDemoPage extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;

  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  ///创建径向
  static Tween<Rect> _createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;

    ///底部图标
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero动画演示"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildPhotoButton(context, "images/ic_lollipop.png", "lollipop"),
            _buildPhotoButton(context, "images/ic_hamburg.png", "hamburg"),
            _buildPhotoButton(context, "images/ic_birthday_cake.png", "cake"),
          ],
        ),
      ),
    );
  }

  ///构建底部组件
  Widget _buildPhotoButton(BuildContext context, String res, String desc) {
    return Container(
        width: kMinRadius * 2.0,
        height: kMinRadius * 2.0,
        child: Hero(
            tag: res,
            createRectTween: _createRectTween,
            child: RadialExpansion(
              maxRadius: kMaxRadius,
              child: PhotoButton(
                  res: res,
                  onTap: () {
                    ///展开详情页
                    Navigator.push(context, PageRouteBuilder<void>(pageBuilder:
                        (BuildContext context, Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                      return AnimatedBuilder(
                          animation: animation,
                          builder: (BuildContext context, Widget child) {
                            return Opacity(
                              opacity: opacityCurve.transform(animation.value),
                              child:

                                  ///构建页面
                                  _buildPage(context, res, desc),
                            );
                          });
                    }));
                  }),
            )));
  }

  static Widget _buildPage(BuildContext context, String res, String desc) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                    tag: res,
                    createRectTween: _createRectTween,
                    child: RadialExpansion(
                        maxRadius: kMaxRadius,
                        child: PhotoButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          res: res,
                        ))),
              ),
              Text(
                desc,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
