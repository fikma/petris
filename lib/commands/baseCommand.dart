import 'package:petris/components/baseComponent.dart';
import 'package:petris/configs/vector.dart';

abstract class BaseCommand {
  Object? tetrisModel;

  void execute(Vector direction);
  void undo();
}
