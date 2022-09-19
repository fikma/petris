import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/main_menu_models.dart';

class MainMenuLogic {
  final MainMenuModel mainMenuModel;
  final GamePageModel gamePageModel;
  final BoardWidgetModel boardWidgetModel;

  MainMenuLogic({
    required this.mainMenuModel,
    required this.gamePageModel,
    required this.boardWidgetModel,
  });

  void resumeButtonCallback() {
    mainMenuModel.visible = false;
    gamePageModel.gameStatePaused = false;
    BoardWidgetLogic().resetBoard(
      boardList: boardWidgetModel.boardList,
    );
  }
}
