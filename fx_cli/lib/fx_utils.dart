import 'dart:io';

import 'package:fx_cli/data/menu.dart';
import 'package:fx_cli/fx_enum.dart';
import 'package:fx_cli/fx_extensions.dart';
import 'package:interact/interact.dart' show Select;

import 'fx_logger.dart';
import 'fx_runners.dart';

Future<void> get menu async {
  final runner = FxRunner();

  while(true) {
    final option = _firstLevelMenu();

    if(option == MenuOption.exit) {
      t('👋 Goodbye!');
      return;
    }

    if(option == MenuOption.basic) {
      final basicCmd = _showBasicMenu(option);
      if(basicCmd == MenuOption.back) {
        continue;
      }

      if(basicCmd == MenuOption.exit) {
        t('👋 Goodbye!');
        break;
      }

      await runner.run([basicCmd.cliTitle]);
      print("\n----------------------------------------\n");
      print("🔄 Returning to menu...\n");
      continue;
    }

    if(option == MenuOption.pub) {

    }
  }
}

MenuOption _firstLevelMenu()  {
  final optionsCli = firstLevelMenu.map((e) => e.option.title).toList();
  final option = Select(
    prompt: 'Choose main command: ',
    options: optionsCli.map((e) => e.firstLetterUppercase).toList(),
  ).interact();

  i('You selected: ${firstLevelMenu[option].option.title}');
  return firstLevelMenu[option].option;
}

MenuOption _showBasicMenu(MenuOption mainOption) {
  final selectedOption = firstLevelMenu.firstWhere((e) => e.option == mainOption);
  final options = selectedOption.items!.map((e) => e.title).toList();
  final option = Select(
    prompt: 'Choose an action:',
    options: options,
  ).interact();

  i('You selected: ${selectedOption.items![option].title}');
  return selectedOption.items![option];
}

// MenuOption _showPubMenu() {
//
// }

Future<void> runCmd(String cmd, List<String> args, {String? spinnerMsg}) async {
  final spinner = (spinnerMsg ?? 'Running executable...').renderSpinner;
  spinner.start();

  try {
    final result = await Process.run(
      cmd,
      args,
      runInShell: true,
    );

    spinner.updateMessage('Done.');
    spinner.stop();

    if(result.stdout != null && result.stdout.toString().isNotEmpty) {
      t(result.stdout);
    }

    if(result.stderr != null && result.stderr.toString().isNotEmpty) {
      e(result.stderr);
    }
  } catch(err) {
    spinner.updateMessage('Error: $err');
    spinner.stop();
    e('Failed to run $cmd: $err');
  }
}


