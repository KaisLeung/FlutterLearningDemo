import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///请求地址：https://api.myjson.com/bins/127n0g
class HttpLearningPage extends StatefulWidget {
  @override
  _HttpLearningPageState createState() => _HttpLearningPageState();
}

class _HttpLearningPageState extends State<HttpLearningPage> {
  String _result = '';

  Future<UserModel> _getUser() async {
    final futureResp = await http.get('https://api.myjson.com/bins/127n0g');
    final result = json.decode(futureResp.body);
    return UserModel.fromJson(result);
  }

  Future<UserListModel> _getUserList() async {
    final futureResp = await http.get('https://api.myjson.com/bins/p8e0w');
    final result = json.decode(futureResp.body);
    return UserListModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http网络请求'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              ///执行网络请求
              _getUser().then((value) {
                setState(() {
                  _result = "返回结果：name = ${value.name}";
                });
              });
            },
            child: Text("GET : Common"),
          ),
          RaisedButton(
            onPressed: () {
              ///执行网络请求
              _getUserList().then((value) {
                setState(() {
                  _result += "返回List结果：list = ${value.list[0].account}";
                });
              });
            },
            child: Text("GET : List"),
          ),
          Center(
            child: Text(_result),
          )
        ],
      ),
    );
  }
}

///网络请求返回的数据实体类
class UserModel {
  final String name;
  final String sex;
  final String age;

  UserModel({this.name, this.sex, this.age});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      sex: json['sex'],
      age: json['age'],
    );
  }
}

///复杂类型的Json
///https://api.myjson.com/bins/p8e0w
class UserListModel {
  final String name;
  final String sex;
  final String age;
  final List<ListDataModel> list;

  UserListModel({this.name, this.sex, this.age, this.list});

  factory UserListModel.fromJson(Map<String, dynamic> json) {
//    List<ListDataModel> list = (json['list'])
    return UserListModel(
      name: json['name'],
      sex: json['sex'],
      age: json['age'],
      list: (json['data'] as List)
          .map((value) => ListDataModel.fromJson(value))
          .toList(),
    );
  }
}

class ListDataModel {
  final String account;
  final String job;

  ListDataModel({this.account, this.job});

  factory ListDataModel.fromJson(Map<String, dynamic> json) {
    return ListDataModel(
      account: json['account'],
      job: json['job'],
    );
  }
}
