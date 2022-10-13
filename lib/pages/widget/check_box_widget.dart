import 'package:flutter/material.dart';
import 'package:petris/logics/input_event_logic.dart';

class CheckBoxWidget extends StatefulWidget {
  final InputEventLogic inputEventLogic;

  const CheckBoxWidget({
    super.key,
    required this.inputEventLogic,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      side: const BorderSide(
        color: Colors.white,
        width: 2.0,
      ),
      value: widget.inputEventLogic.getGestureEnableState(),
      onChanged: (_) {
        setState(() {
          widget.inputEventLogic.toggleGestureEnableState(
              widget.inputEventLogic.getGestureEnableState());
        });
      },
    );
  }
}
