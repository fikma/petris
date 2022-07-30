import 'package:petris/commands/baseCommand.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/tetrisBlockModel.dart';

class RotateCommand {
  TetrisBlockModel tetrisBlockModel;

  RotateCommand(this.tetrisBlockModel);

  void execute() {
    // TODO: implement execute
    TetrisBlockLogic().rotate(
      tetrisBlockModel: tetrisBlockModel,
      rotationOriginIndex: 1,
      rotateClockwise: true,
    );
  }

  void undo() {
    // TODO: implement undo
    TetrisBlockLogic().rotate(
      tetrisBlockModel: tetrisBlockModel,
      rotationOriginIndex: 1,
      rotateClockwise: false,
    );
  }
}
