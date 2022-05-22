import 'package:flutter/material.dart';
import 'package:petris/pages/widget/boardWidget.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GamePageInheritedWidget(
      child: const BoardWidget(),
    );
  }
}
