import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

class HudWidget extends StatefulWidget {
  final HudWidgetModel hudWidgetModel;
  const HudWidget({required this.hudWidgetModel, Key? key}) : super(key: key);

  @override
  State<HudWidget> createState() => _HudWidgetState();
}

class _HudWidgetState extends State<HudWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: BoardConfig.xSize * 30,
      child: Row(
        children: [
          Text(
            "next",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
