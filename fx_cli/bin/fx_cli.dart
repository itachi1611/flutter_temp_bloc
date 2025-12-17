import 'package:args/command_runner.dart' show UsageException;
import 'package:fx_cli/fx_logger.dart';
import 'package:fx_cli/fx_runners.dart';
import 'package:fx_cli/fx_utils.dart';

Future<void> main(List<String> args) async {
  try {
    if(args.isEmpty) {
      await menu;
      return;
    }

    await FxRunner().run(args);
  } on UsageException catch (err1) {
    e(err1.toString());
  } catch (err2) {
    e("❌ Unexpected error: $err2");
  }
}