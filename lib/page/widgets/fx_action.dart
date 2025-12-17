import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/utils/extensions/string_extension.dart';

enum FxActionStyle { material, cupertino }

enum FxActionMaterialType { elevation, text, outline, icon }

enum FxActionCupertinoType { standard, fill }

class FxAction extends StatelessWidget {
  // Commons
  final FxActionStyle style;
  final FxActionMaterialType materialType;
  final FxActionCupertinoType iosType;
  final String label;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  // Actions
  final VoidCallback? onAction;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;

  // Icon Configs
  final bool hasIcon;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final IconAlignment iconAlignment;

  // Styles
  final ButtonStyle? btnStyle;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? elevation;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final String? tooltip;
  final String? semanticsLabel;
  final VisualDensity? visualDensity;
  final BorderRadius? radius;
  final BorderSide? side;

  // Icon button only
  final Widget? selectedIcon;
  final bool isSelected;

  // Cupertino button filled only
  final Color? cupertinoFillColor;

  const FxAction({
    super.key,
    // Commons
    this.style = FxActionStyle.material,
    this.materialType = FxActionMaterialType.elevation,
    this.iosType = FxActionCupertinoType.standard,
    required this.label,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    // Actions
    this.onAction,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    // Icon configs
    this.hasIcon = false,
    this.icon = Icons.add,
    this.iconSize, // Default icon size from IconThemeData.size is 24.0
    this.iconColor,
    this.iconAlignment = IconAlignment.start,
    // Styles
    this.btnStyle,
    this.foregroundColor,
    this.backgroundColor,
    this.elevation,
    this.textStyle,
    this.padding,
    this.alignment,
    this.tooltip,
    this.semanticsLabel,
    this.visualDensity,
    this.radius,
    this.side,
    // Icon button only
    this.selectedIcon,
    this.isSelected = false,
    // Cupertino button filled only
    this.cupertinoFillColor,
  })  :
  // Accept cupertino style
        assert(
        style == FxActionStyle.cupertino || style == FxActionStyle.material,
        'RlAction: unsupported style. Only cupertino or material are allowed.',
        ),
        assert(
        style != FxActionStyle.material || materialType != FxActionMaterialType.icon || hasIcon == false,
        'RlAction(material + icon): hasIcon must be false.',
        );

  @override
  Widget build(BuildContext context) {
    return _Wrap(
      semanticsLabel: semanticsLabel,
      tooltip: tooltip,
      child: style == FxActionStyle.material ? _buildMaterialAction : _buildCupertinoAction,
    );
  }

  /// Widget components
  Widget get _buildMaterialAction {
    final style = btnStyle ?? _styleFromType;

    switch (materialType) {
      case FxActionMaterialType.elevation:
        return hasIcon
            ? ElevatedButton.icon(
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onPressed: onAction,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          icon: Icon(icon, size: iconSize, color: iconColor),
          label: Text(label),
          iconAlignment: iconAlignment,
        )
            : ElevatedButton(
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onPressed: onAction,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          child: Text(label),
        );
      case FxActionMaterialType.text:
        return hasIcon
            ? TextButton.icon(
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onPressed: onAction,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          icon: Icon(icon, size: iconSize, color: iconColor),
          label: Text(label),
          iconAlignment: iconAlignment,
        )
            : TextButton(
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onPressed: onAction,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          child: Text(label),
        );
      case FxActionMaterialType.outline:
        return hasIcon
            ? OutlinedButton.icon(
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onPressed: onAction,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          icon: Icon(icon, size: iconSize, color: iconColor),
          label: Text(label),
          iconAlignment: iconAlignment,
        )
            : OutlinedButton(
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          onPressed: onAction,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          child: Text(label),
        );
      case FxActionMaterialType.icon:
        return IconButton(
          focusNode: focusNode,
          autofocus: autofocus,
          onPressed: onAction,
          style: style,
          icon: Icon(icon),
          iconSize: iconSize,
          color: iconColor,
          selectedIcon: selectedIcon,
          isSelected: isSelected,
        );
    }
  }

  Widget get _buildCupertinoAction => iosType == FxActionCupertinoType.standard
      ? CupertinoButton(
    onPressed: onAction,
    padding: padding,
    borderRadius: radius,
    child: Text(label),
  )
      : cupertinoFillColor != null
      ? CupertinoButton(
    onPressed: onAction,
    padding: padding,
    borderRadius: radius,
    color: cupertinoFillColor,
    child: Text(label),
  )
      : CupertinoButton.filled(
    onPressed: onAction,
    padding: padding,
    borderRadius: radius,
    child: Text(label),
  );

  ButtonStyle get _styleFromType => switch (materialType) {
    FxActionMaterialType.elevation => ElevatedButton.styleFrom(
      alignment: alignment,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      visualDensity: visualDensity,
      shape: radius != null
          ? RoundedRectangleBorder(
        borderRadius: radius!,
      )
          : null,
      side: side,
    ),
    FxActionMaterialType.text => TextButton.styleFrom(
      alignment: alignment,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      // elevation: elevation,  // A text button is a label child displayed on a (zero elevation) Material widget.
      textStyle: textStyle,
      padding: padding,
      visualDensity: visualDensity,
      shape: radius != null
          ? RoundedRectangleBorder(
        borderRadius: radius!,
      )
          : null,
      side: side,
    ),
    FxActionMaterialType.outline => OutlinedButton.styleFrom(
      alignment: alignment,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      // elevation: elevation, // An outlined button is a label child displayed on a (zero elevation) Material widget.
      textStyle: textStyle,
      padding: padding,
      visualDensity: visualDensity,
      shape: radius != null
          ? RoundedRectangleBorder(
        borderRadius: radius!,
      )
          : null,
      side: side,
    ),
    FxActionMaterialType.icon => IconButton.styleFrom(
      alignment: alignment,
      // foregroundColor: foregroundColor, // Do not set foregroundColor if iconColor is set already via style and vice versa
      backgroundColor: backgroundColor,
      elevation: elevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: radius != null ? RoundedRectangleBorder(borderRadius: radius!) : null,
      side: side,
    ),
  };
}

class _Wrap extends StatelessWidget {
  final Widget child;
  final String? semanticsLabel;
  final String? tooltip;

  const _Wrap({
    required this.child,
    this.semanticsLabel,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasSemantics = semanticsLabel.isValidate;
    final bool hasTooltip = tooltip.isValidate;

    // No wrap
    if (!hasSemantics && !hasTooltip) return child;
    Widget wrapped = child;
    if (hasSemantics) {
      wrapped = Semantics(
        label: semanticsLabel,
        hint: hasTooltip ? tooltip : null,
        button: true,
        child: wrapped,
      );
    }

    if (hasTooltip) {
      wrapped = Tooltip(
        message: tooltip,
        child: wrapped,
      );
    }

    return wrapped;
  }
}