import 'package:fx_cli/base/fx_base_command.dart';

import '../fx_enum.dart' show MenuOption;
import '../fx_utils.dart' show runCmd;

class CleanCommand extends FxBaseCommand {
  @override
  String get name => MenuOption.clean.cliTitle;

  @override
  String get description => MenuOption.clean.description;

  @override
  Future<void> run() async {
    li('Running flutter clean...');
    await runCmd('flutter', ['clean'], spinnerMsg: 'Cleaning Flutter build.');
    ls('Flutter clean completed.');
  }
}
