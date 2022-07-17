import 'package:flutter/material.dart';
import 'package:petris/components/gamePageComponent.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/pages/widget/CountDownWidget.dart';
import 'package:petris/pages/widget/boardWidget.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = GamePageInheritedWidget.of(context)!.getGamePageModel;
    var logic = GamePageComponent(pageState: state);

    logic.update();

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("helo"),
            BoardWidget(),
            Text("helo"),
          ],
        ),
        CountDownWidget(),
      ],
    );
  }
}
