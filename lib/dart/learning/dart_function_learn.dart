class TestFunction {
  FunctionLearn function = FunctionLearn();

  void start() {
    print(function.sum(1, 2));
  }
}

///Dart方法定义
///方法构成：返回值 + 方法名 + 参数
///返回值类型可缺省，也可以为void或者具体的数据类型
///方法名：匿名方法不需要方法名
///参数：参数类型 + 参数名（参数类型可缺省）。普通参数、可选择参数、参数默认值
class FunctionLearn {
  int sum(int a, int b) {
    return a + b;
  }

  ///私有方法：只有在当前文件才可以访问到
  ///通过下划线标识
  _privateFunc() {}

  ///匿名方法
  anonymousFunction() {
    var list = ['私有方法', '匿名方法'];
    //我们在使用list的foreach方法的时候，使用的就是匿名方法
    //类似于Java中的lambda表达式
    list.forEach((i) {
      print(i);
    });
  }
}
