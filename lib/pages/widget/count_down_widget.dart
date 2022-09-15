import 'package:flutter/material.dart';
import 'package:petris/components/count_down_widget_component.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/utils/board_config.dart';

class CountDownWidget extends StatefulWidget {
  final BoardWidgetModel boardWidgetModel;
  final CountDownWidgetModel countDownWidgetModel;
  final GamePageModel gamePageModel;
  final HudWidgetModel hudWidgetModel;

  CountDownWidget({
    Key? key,
    required this.boardWidgetModel,
    required this.gamePageModel,
    required this.countDownWidgetModel,
    required this.hudWidgetModel,
    required FocusNode nextFocus,
  }) : super(key: key) {
    countDownWidgetModel.nextFocus = nextFocus;
  }

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  @override
  void initState() {
    super.initState();

    CountDownWidgetComponent(
      boardWidgetModel: widget.boardWidgetModel,
      gamePageModel: widget.gamePageModel,
      countDownWidgetModel: widget.countDownWidgetModel,
      hudWidgetModel: widget.hudWidgetModel,
    );

    widget.countDownWidgetModel.updateCallback = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    var mainWidget = (widget.countDownWidgetModel.countStarted)
        ? Text(widget.countDownWidgetModel.text)
        : ElevatedButton(
            onPressed: () {
              widget.countDownWidgetModel.counter = 3;
              widget.countDownWidgetModel.countStarted = true;
              widget.gamePageModel.gameStatePaused = true;
            },
            child: Text(widget.countDownWidgetModel.text),
          );

    var container = Container(
      width: BoardConfig.blockSize * BoardConfig.xSize.toDouble(),
      height: BoardConfig.blockSize * 3,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          mainWidget,
        ],
      ),
    );

    return Visibility(
      visible: widget.countDownWidgetModel.visible,
      child: Center(child: container),
    );
  }
}
