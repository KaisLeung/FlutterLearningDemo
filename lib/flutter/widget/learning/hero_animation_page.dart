import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:path/path.dart';

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Image.asset(
                photo,
                fit: BoxFit.contain,
              ),
            ),
          )),
    );
  }
}

class HeroAnimationPage extends StatelessWidget {
  String _photoUrl =
      "images/rocket.png";

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text("Hero动画测试"),
      ),
      body: Center(
        child: HeroAnimation(
          photo: _photoUrl,
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Hero的第二个页面"),
                ),
                body: Container(
                  color: Colors.blue[300],
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: HeroAnimation(
                    photo: _photoUrl,
                    width: 100.0,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}
