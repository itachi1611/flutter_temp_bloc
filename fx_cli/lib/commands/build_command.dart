import 'package:fx_cli/base/fx_base_command.dart';
import 'package:fx_cli/fx_enum.dart' show MenuOption;
import 'package:fx_cli/fx_extensions.dart';

class BuildCommand extends FxBaseCommand {
  @override
  String get description => MenuOption.build.description;

  @override
  String get name => MenuOption.build.cliTitle;

  BuildCommand() {
    argParser.addOption(
      'flavor',
      abbr: 'f',
      allowed: ['dev', 'uat', 'prod'],
      defaultsTo: 'dev',
      help: 'Choose a build flavor or scheme.'
    );
  }

  @override
  void run() async {
    final flavor = argResults!['flavor'];
    if(flavor == null) {
      le('You must select flavor first.');
      return;
    }

    lt('Building project with flavor: $flavor');
    final spinner = 'Building'.renderSpinner;
    spinner.start();
    await Future.delayed(const Duration(seconds: 2));
    spinner.updateMessage('Build Completed!');
    spinner.stop();

    ls('Build completed for $flavor');
  }

}