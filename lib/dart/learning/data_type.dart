import 'package:flutter/material.dart';

class DataType extends StatefulWidget {
  @override
  _DataTypeState createState() => _DataTypeState();
}

class _DataTypeState extends State<DataType> {
  @override
  Widget build(BuildContext context) {
//    _numType();
//    _stringType();
//    _boolType();
//    _listType();
//    _mapType();
    _typeTip();
    return Container();
  }

  void _numType() {
    num num1 = 1; //num是数字类型的父类
    num num2 = -1.0;
    int int1 = 2;
    double d1 = 1.22;
    print("num1:$num1 ,num2:$num2 , int : $int1, double:$d1");
    print(num2.abs());
    print(d1.toInt());
    print(num1.toDouble());
  }

  void _stringType() {
    String str1 = '单引号Hello World';
    String str2 = "双引号 Hello World";
    print("用 \+ 号拼接字符串：" + str1 + str2);
    print("用 \$ 连接字符串 : $str1 $str2");
    print(str1.startsWith('单'));
    print(str1.startsWith(new RegExp(r'[A-Z][a-z]')));
  }

  void _boolType() {
    bool success = true, error = false;
    print(success);
    print(error);
  }

  void _listType() {
    print("集合类型");

    ///集合的初始化方式
    List list = [1, 2, 3, 4, '字符串', true]; //初始化时添加的元素随意
    print("未指明集合类型：$list");
    List<int> intList = [1, 3, 4, 7]; //指定泛型类型
//    intList = list;//错误的赋值形式。不可以将未确定泛型类型的集合赋值给确定泛型类型的集合
    List list3 = [];
    list3.add(10);
    list3.add("12");
    list.addAll(intList);

    ///使用集合生成函数,元素值为索引值乘以2
    ///第一个参数为集合总长度，第二个参数为赋值方法，index为索引值
    List newList = List.generate(10, (index) => index * 2);
    print(newList);

    ///集合遍历
    for (int i = 0; i < newList.length; i++) {
//      print(newList[i]);
    }
    //方式2 （类似于java中的foreach）
    for (var o in newList) {
//      print(o);
    }
    //方式3:调用List的foreach方法
    newList.forEach((val) {
//      print(val);
    });

    //remove
    intList.removeWhere((item) => item % 2 == 0);
    print("处理后的intList：$intList");
    //insert
    intList.insert(2, 188);
    print("insert 188 ：$intList");
    //sublist
    List subList = list.sublist(3, 5);
    print("取list 3~5 区间 ： $subList");
  }

  ///map是key和Value关联的对象集合，key和value都可以是任何类型的对象，并且key是唯一的
  void _mapType() {
    //类似于JSON格式
    Map map = {"id": 1001, "name": "kais"};
    print(map);
    map["id"] = 1003;
    print("改变map key对应的value： $map");
    //添加元素
    Map map2 = {};
    map2["id"] = 1005;
    map2["name"] = "Qing";
    print("map 2 : $map2");

    //遍历
    map2.forEach((k, v) {
      print("遍历元素 $k : $v");
    });
    //reverse map key and value
    Map map3 = map2.map((k, v) {
      /** Creates an entry with [key] and [value]. */
      return MapEntry(v, k);
    });
    print("reverse map : $map3");
    //for循环遍历
    for (var k in map2.keys) {
      print("$k : ${map2[k]}");
    }
    //移除某个键值对
    map2.remove("id");
    //判断是否存在对应的key
    print("if containsKey: ${map2.containsKey("id")}");
  }

  ///dynamic、var、object的区别
  _typeTip() {
    //dynamic类型，顾名思义，这是个动态类型，只有在运行时才会检查数据类型，
    //编译期并不会检查数据类型及正确性
    dynamic d1 = "1";
//    dynamic d2 = d1 + 1;
    print("d1 runtime type: ${d1.runtimeType}"); //打印运行时的数据类型
    //var类型，类似于泛型，在赋值的时候，编译期间就明确数据类型
    var var1 = "kai";
//    var var2 = var1 + 1;//编译不通过
    print("var1 runtime type: ${var1.runtimeType}"); //打印运行时的数据类型
    //object类型：万物始于object，对象的基类，可以使用object中的方法
    Object o1 = "qing";
    Object o2 = 123;
    print("o2 runtime type: ${o2.runtimeType}");
    print("o2 hashcode:${o2.hashCode}");
  }
}
