import '../fx_enum.dart';

class MenuItem {
  final MenuOption option;

  // Optional
  final List<MenuOption>? items;

  MenuItem({
    required this.option,
    this.items,
  });
}