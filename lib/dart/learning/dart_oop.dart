///定义一个Dart类。所有的类都继承于Object
///在dart中，类构造方法并没有重载的说法，因为我们可以使用{}的方式来定义可选参数，也可以默认赋值
///对于成员的私有参数，可以在初始化列表中进行初始化（不能在{}内默认初始化私有参数）
class Person {
  int id;
  String name;

  //初始化构造方法
  Person(this.id, this.name);

  //重写父类方法
  @override
  String toString() {
    return "id:$id,name:$name";
  }
}

class Student extends Person {
  String school; //通过下划线来标识私有字段
  String _stuMobile;
  String _stuClass;
  String teacherName;
  final String _stuNumber;

  //父类没有默认的无参构造方法，子类必须显式调用父类构造方法
  //构造方法定义后面的冒号“：”为初始化列表
  ///通过this._school初始化自有参数
  ///通过大括号{}定义可选参数,在可选参数中，可以默认赋值
  Student(int id, String name, this._stuMobile, this._stuNumber,
      {this.teacherName, this.school = "HIT"})
      :

        ///初始化列表，除了调用父类构造方法，在子类构造器方法体之前，可以初始化实例变量
        ///不同的初始化变量之间用逗号分隔
        //初始化班级（默认参数）
        _stuClass = '$school:c1',

        ///如果父类没有无参构造方法，则子类必须要显示调用父类的构造方法
        super(id, name) {
    //构造方法体
    print("在构造方法体内（非必须）");
  }

  //默认参数也可以使用在任意方法中
  void fun({String num = "1"}) {}

  ///命名构造方法 [类名.方法名]
  ///使用命名构造方法可以为类实现多个构造方法
  ///类似于Java中我们常写的newInstance()方法，新建一个新的类对象并返回
  Student.newStudent(Student student, this._stuNumber)
      : _stuMobile = student._stuMobile,
        school = student.school,
        _stuClass = student._stuClass,
        teacherName = student.teacherName,
        super(student.id, student.name) {
    print("命名构造方法体...");
  }

  ///工厂构造方法和命名构造方法的结合
  ///factory [类名.方法名]
  ///可以有返回值，并且不需要将类的final变量作为参数，是一种灵活获取类对象的方式
  factory Student.getInstance(Student student) {
    return Student(
        student.id, student.name, student._stuMobile, student._stuNumber);
  }

  ///get \ set 方法
  ///通过get方法获取私有成员变量
  String get stuMobile => _stuMobile;

  set studentMobile(String value) {
    _stuMobile = value;
  }

  @override
  String toString() {
    return 'Student{school: $school, _stuMobile: $_stuMobile, _stuClass: $_stuClass, teacherName: $teacherName, _stuNumber: $_stuNumber}';
  }
}

///工厂构造方法
///类似于单例类
class Logger {
  static Logger _cache;

  factory Logger() {
    if (_cache == null) {
      _cache = Logger._internal();
    }
    return _cache;
  }

  void l(String message) {
    print(message);
  }

  //类的私有命名构造方法
  Logger._internal();

  ///静态方法
  static doPrint(String str) {
    print("static method :doPrint: $str");
  }
}

///抽象类:使用abstract修饰符定义一个抽象类，该类不能被实例化，抽象类在定义接口的时候非常有用
abstract class Animal {
  //定义抽象方法
  void doSomeThing();
}

///继承animal抽象类，并实现其抽象方法
class Dog extends Animal {
  @override
  void doSomeThing() {
    print("I'm a dog!");
  }
}

///为类添加特征：mixins(混合类）
///mixins是在多个类层次结构中重用代码的一种方式
///要使用mixins，在with关键字后面跟上一个或多个mixin的名字（多个则用逗号分隔，并且with要用在extends之后）
///mixins的特征：实现mixin，要创建一个继承object类的子类（不能继承其他类），不声明任何构造方法，不能调用super
///有点类似于Java中的实现接口的关键字implement
class Husky extends Person with Animal {
  Husky(int id, String name) : super(id, name);

  @override
  void doSomeThing() {
    print("I'm a Husky!");
  }
}
