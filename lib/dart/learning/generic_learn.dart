import 'package:flutter_app/dart/learning/dart_oop.dart';

class TestGeneric {
  void start() {
    Cache<String> cacheString = Cache();
    cacheString.setItem("1", "kais");
//    cacheString.setItem("1", 11);//编译报错

    CacheAnimal cacheAnimal = CacheAnimal(Dog());
//  CacheAnimal cacheAnimal = CacheAnimal(Student.getInstance(Student(1, "222", "2124", "124214")));//编译报错
  }
}

///泛型
///泛型主要是解决类、接口、方法的复用性，以及对不确定数据类型的支持
class Cache<T> {
  static final Map<String, Object> _cacheMap = Map();

  void setItem(String key, T value) {
    _cacheMap[key] = value;
  }

  T getItem(String key) {
    return _cacheMap[key];
  }
}

///约束泛型
class CacheAnimal<T extends Animal> {
  T _animal;

  ///这里约束泛型T为Animal类型
  CacheAnimal(this._animal);
}
