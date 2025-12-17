import 'package:args/command_runner.dart';

import '../fx_logger.dart';

abstract class FxBaseCommand extends Command {
  void ls(String msg) => s(msg);
  void le(String msg) => e(msg);
  void li(String msg) => i(msg);
  void lw(String msg) => w(msg);
  void lt(String msg) => t(msg);
}