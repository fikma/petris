import 'package:flutter/material.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GamePageInheritedWidget.of(context)!
        .getBoardWidgetLogic
        .generateBoard();
  }
}
