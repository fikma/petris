import 'package:flutter/material.dart';
import 'package:petris/logics/input_event_logic.dart';

class ControlButtons extends StatefulWidget {
  final InputEventLogic inputEventLogic;

  const ControlButtons({
    super.key,
    required this.inputEventLogic,
  });

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  @override
  Widget build(BuildContext context) {
    var top = Row(
      children: [
        SizedBox(
          width: 45,
          height: 30,
          child: ElevatedButton(
            onPressed: widget.inputEventLogic.upButtonCallback,
            child: const Icon(
              Icons.arrow_upward,
              size: 10.0,
            ),
          ),
        ),
      ],
    );
    var middle = Row(
      children: [
        SizedBox(
          width: 45,
          height: 30,
          child: ElevatedButton(
            onPressed: widget.inputEventLogic.leftButtonCallback,
            child: const Icon(
              Icons.arrow_left,
              size: 10.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: 45,
            height: 30,
            child: ElevatedButton(
              onPressed: widget.inputEventLogic.circleButtonCallback,
              child: const Icon(
                Icons.circle,
                size: 10.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 45,
          height: 30,
          child: ElevatedButton(
            onPressed: widget.inputEventLogic.rightButtonCallback,
            child: const Icon(
              Icons.arrow_right,
              size: 10.0,
            ),
          ),
        ),
      ],
    );
    var bottom = Row(
      children: [
        SizedBox(
          width: 45,
          height: 30,
          child: ElevatedButton(
            onPressed: widget.inputEventLogic.downButtonCallback,
            child: const Icon(
              Icons.arrow_downward,
              size: 10.0,
            ),
          ),
        ),
      ],
    );
    return SizedBox(
      child: Column(children: [top, middle, bottom]),
    );
  }
}
