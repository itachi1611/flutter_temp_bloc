import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../models/middle_line.dart';

class Arc extends CustomPainter {
  final Color _color;
  final double _strokeWidth;
  final double _sweepAngle;
  final double _startAngle;

  Arc._(
    this._color,
    this._strokeWidth,
    this._startAngle,
    this._sweepAngle,
  );

  static Widget draw({
    required Color color,
    required double size,
    required double strokeWidth,
    required double startAngle,
    required double endAngle,
  }) =>
      SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: Arc._(
            color,
            strokeWidth,
            startAngle,
            endAngle,
          ),
        ),
      );

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.height / 2,
    );

    const bool useCenter = false;
    final Paint paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _strokeWidth;

    canvas.drawArc(rect, _startAngle, _sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Ring extends CustomPainter {
  final Color _color;
  final double _strokeWidth;

  Ring(
    this._color,
    this._strokeWidth,
  );

  static Widget draw({
    required Color color,
    required double size,
    required double strokeWidth,
  }) =>
      SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: Ring(
            color,
            strokeWidth,
          ),
        ),
      );

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Triangle extends CustomPainter {
  final Color _color;
  final double _strokeWidth;
  final Offset _start;
  final Offset _end;
  final MiddleLine _middleLine;

  Triangle._(
    this._color,
    this._strokeWidth,
    this._start,
    this._end,
    this._middleLine,
  );

  static Widget draw({
    required Color color,
    required double strokeWidth,
    required Offset start,
    required Offset end,
    required MiddleLine middleLine,
  }) =>
      CustomPaint(
        painter: Triangle._(
          color,
          strokeWidth,
          start,
          end,
          middleLine,
        ),
      );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = _color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = _strokeWidth;

    final Path path = Path()
      // ..moveTo(size.width / 2, 0)
      ..moveTo(_start.dx, _start.dy)
      // ..lineTo(size.width, size.height)
      ..lineTo(_middleLine.startPoint.dx, _middleLine.startPoint.dy)
      // ..lineTo(0, size.height)
      ..lineTo(_middleLine.endPoint.dx, _middleLine.endPoint.dy)
      ..lineTo(_end.dx, _end.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Dot extends StatelessWidget {
  final double width;
  final double height;
  final bool circular;
  final Color color;

  const Dot.circular({
    Key? key,
    required double dotSize,
    required this.color,
  })  : width = dotSize,
        height = dotSize,
        circular = true,
        super(key: key);

  const Dot.elliptical({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  })  : circular = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circular
            ? null
            : BorderRadius.all(Radius.elliptical(width, height)),
      ),
    );
  }
}

class RoundedRectangle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final bool vertical;
  const RoundedRectangle.vertical({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  })  : vertical = true,
        super(key: key);

  const RoundedRectangle.horizontal({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  })  : vertical = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          vertical ? width : height,
        ),
      ),
    );
  }
}

class FlickrDot extends StatelessWidget {
  final double size;
  final Color color;
  final Offset initialOffset;
  final Offset finalOffset;
  final Interval interval;
  final bool visibility;
  final AnimationController controller;

  const FlickrDot({
    Key? key,
    required this.size,
    required this.color,
    required this.initialOffset,
    required this.finalOffset,
    required this.interval,
    required this.visibility,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Offset offsetAnimation = Tween<Offset>(
      begin: initialOffset,
      end: finalOffset,
    )
        .animate(
          CurvedAnimation(parent: controller, curve: interval),
        )
        .value;

    return Visibility(
      visible: visibility,
      child: Transform.translate(
        offset: offsetAnimation,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}

class StaggeredDot extends StatelessWidget {
  final Interval offsetInterval;
  final double size;
  final Color color;

  final Interval reverseOffsetInterval;
  final Interval heightInterval;
  final Interval reverseHeightInterval;
  final double maxHeight;
  final AnimationController controller;

  const StaggeredDot({
    Key? key,
    required this.offsetInterval,
    required this.size,
    required this.color,
    required this.reverseOffsetInterval,
    required this.heightInterval,
    required this.reverseHeightInterval,
    required this.maxHeight,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Interval interval = widget.offsetInterval;
    // final Interval reverseInterval = widget.reverseOffsetInterval;
    // final Interval heightInterval = widget.heightInterval;
    // final double size = widget.size;
    // final Interval reverseHeightInterval = widget.reverseHeightInterval;
    // final double maxHeight = widget.maxHeight;
    final double maxDy = -(size * 0.20);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: controller.value <= offsetInterval.end ? 1 : 0,
              // opacity: 1,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0, maxDy),
                )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: offsetInterval,
                      ),
                    )
                    .value,
                child: Container(
                  width: size * 0.13,
                  height: Tween<double>(
                    begin: size * 0.13,
                    end: maxHeight,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: heightInterval,
                        ),
                      )
                      .value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: controller.value >= offsetInterval.end ? 1 : 0,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, maxDy),
                  end: Offset.zero,
                )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: reverseOffsetInterval,
                      ),
                    )
                    .value,
                child: Container(
                  width: size * 0.13,
                  height: Tween<double>(
                    end: size * 0.13,
                    begin: maxHeight,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: reverseHeightInterval,
                        ),
                      )
                      .value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ThreeRotatingDot extends StatelessWidget {
  final AnimationController controller;
  final double beginAngle;
  final double endAngle;
  final Interval interval;
  final double dotOffset;
  final Color color;
  final double size;
  final bool first;

  const ThreeRotatingDot.first({
    Key? key,
    required this.controller,
    required this.beginAngle,
    required this.endAngle,
    required this.interval,
    required this.dotOffset,
    required this.color,
    required this.size,
  })  : first = true,
        super(key: key);

  const ThreeRotatingDot.second({
    Key? key,
    required this.controller,
    required this.beginAngle,
    required this.endAngle,
    required this.interval,
    required this.dotOffset,
    required this.color,
    required this.size,
  })  : first = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: first
          ? controller.value <= interval.end
          : controller.value >= interval.begin,
      child: Transform.rotate(
        angle: Tween<double>(
          begin: beginAngle,
          end: endAngle,
        )
            .animate(
              CurvedAnimation(parent: controller, curve: interval),
            )
            .value,
        child: Transform.translate(
          offset: Tween<Offset>(
            begin: first ? Offset.zero : Offset(0, -dotOffset),
            end: first ? Offset(0, -dotOffset) : Offset.zero,
          )
              .animate(
                CurvedAnimation(
                  parent: controller,
                  curve: interval,
                ),
              )
              .value,
          child: Dot.circular(
            color: color,
            dotSize: size,
          ),
        ),
      ),
    );
  }
}

