import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget get center => Center(child: this);

  Widget flex(int f) => Flexible(flex: f, child: this);

  Widget get expand => Expanded(child: this);

  Widget get equalExpand => Expanded(flex: 1, child: this);

  Widget inkwell(GestureTapCallback onTap, {Color? tapColor}) => InkWell(onTap: onTap, highlightColor: tapColor ?? Colors.transparent, splashColor: tapColor ?? Colors.transparent, child: this);

  Widget gesture(GestureTapCallback onTap) => GestureDetector(onTap: onTap, child: this);

  Widget scaleTr(Animation<double> anim) => ScaleTransition(scale: anim, child: this);

  Widget fadeTr(Animation<double> anim) => FadeTransition(opacity: anim, child: this);

  Widget pos({double? t, double? l, double? r, double? b}) => Positioned(top: t, left: l, right: r, bottom: b, child: this);

  Widget get scaleFitBox => FittedBox(fit: BoxFit.scaleDown, child: this);

  Widget symPad({double h = .0, double v = .0}) => Padding(padding: EdgeInsets.symmetric(vertical: v, horizontal: h), child: this);

  Widget aspect(double ratio) => AspectRatio(aspectRatio: ratio, child: this);

  Widget pad(double l, double t, double r, double b) => Padding(padding: EdgeInsets.fromLTRB(l, t, r, b), child: this);

  Widget get posFill => Positioned.fill(child: this);

  Widget get draggable => Draggable(feedback: this, data: this, childWhenDragging: this, child: this);

  Widget wrapperSb({double? width, double? height}) => SizedBox(width: width, height: height, child: this);

  Widget fractionSb({double? hF, double? wF}) => FractionallySizedBox(heightFactor: hF, widthFactor: wF, child: this);

  Widget align({AlignmentGeometry? alignment, double? hF, double? wF}) => Align(alignment: alignment ?? Alignment.center, heightFactor: hF, widthFactor: wF, child: this);
}