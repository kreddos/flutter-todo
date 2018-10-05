import 'package:flutter/material.dart';
import 'todolist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name generator',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new TodoList(),
    );
  }
}
