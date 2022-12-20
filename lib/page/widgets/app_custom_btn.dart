import 'package:flutter/material.dart';

import '../../common/app_enums.dart';

class AppCustomBtn extends StatelessWidget {
  const AppCustomBtn({
    Key? key,
    required this.btnType,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.style,
    this.textStyle,
    this.elevatedStyle,
    this.outlinedStyle,
    this.focusNode,
    this.autofocus,
    required this.widget,
  }) : super(key: key);

  final ButtonType btnType;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ButtonStyle? style;
  final ButtonStyle? textStyle;
  final ButtonStyle? elevatedStyle;
  final ButtonStyle? outlinedStyle;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Widget widget;

  static final btnStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.blue.withOpacity(0.04);
      }

      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        return Colors.blue.withOpacity(0.12);
      }
      return null; // Defer to the widget's default.
    },
    ),
  );

  @override
  Widget build(BuildContext context) {
    switch (btnType) {
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          style: style ?? (textStyle ?? btnStyle),
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          child: widget,
        );
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          style: style ?? (elevatedStyle ?? btnStyle),
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          child: widget,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          style: style ?? (outlinedStyle ?? btnStyle),
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          child: widget,
        );
    }
  }
}