import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController getRiveController(Artboard artboard,
      {stateMachineName = "SM_1"}) {
    StateMachineController? controller;
    while (controller == null) {
      controller =
          StateMachineController.fromArtboard(artboard, stateMachineName);
    }
    artboard.addController(controller);
    return controller;
  }
}