class NewtonDot extends StatelessWidget {
  final double dotSize;
  final Offset rotationOrigin;
  final Color color;
  final AnimationController controller;
  final bool left;
  final double firstInterval;
  final double secondInterval;
  final double thirdInterval;
  final double fourthInterval;

  const NewtonDot.left({
    Key? key,
    required this.color,
    required this.dotSize,
    required this.rotationOrigin,
    required this.controller,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.fourthInterval,
  })  : left = true,
        super(key: key);

  const NewtonDot.right({
    Key? key,
    required this.color,
    required this.dotSize,
    required this.rotationOrigin,
    required this.controller,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.fourthInterval,
  })  : left = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: controller.value <= thirdInterval,
          child: Transform.rotate(
            origin: rotationOrigin,
            angle: Tween<double>(
              begin: 0.0,
              end: left ? math.pi / 5 : -math.pi / 5,
            )
                .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      firstInterval,
                      secondInterval,
                      // curve: curve,
                    ),
                  ),
                )
                .value,
            child: Dot.circular(
              color: color,
              dotSize: dotSize,
            ),
          ),
        ),
        Visibility(
          visible: controller.value >= thirdInterval,
          child: Transform.rotate(
            origin: rotationOrigin,
            angle: Tween<double>(
              begin: left ? math.pi / 5 : -math.pi / 5,
              end: 0.0,
            )
                .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      thirdInterval,
                      fourthInterval,
                      // curve: curve,
                    ),
                  ),
                )
                .value,
            child: Dot.circular(
              color: color,
              dotSize: dotSize,
            ),
          ),
        ),
      ],
    );
  }
}

class HexagonDot extends StatelessWidget {
  final Color color;
  final double angle;
  final double size;
  final Interval interval;
  final AnimationController controller;
  final bool first;
  const HexagonDot.first({
    Key? key,
    required this.color,
    required this.angle,
    required this.size,
    required this.interval,
    required this.controller,
  })  : first = true,
        super(key: key);

  const HexagonDot.second({
    Key? key,
    required this.color,
    required this.angle,
    required this.size,
    required this.interval,
    required this.controller,
  })  : first = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Transform.translate(
        offset: Offset(0, -size / 2.4),
        child: UnconstrainedBox(
          child: Dot.circular(
            color: color,
            dotSize: first
                ? Tween<double>(
                    begin: 0.0,
                    end: size / 6,
                  )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: interval,
                      ),
                    )
                    .value
                : Tween<double>(
                    begin: size / 6,
                    end: 0.0,
                  )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: interval,
                      ),
                    )
                    .value,
          ),
        ),
      ),
    );
  }
}

class StretchedDot extends StatelessWidget {
  final AnimationController controller;
  final double dotWidth;
  final Color color;
  final double innerHeight;

  final Interval firstInterval;
  final Interval secondInterval;
  final Interval thirdInterval;
  final Interval forthInterval;

