import 'package:fx_cli/fx_enum.dart';

import '../models/menu_item.dart';

final List<MenuItem> firstLevelMenu = [
  MenuItem(
    option: MenuOption.basic,
    items: [
      MenuOption.build,
      MenuOption.gen,
      MenuOption.doctor,
      MenuOption.clean,
      MenuOption.device,
      MenuOption.emulator,
      MenuOption.back,
      MenuOption.exit,
    ],
  ),
  MenuItem(
    option: MenuOption.pub,
    items: [
      MenuOption.get,
      MenuOption.cacheClean,
      MenuOption.cacheRepair,
      MenuOption.back,
      MenuOption.exit,
    ]),
  MenuItem(option: MenuOption.exit),
];
