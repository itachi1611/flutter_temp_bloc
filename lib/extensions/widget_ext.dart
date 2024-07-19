import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget paddingAll({required double padding}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingEach({
    double? l,
    double? t,
    double? r,
    double? b,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: l ?? .0,
        top: t ?? .0,
        right: r ?? .0,
        bottom: b ?? .0,
      ),
      child: this,
    );
  }

  Widget get expand => Expanded(child: this);

  Widget get center => Center(child: this);

  Widget inkwell(VoidCallback onTap) => InkWell(onTap: onTap, child: this);

  Widget gesture(VoidCallback onTap) => GestureDetector(onTap: onTap, child: this);
}