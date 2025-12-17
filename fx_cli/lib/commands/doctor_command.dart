import 'package:fx_cli/fx_utils.dart' show runCmd;

import '../base/fx_base_command.dart';
import '../fx_enum.dart' show MenuOption;

class DoctorCommand extends FxBaseCommand {
  @override
  String get name => MenuOption.doctor.cliTitle;

  @override
  String get description => MenuOption.doctor.description;

  @override
  Future<void> run() async {
    li('Running flutter doctor...');
    await runCmd('flutter', ['doctor', '-v'], spinnerMsg: 'Checking Flutter environment.');
    ls('Flutter doctor completed.');
  }
}