  const StretchedDot({
    Key? key,
    required this.controller,
    required this.dotWidth,
    required this.color,
    required this.innerHeight,
    required this.firstInterval,
    required this.secondInterval,
    required this.thirdInterval,
    required this.forthInterval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double offset = innerHeight / 4.85;
    final double height = innerHeight / 1.7;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        controller.value < firstInterval.end
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(0, -offset),
                  )
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: firstInterval,
                        ),
                      )
                      .value,
                  child: RoundedRectangle.vertical(
                    width: dotWidth,
                    // height: height,
                    color: color,
                    height: Tween<double>(begin: dotWidth, end: height)
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: firstInterval,
                          ),
                        )
                        .value,
                  ),
                ),
              )
            : Visibility(
                visible: controller.value <= secondInterval.end,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: Tween<Offset>(
                            begin: Offset(0, offset), end: Offset.zero)
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: secondInterval,
                          ),
                        )
                        .value,
                    child: RoundedRectangle.vertical(
                      width: dotWidth,
                      // height: height,
                      color: color,
                      height: Tween<double>(
                        begin: height,
                        end: dotWidth,
                      )
                          .animate(CurvedAnimation(
                            parent: controller,
                            curve: secondInterval,
                          ))
                          .value,
                    ),
                  ),
                ),
              ),
        controller.value < thirdInterval.end
            ? Visibility(
                visible: controller.value >= secondInterval.end,
                replacement: SizedBox(
                  width: dotWidth,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    // offset: Offset(0, offset),
                    offset: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(0, offset),
                    )
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: thirdInterval,
                          ),
                        )
                        .value,
                    child: RoundedRectangle.vertical(
                      width: dotWidth,
                      // height: height,
                      height: Tween<double>(
                        begin: dotWidth,
                        end: height,
                      )
                          .animate(CurvedAnimation(
                            parent: controller,
                            curve: thirdInterval,
                          ))
                          .value,
                      color: color,
                    ),
                  ),
                ),
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: Tween<Offset>(
                    begin: Offset(0, -offset),
                    end: Offset.zero,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: forthInterval,
                        ),
                      )
                      .value,
                  child: RoundedRectangle.vertical(
                    width: dotWidth,
                    height: Tween<double>(
                      begin: height,
                      end: dotWidth,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: forthInterval,
                          ),
                        )
                        .value,
                    color: color,
                  ),
                ),
              ),
      ],
    );
  }
}

class DotsTriangleSides extends StatelessWidget {
  final double maxLength;
  final double depth;
  final Color color;
  final AnimationController controller;
  final Interval interval;
  final double rotationAngle;
  final Offset rotationOrigin;
  final bool forward;
  const DotsTriangleSides.forward({
    Key? key,
    required this.maxLength,
    required this.depth,
    required this.color,
    required this.controller,
    required this.interval,
    this.rotationAngle = 0,
    this.rotationOrigin = Offset.zero,
  })  : forward = true,
        super(key: key);

  const DotsTriangleSides.reverse({
    Key? key,
    required this.maxLength,
    required this.depth,
    required this.color,
    required this.controller,
    required this.interval,
    this.rotationAngle = 0,
    this.rotationOrigin = Offset.zero,
  })  : forward = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double offset = maxLength / 2;
    final double startInterval = interval.begin;
    final double middleInterval = (interval.begin + interval.end) / 2;

    final double endInterval = interval.end;

    final CurvedAnimation leftCurvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        startInterval,
        middleInterval,
      ),
    );

    final CurvedAnimation rightCurvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        middleInterval,
        endInterval,
      ),
    );

    final Widget firstChild = Visibility(
      visible: forward
          ? controller.value <= middleInterval
          : controller.value >= middleInterval,
      child: Transform.translate(
        offset: Tween<Offset>(
          begin: forward ? Offset.zero : Offset(offset, 0),
          end: forward ? Offset(offset, 0) : Offset.zero,
        )
            .animate(
              forward ? leftCurvedAnimation : rightCurvedAnimation,
            )
            .value,
        child: RoundedRectangle.horizontal(
          width: Tween<double>(
                  begin: forward ? depth : maxLength,
                  end: forward ? maxLength : depth)
              .animate(
                forward ? leftCurvedAnimation : rightCurvedAnimation,
              )
              .value,
          height: depth,
          color: color,
        ),
      ),
    );

    final Widget secondChild = Visibility(
      visible: forward
          ? controller.value >= middleInterval
          : controller.value <= middleInterval,
      child: Transform.translate(
        offset: Tween<Offset>(
          begin: forward ? Offset(-offset, 0) : Offset.zero,
          end: forward ? Offset.zero : Offset(-offset, 0),
        )
            .animate(
              forward ? rightCurvedAnimation : leftCurvedAnimation,
            )
            .value,
        child: RoundedRectangle.horizontal(
          width: Tween<double>(
                  begin: forward ? maxLength : depth,
                  end: forward ? depth : maxLength)
              .animate(
                forward ? rightCurvedAnimation : leftCurvedAnimation,
              )
              .value,
          height: depth,
          color: color,
        ),
      ),
    );

    final List<Widget> children = <Widget>[firstChild, secondChild];

    return Transform.rotate(
      angle: rotationAngle,
      origin: rotationOrigin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
