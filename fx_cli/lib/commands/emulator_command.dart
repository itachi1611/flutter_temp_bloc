import '../base/fx_base_command.dart';
import '../fx_enum.dart' show MenuOption;

class EmulatorCommand extends FxBaseCommand {
  @override
  String get name => MenuOption.emulator.cliTitle;

  @override
  String get description => MenuOption.emulator.description;

  @override
  void run() {
    print('Emulator command.');
  }
}
