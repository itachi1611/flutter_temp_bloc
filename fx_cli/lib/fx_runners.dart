import 'package:args/command_runner.dart';

import 'commands/index.dart';

class FxRunner extends CommandRunner {
  FxRunner()
      : super('fx_cli', 'A custom Flutter development CLI tool.') {
    addCommand(BuildCommand());
    addCommand(GenCommand());
    addCommand(DoctorCommand());
    addCommand(CleanCommand());
    addCommand(DeviceCommand());
    addCommand(EmulatorCommand());
    addCommand(PubCommand());
  }
}
