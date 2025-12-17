import '../base/fx_base_command.dart';
import '../fx_enum.dart' show MenuOption;
import '../fx_utils.dart' show runCmd;

class DeviceCommand extends FxBaseCommand {
  @override
  String get name => MenuOption.device.cliTitle;

  @override
  String get description => MenuOption.device.description;

  @override
  Future<void> run() async {
    li('$description...');
    await runCmd('flutter', ['clean'], spinnerMsg: 'Cleaning Flutter build.');
    ls('Flutter clean completed.');
  }
}
