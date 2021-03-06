import 'package:flutter/material.dart';
import 'package:petris/pages/gamePage.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePageInheritedWidget(child: const GamePage()),
    );
  }
}
