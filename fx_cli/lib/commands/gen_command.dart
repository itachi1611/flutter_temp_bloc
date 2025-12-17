import '../base/fx_base_command.dart';
import '../fx_enum.dart' show MenuOption;
import '../fx_logger.dart' show t;

class GenCommand extends FxBaseCommand {
  @override
  String get description => MenuOption.gen.description;

  @override
  String get name => MenuOption.gen.cliTitle;

  @override
  run() {
    t("Gen command");
  }
}