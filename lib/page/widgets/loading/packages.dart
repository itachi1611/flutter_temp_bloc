import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'components.dart';
import '../../../models/middle_line.dart';

class Beat extends StatefulWidget {
  final double size;
  final Color color;

  const Beat({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<Beat> createState() => _BeatState();
}

class _BeatState extends State<Beat> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
              visible: _animationController.value <= 0.7,
              child: Transform.scale(
                scale: Tween<double>(begin: 0.15, end: 1.0)
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.0,
                          0.7,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: Opacity(
                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(0.0, 0.2),
                        ),
                      )
                      .value,
                  child: Ring.draw(
                    color: color,
                    size: size,
                    strokeWidth: Tween<double>(begin: size / 5, end: size / 8)
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.0, 0.7),
                          ),
                        )
                        .value,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value <= 0.7,
              child: Ring.draw(
                color: color,
                size: size,
                strokeWidth: size / 8,
              ),
            ),
            Visibility(
              visible: _animationController.value <= 0.8 &&
                  _animationController.value >= 0.7,
              child: Transform.scale(
                scale: Tween<double>(begin: 1.0, end: 1.15)
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.7,
                          0.8,
                        ),
                      ),
                    )
                    .value,
                child: Ring.draw(
                  color: color,
                  size: size,
                  strokeWidth: size / 8,
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value >= 0.8,
              child: Transform.scale(
                scale: Tween<double>(begin: 1.15, end: 1.0)
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.8,
                          0.9,
                        ),
                      ),
                    )
                    .value,
                child: Ring.draw(
                  color: color,
                  size: size,
                  strokeWidth: size / 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BouncingBall extends StatefulWidget {
  final double size;
  final Color color;

  const BouncingBall({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<BouncingBall> createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    final double ballSize = size / 3;
    final double radiusDisplacement = ballSize * 0.08;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Stack(
            children: <Widget>[
              Visibility(
                visible: _animationController.value <= 0.4,
                child: Transform.translate(
                  offset: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(0, size - ballSize),
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.0,
                            0.4,
                            curve: Curves.easeIn,
                          ),
                        ),
                      )
                      .value,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Dot.circular(
                      color: color,
                      dotSize: ballSize,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _animationController.value >= 0.4 &&
                    _animationController.value <= 0.45,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Dot.elliptical(
                    color: color,
                    width: Tween<double>(
                      begin: ballSize,
                      end: ballSize + radiusDisplacement,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.4,
                              0.45,
                            ),
                          ),
                        )
                        .value,
                    height: Tween<double>(
                      begin: ballSize,
                      end: ballSize - radiusDisplacement,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.4,
                              0.45,
                            ),
                          ),
                        )
                        .value,
                  ),
                ),
              ),
              Visibility(
                visible: _animationController.value >= 0.45 &&
                    _animationController.value <= 0.5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Dot.elliptical(
                    color: color,
                    width: Tween<double>(
                      begin: ballSize + radiusDisplacement,
                      end: ballSize,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.45,
                              0.5,
                            ),
                          ),
                        )
                        .value,
                    height: Tween<double>(
                      begin: ballSize - radiusDisplacement,
                      end: ballSize,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.45,
                              0.5,
                            ),
                          ),
                        )
                        .value,
                  ),
                ),
              ),
              Visibility(
                visible: _animationController.value >= 0.5,
                child: Transform.translate(
                  offset: Tween<Offset>(
                    begin: Offset(0, size - ballSize),
                    end: Offset.zero,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.5,
                            1.0,
                            curve: Curves.easeOutQuad,
                          ),
                        ),
                      )
                      .value,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Dot.circular(
                      color: color,
                      dotSize: ballSize,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class DiscreteCircle extends StatefulWidget {
  final double size;
  final Color color;
  final Color secondCircleColor;
  final Color thirdCircleColor;
  const DiscreteCircle({
    Key? key,
    required this.color,
    required this.size,
    required this.secondCircleColor,
    required this.thirdCircleColor,
  }) : super(key: key);

  @override
  State<DiscreteCircle> createState() => _DiscreteCircleState();
}

class _DiscreteCircleState extends State<DiscreteCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double strokeWidth = size / 8;
    final Color secondRingColor = widget.secondCircleColor;
    final Color thirdRingColor = widget.thirdCircleColor;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        return Stack(
          children: <Widget>[
            Transform.rotate(
              angle: Tween<double>(begin: 0, end: 2 * math.pi)
                  .animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(
                        0.68,
                        0.95,
                        curve: Curves.easeOut,
                      ),
                    ),
                  )
                  .value,
              child: Visibility(
                visible: _animationController.value >= 0.5,
                child: Arc.draw(
                  color: thirdRingColor,
                  size: size,
                  strokeWidth: strokeWidth,
                  startAngle: -math.pi / 2,
                  endAngle: Tween<double>(
                    begin: math.pi / 2,
                    end: math.pi / (size * size),
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.7,
                            0.95,
                            curve: Curves.easeOutSine,
                          ),
                        ),
                      )
                      .value,
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value >= 0.5,
              child: Arc.draw(
                color: secondRingColor,
                size: size,
                strokeWidth: strokeWidth,
                startAngle: -math.pi / 2,
                endAngle: Tween<double>(
                  begin: -2 * math.pi,
                  end: math.pi / (size * size),
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.6,
                          0.95,
                          // curve: Curves.easeIn,
                          curve: Curves.easeOutSine,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
            Visibility(
              visible: _animationController.value <= 0.5,
              // visible: true,
              child: Transform.rotate(
                angle: Tween<double>(begin: 0, end: math.pi * 0.06)
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.48,
                          0.5,
                        ),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  color: color,
                  size: size,
                  strokeWidth: strokeWidth,
                  startAngle: -math.pi / 2,
                  // endAngle: 1.94 * math.pi,
                  endAngle: Tween<double>(
                          begin: math.pi / (size * size), end: 1.94 * math.pi)
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.05,
                            0.48,
                            curve: Curves.easeOutSine,
                          ),
                        ),
                      )
                      .value,
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value >= 0.5,
              child: Arc.draw(
                color: color,
                size: size,
                strokeWidth: strokeWidth,
                startAngle: -math.pi / 2,
                // endAngle: -1.94 * math.pi
                endAngle: Tween<double>(
                  // begin: -2 * math.pi,
                  begin: -1.94 * math.pi,
                  end: math.pi / (size * size),
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.5,
                          0.95,
                          curve: Curves.easeOutSine,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class DotsTriangle extends StatefulWidget {
  final double size;
  final Color color;
  const DotsTriangle({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<DotsTriangle> createState() => _DotsTriangleState();
}

class _DotsTriangleState extends State<DotsTriangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double dotDepth = size / 8;
    final double dotLength = size / 2;

    const Interval interval = Interval(0.0, 0.8);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => SizedBox(
        width: size,
        height: size,
        child: Center(
          child: SizedBox(
            width: size,
            height: 0.884 * size,
            child: Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Transform.translate(
                    offset: Offset((size - dotDepth) / 2, 0),
                    child: DotsTriangleSides.forward(
                      rotationAngle: 2 * math.pi / 3,
                      // rotationAngle: math.pi / 2,
                      rotationOrigin: Offset(-(size - dotDepth) / 2, 0),
                      maxLength: dotLength,
                      depth: dotDepth,
                      color: color,
                      controller: _animationController,
                      interval: interval,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DotsTriangleSides.reverse(
                    rotationAngle: math.pi / 3,
                    // rotationAngle: math.pi / 2,
                    rotationOrigin: Offset((size - dotDepth) / 2, 0),
                    maxLength: dotLength,
                    depth: dotDepth,
                    color: color,
                    controller: _animationController,
                    interval: interval,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DotsTriangleSides.forward(
                    maxLength: dotLength,
                    depth: dotDepth,
                    color: color,
                    controller: _animationController,
                    interval: interval,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class FallingDot extends StatefulWidget {
  final double size;
  final Color color;

  const FallingDot({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<FallingDot> createState() => _FallingDotState();
}

class _FallingDotState extends State<FallingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final double startAngle = -math.pi / 4;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    const Cubic curve = Curves.easeInOutCubic;
    final double strokeWidth = size * 0.08;

    const double endAngle = 3 * math.pi / 2;
    final double innerBoxSize = size * 0.6;
    final double dotFinalSize = size * 0.15;
    // final double innerPadding = size * 0.05;

    // final double dotOffset =
    //     (innerBoxSize - innerBoxSize / 2 - innerPadding / 2);

    Color fallingFromTopDotColor() =>
        ColorTween(begin: color.withOpacity(0.0), end: color)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(
                  0.0,
                  0.2,
                  curve: Curves.easeInOut,
                ),
              ),
            )
            .value!;

    double dotWidth() => Tween<double>(
          begin: size * 0.01,
          end: dotFinalSize,
        )
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(
                  0.15,
                  0.3,
                  curve: Curves.easeInOut,
                ),
              ),
            )
            .value;

    double dotHeight() => Tween<double>(
          begin: size * 0.1,
          end: dotFinalSize,
        )
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(
                  0.15,
                  0.3,
                  curve: Curves.easeInOut,
                ),
              ),
            )
            .value;

    return Container(
      width: size,
      height: size,
      // color: Colors.green,
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return SizedBox(
            height: innerBoxSize,
            width: innerBoxSize,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Visibility(
                  visible: _animationController.value <= 0.5,
                  child: Transform.rotate(
                    angle: Tween<double>(
                      begin: -math.pi,
                      end: 0,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.0,
                              0.3,
                              curve: curve,
                            ),
                          ),
                        )
                        .value,
                    child: Arc.draw(
                      color: color,
                      size: size,
                      strokeWidth: strokeWidth,
                      startAngle: startAngle,
                      endAngle: endAngle,
                    ),
                  ),
                ),
                Visibility(
                  visible: _animationController.value >= 0.5,
                  child: Transform.rotate(
                    angle: Tween<double>(
                      begin: 0,
                      end: math.pi,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.5,
                              0.8,
                              curve: curve,
                            ),
                          ),
                        )
                        .value,
                    child: Arc.draw(
                      color: color,
                      size: size,
                      strokeWidth: strokeWidth,
                      startAngle: startAngle,
                      endAngle: endAngle,
                    ),
                  ),
                ),
                Visibility(
                  visible: _animationController.value <= 0.5,
                  child: Transform.translate(
                    offset: Tween<Offset>(
                      begin: Offset(0, -size / 2),
                      end: Offset.zero,
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.1,
                              0.3,
                              curve: curve,
                            ),
                          ),
                        )
                        .value,
                    child: Dot.elliptical(
                      width: dotWidth(),
                      height: dotHeight(),
                      color: fallingFromTopDotColor(),
                    ),
                  ),
                ),
                Visibility(
                  visible: _animationController.value >= 0.5,
                  child: Transform.translate(
                    // offset: Offset(0, dotFinalSize),
                    offset: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(0, dotFinalSize),
                    )
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(
                              0.5,
                              0.72,
                              curve: Curves.easeInOut,
                            ),
                          ),
                        )
                        .value,
                    child: Dot.circular(
                      // dotSize: dotFinalSize,
                      dotSize: Tween<double>(begin: dotFinalSize, end: 0.0)
                          .animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.5,
                                0.72,
                                curve: Curves.easeInOut,
                              ),
                            ),
                          )
                          .value,
                      color: color,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class Flickr extends StatefulWidget {
  final Color leftDotColor;
  final Color rightDotColor;
  final double size;

  const Flickr({
    Key? key,
    required this.leftDotColor,
    required this.rightDotColor,
    required this.size,
  }) : super(key: key);

  @override
  State<Flickr> createState() => _FlickrState();
}

class _FlickrState extends State<Flickr> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Cubic curves = Curves.ease;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color leftDotColor = widget.leftDotColor;
    final Color rightDotColor = widget.rightDotColor;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: <Widget>[
            FlickrDot(
              size: size / 2,
              color: leftDotColor,
              initialOffset: Offset(-size / 4, 0),
              finalOffset: Offset(size / 4, 0),
              interval: Interval(0.0, 0.5, curve: curves),
              controller: _animationController,
              visibility: _animationController.value <= 0.5,
            ),
            FlickrDot(
              size: size / 2,
              color: rightDotColor,
              initialOffset: Offset(size / 4, 0),
              finalOffset: Offset(-size / 4, 0),
              interval: Interval(0.0, 0.5, curve: curves),
              visibility: _animationController.value <= 0.5,
              controller: _animationController,
            ),
            FlickrDot(
              size: size / 2,
              color: rightDotColor,
              initialOffset: Offset(-size / 4, 0),
              finalOffset: Offset(size / 4, 0),
              controller: _animationController,
              interval: Interval(0.5, 1.0, curve: curves),
              visibility: _animationController.value >= 0.5,
            ),
            FlickrDot(
              size: size / 2,
              color: leftDotColor,
              initialOffset: Offset(size / 4, 0),
              finalOffset: Offset(-size / 4, 0),
              controller: _animationController,
              interval: Interval(0.5, 1.0, curve: curves),
              visibility: _animationController.value >= 0.5,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class FourRotatingDots extends StatefulWidget {
  final double size;
  final Color color;
  const FourRotatingDots({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<FourRotatingDots> createState() => _FourRotatingDotsState();
}

class _FourRotatingDotsState extends State<FourRotatingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2200,
      ),
    )..repeat();
  }

  Widget _rotatingDots({
    required bool visible,
    required Color color,
    required double dotSize,
    required double offset,
    required double initialAngle,
    required double finalAngle,
    required Interval interval,
  }) {
    final double angle = Tween<double>(
      begin: initialAngle,
      end: finalAngle,
    )
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: interval,
          ),
        )
        .value;
    return Visibility(
      visible: visible,
      child: Transform.rotate(
        angle: angle,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(-offset, 0),
              child: Dot.circular(
                dotSize: dotSize,
                color: color,
              ),
            ),
            Transform.translate(
              offset: Offset(offset, 0),
              child: Dot.circular(
                dotSize: dotSize,
                color: color,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -offset),
              child: Dot.circular(
                dotSize: dotSize,
                color: color,
              ),
            ),
            Transform.translate(
              offset: Offset(0, offset),
              child: Dot.circular(
                dotSize: dotSize,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatingDots({
    required bool fixedSize,
    required Color color,
    required double dotInitialSize,
    required double initialOffset,
    required double finalOffset,
    required Interval interval,
    double? dotFinalSize,
    required bool visible,
  }) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: interval,
    );

    final double dotSize = fixedSize
        ? dotInitialSize
        : Tween<double>(begin: dotInitialSize, end: dotFinalSize)
            .animate(
              CurvedAnimation(
                parent: _animationController,
                curve: interval,
              ),
            )
            .value;
    return Visibility(
      visible: visible,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(-initialOffset, 0),
              end: Offset(-finalOffset, 0),
            ).animate(curvedAnimation).value,
            child: Dot.circular(
              dotSize: dotSize,
              color: color,
            ),
          ),
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(initialOffset, 0),
              end: Offset(finalOffset, 0),
            ).animate(curvedAnimation).value,
            child: Dot.circular(
              dotSize: dotSize,
              color: color,
            ),
          ),
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(0, -initialOffset),
              end: Offset(0, -finalOffset),
            ).animate(curvedAnimation).value,
            child: Dot.circular(
              dotSize: dotSize,
              color: color,
            ),
          ),
          Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(0, initialOffset),
              end: Offset(0, finalOffset),
            ).animate(curvedAnimation).value,
            child: Dot.circular(
              dotSize: dotSize,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    final double dotMaxSize = size * 0.30;
    final double dotMinSize = size * 0.14;
    final double maxOffset = size * 0.35;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.rotate(
                angle: Tween<double>(
                  begin: 0.0,
                  end: math.pi / 8,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.0,
                          0.18,
                          // curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: _animatingDots(
                  visible: _animationController.value <= 0.18,
                  fixedSize: true,
                  color: color,
                  dotInitialSize: dotMaxSize,
                  initialOffset: maxOffset,
                  finalOffset: 0,
                  interval: const Interval(
                    0.0,
                    0.18,
                    curve: Curves.easeInQuart,
                  ),
                ),
              ),
              Transform.rotate(
                angle: Tween<double>(
                  begin: math.pi / 8,
                  end: math.pi / 4,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.18,
                          0.36,
                          // curve: Curves.easeOutCubic,
                        ),
                      ),
                    )
                    .value,
                child: _animatingDots(
                  visible: _animationController.value >= 0.18 &&
                      _animationController.value <= 0.36,
                  fixedSize: false,
                  color: color,
                  dotInitialSize: dotMaxSize,
                  dotFinalSize: dotMinSize,
                  initialOffset: 0,
                  finalOffset: maxOffset,
                  interval: const Interval(
                    0.18,
                    0.36,
                    curve: Curves.easeOutQuart,
                  ),
                ),
              ),
              _rotatingDots(
                visible: _animationController.value >= 0.36 &&
                    _animationController.value <= 0.60,
                color: color,
                dotSize: dotMinSize,
                initialAngle: math.pi / 4,
                finalAngle: 7 * math.pi / 4,
                interval: const Interval(
                  0.36,
                  0.60,
                  curve: Curves.easeInOutSine,
                ),
                offset: maxOffset,
              ),
              Transform.rotate(
                angle: Tween<double>(
                  begin: 7 * math.pi / 4,
                  end: 2 * math.pi,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.6,
                          0.78,
                        ),
                      ),
                    )
                    .value,
                child: _animatingDots(
                  visible: _animationController.value >= 0.60 &&
                      _animationController.value <= 0.78,
                  fixedSize: false,
                  color: color,
                  dotInitialSize: dotMinSize,
                  dotFinalSize: dotMaxSize,
                  initialOffset: maxOffset,
                  finalOffset: 0,
                  interval: const Interval(
                    0.60,
                    0.78,
                    curve: Curves.easeInQuart,
                  ),
                ),
              ),
              _animatingDots(
                visible: _animationController.value >= 0.78 &&
                    _animationController.value <= 1.0,
                fixedSize: true,
                color: color,
                dotInitialSize: dotMaxSize,
                initialOffset: 0,
                finalOffset: maxOffset,
                interval: const Interval(
                  0.78,
                  0.96,
                  curve: Curves.easeOutQuart,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class HalfTriangleDot extends StatefulWidget {
  final double size;
  final Color color;
  const HalfTriangleDot({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<HalfTriangleDot> createState() => _HalfTriangleDotState();
}

class _HalfTriangleDotState extends State<HalfTriangleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Cubic curve = Curves.easeOutQuad;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  bool _fistVisibility(AnimationController controller) =>
      controller.value <= 0.33;

  bool _secondVisibility(AnimationController controller) =>
      controller.value >= 0.33 && controller.value <= 0.56;

  bool _thirdVisibility(AnimationController controller) =>
      controller.value >= 0.56;

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    final double innerHeight = 0.74 * size;
    final double innerWidth = 0.87 * size;
    final double strokeWidth = size / 8;
    final CurvedAnimation firstCurvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.23, curve: curve),
    );

    final CurvedAnimation secondCurvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.33, 0.56, curve: curve),
    );

    final CurvedAnimation thirdCurvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.66, 0.89, curve: curve),
    );

    final Offset topLeftDotOffset = Offset(
      innerWidth / 4 - (strokeWidth / 2),
      (innerHeight - strokeWidth) / 2,
    );

    final Offset topRightDotOffset = Offset(
      innerWidth * 0.75 - (strokeWidth / 2),
      (innerHeight - strokeWidth) / 2,
    );

    final Offset bottomMiddleDotOffset = Offset(
      (innerWidth - strokeWidth) / 2,
      innerHeight - (strokeWidth / 2),
    );

    return SizedBox(
      width: size,
      height: size,
      // color: Colors.brown,
      child: Center(
        child: SizedBox(
          height: innerHeight,
          width: innerWidth,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) => Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Visibility(
                  visible: _fistVisibility(_animationController),
                  child: Triangle.draw(
                    color: color,
                    strokeWidth: strokeWidth,
                    start: Tween<Offset>(
                      begin: Offset(innerWidth, innerHeight),
                      end: Offset(innerWidth / 2, 0),
                    ).animate(firstCurvedAnimation).value,
                    middleLine: MiddleLine(
                      Offset(innerWidth, innerHeight),
                      Offset(0, innerHeight),
                    ),
                    end: Tween<Offset>(
                      begin: Offset(innerWidth / 2, 0),
                      end: Offset(0, innerHeight),
                    ).animate(firstCurvedAnimation).value,
                  ),
                ),
                Visibility(
                  visible: _secondVisibility(_animationController),
                  child: Triangle.draw(
                    color: color,
                    strokeWidth: strokeWidth,
                    start: Tween<Offset>(
                      begin: Offset(innerWidth / 2, 0),
                      end: Offset(0, innerHeight),
                    ).animate(secondCurvedAnimation).value,
                    middleLine: MiddleLine(
                      Offset(innerWidth / 2, 0),
                      Offset(innerWidth, innerHeight),
                    ),
                    end: Tween<Offset>(
                      begin: Offset(0, innerHeight),
                      end: Offset(innerWidth, innerHeight),
                    ).animate(secondCurvedAnimation).value,
                  ),
                ),
                Visibility(
                  visible: _thirdVisibility(_animationController),
                  child: Triangle.draw(
                    color: color,
                    strokeWidth: strokeWidth,
                    start: Tween<Offset>(
                      begin: Offset(0, innerHeight),
                      end: Offset(innerWidth, innerHeight),
                    ).animate(thirdCurvedAnimation).value,
                    middleLine: MiddleLine(
                      Offset(0, innerHeight),
                      Offset(innerWidth / 2, 0),
                    ),
                    end: Tween<Offset>(
                      begin: Offset(innerWidth, innerHeight),
                      end: Offset(innerWidth / 2, 0),
                    ).animate(thirdCurvedAnimation).value,
                  ),
                ),
                SizedBox(
                  // color: Colors.green,
                  width: innerWidth,
                  height: innerHeight,
                  child: Stack(
                    children: <Widget>[
                      Visibility(
                        visible: _fistVisibility(_animationController),
                        child: Transform.translate(
                          offset: Tween<Offset>(
                                  begin: topRightDotOffset,
                                  end: topLeftDotOffset)
                              .animate(firstCurvedAnimation)
                              .value,
                          child: Dot.circular(
                            dotSize: strokeWidth,
                            color: color,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _secondVisibility(_animationController),
                        child: Transform.translate(
                          offset: Tween<Offset>(
                                  begin: topLeftDotOffset,
                                  end: bottomMiddleDotOffset)
                              .animate(secondCurvedAnimation)
                              .value,
                          child: Dot.circular(
                            dotSize: strokeWidth,
                            color: color,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _thirdVisibility(_animationController),
                        child: Transform.translate(
                          offset: Tween<Offset>(
                                  begin: bottomMiddleDotOffset,
                                  end: topRightDotOffset)
                              .animate(thirdCurvedAnimation)
                              .value,
                          child: Dot.circular(
                            dotSize: strokeWidth,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class HexagonDots extends StatefulWidget {
  final double size;
  final Color color;

  const HexagonDots({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<HexagonDots> createState() => _BuildSpinnerState();
}

class _BuildSpinnerState extends State<HexagonDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 3 * math.pi / 2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3,
          1.0,
        ),
      ),
    );
  }

  Widget _buildInitialDot(double angle, Interval interval) => HexagonDot.first(
        size: widget.size,
        color: widget.color,
        angle: angle,
        controller: _animationController,
        interval: interval,
      );

  Widget _buildLaterDot(double angle, Interval interval) => HexagonDot.second(
        size: widget.size,
        color: widget.color,
        angle: angle,
        controller: _animationController,
        interval: interval,
      );

  @override
  Widget build(BuildContext context) {
    const double angle30 = math.pi / 6;
    const double angle60 = math.pi / 3;
    const double angle120 = 2 * math.pi / 3;
    const double angle180 = math.pi;
    const double angle240 = 4 * math.pi / 3;
    const double angle300 = 5 * math.pi / 3;

    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => SizedBox(
          width: widget.size,
          height: widget.size,
          child: _animationController.value <= 0.28
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _buildInitialDot(0 + angle30, const Interval(0, 0.08)),
                    _buildInitialDot(
                        angle60 + angle30, const Interval(0.04, 0.12)),
                    _buildInitialDot(
                        angle120 + angle30, const Interval(0.08, 0.16)),
                    _buildInitialDot(
                        angle180 + angle30, const Interval(0.12, 0.20)),
                    _buildInitialDot(
                        angle240 + angle30, const Interval(0.16, 0.24)),
                    _buildInitialDot(
                        angle300 + angle30, const Interval(0.20, 0.28)),
                  ],
                )
              : Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildLaterDot(
                        0 + angle30,
                        const Interval(
                          0.80,
                          0.88,
                        ),
                      ),
                      _buildLaterDot(
                        angle60 + angle30,
                        const Interval(
                          0.76,
                          0.84,
                        ),
                      ),
                      _buildLaterDot(
                        angle120 + angle30,
                        const Interval(
                          0.72,
                          0.80,
                        ),
                      ),
                      _buildLaterDot(
                        angle180 + angle30,
                        const Interval(
                          0.68,
                          0.76,
                        ),
                      ),
                      _buildLaterDot(
                        angle240 + angle30,
                        const Interval(
                          0.64,
                          0.72,
                        ),
                      ),
                      _buildLaterDot(
                        angle300 + angle30,
                        const Interval(
                          0.60,
                          0.68,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class HorizontalRotatingDots extends StatefulWidget {
  final double size;
  final Color color;

  const HorizontalRotatingDots({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<HorizontalRotatingDots> createState() => _HorizontalRotatingDotsState();
}

class _HorizontalRotatingDotsState extends State<HorizontalRotatingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _leftDotTranslate;

  late Animation<double> _middleDotScale;
  late Animation<Offset> _middleDotTranslate;

  late Animation<double> _rightDotScale;
  late Animation<Offset> _rightDotTranslate;

  final Interval _interval = const Interval(
    0.0,
    1.0,
    curve: Curves.easeOutCubic,
  );
  @override
  void initState() {
    super.initState();
    final double size = widget.size;
    final double dotSize = size / 4;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();

    _leftDotTranslate = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(size - dotSize, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _interval,
      ),
    );

    _middleDotScale = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _interval,
      ),
    );

    _middleDotTranslate = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-(size - dotSize) / 2, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _interval,
      ),
    );

    _rightDotScale = Tween<double>(
      begin: 1.0,
      end: 0.6,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _interval,
      ),
    );

    _rightDotTranslate = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-(size - dotSize) / 2, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _interval,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;

    final Color color = widget.color;
    final double dotSize = size / 4;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Transform.translate(
              offset: _leftDotTranslate.value,
              child: Dot.circular(
                dotSize: dotSize,
                color: color,
              ),
            ),
            Transform.scale(
              scale: _middleDotScale.value,
              child: Transform.translate(
                offset: _middleDotTranslate.value,
                child: Dot.circular(
                  dotSize: dotSize,
                  color: color,
                ),
              ),
            ),
            Transform.translate(
              offset: _rightDotTranslate.value,
              child: Transform.scale(
                scale: _rightDotScale.value,
                child: Dot.circular(
                  dotSize: dotSize,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class InkDrop extends StatefulWidget {
  final double size;
  final Color color;
  final Color ringColor;

  const InkDrop({
    Key? key,
    required this.size,
    required this.color,
    this.ringColor = const Color(0x1A000000),
  }) : super(key: key);

  @override
  State<InkDrop> createState() => _InkDropState();
}

class _InkDropState extends State<InkDrop> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    final Color ringColor = widget.ringColor;
    final double strokeWidth = size / 5;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Arc.draw(
              strokeWidth: strokeWidth,
              size: size,
              color: ringColor,
              startAngle: math.pi / 2,
              endAngle: 2 * math.pi,
            ),
            Visibility(
              visible: _animationController.value <= 0.9,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, -size),
                  end: Offset.zero,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.05,
                          0.4,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  strokeWidth: strokeWidth,
                  size: size,
                  color: color,
                  startAngle: -3 * math.pi / 2,
                  // endAngle: math.pi / (size * size),
                  endAngle: Tween<double>(
                    begin: math.pi / (size * size),
                    end: math.pi / 1.13,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.38,
                            0.9,
                          ),
                        ),
                      )
                      .value,
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value <= 0.9,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, -size),
                  end: Offset.zero,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.05,
                          0.4,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  strokeWidth: strokeWidth,
                  size: size,
                  color: color,
                  startAngle: -3 * math.pi / 2,
                  endAngle: Tween<double>(
                    begin: math.pi / (size * size),
                    end: -math.pi / 1.13,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.38,
                            0.9,
                          ),
                        ),
                      )
                      .value,
                ),
              ),
            ),

            /// Right
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -math.pi / 4,
                endAngle: Tween<double>(
                  begin: -math.pi / 7.4,
                  end: -math.pi / 4,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          0.96,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
            // Left
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -3 * math.pi / 4,
                // endAngle: math.pi / 4
                // endAngle: math.pi / 7.4
                endAngle: Tween<double>(
                  begin: math.pi / 7.4,
                  end: math.pi / 4,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          0.96,
                        ),
                      ),
                    )
                    .value,
              ),
            ),

            /// Right
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -math.pi / 3.5,
                // endAngle: math.pi / 28,
                endAngle: Tween<double>(
                  begin: math.pi / 1.273,
                  end: math.pi / 28,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          1.0,
                        ),
                      ),
                    )
                    .value,
              ),
            ),

            /// Left
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: math.pi / 0.778,
                // endAngle: -math.pi / 1.273
                // endAngle: -math.pi / 27

                endAngle: Tween<double>(
                  begin: -math.pi / 1.273,
                  end: -math.pi / 27,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          1.0,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class NewtonCradle extends StatefulWidget {
  final double size;
  final Color color;

  const NewtonCradle({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<NewtonCradle> createState() => _NewtonCradleState();
}

class _NewtonCradleState extends State<NewtonCradle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double dotSize = widget.size / 10;
    final Offset rotationOrigin = Offset(0, -widget.size / 2);
    final Color color = widget.color;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => SizedBox(
        width: widget.size,
        height: widget.size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NewtonDot.left(
              color: color,
              controller: _animationController,
              dotSize: dotSize,
              rotationOrigin: rotationOrigin,
              firstInterval: 0.0,
              secondInterval: 0.20,
              thirdInterval: 0.30,
              fourthInterval: 0.50,
            ),
            Dot.circular(
              dotSize: dotSize,
              color: color,
            ),
            Dot.circular(
              dotSize: dotSize,
              color: color,
            ),
            NewtonDot.right(
              color: color,
              controller: _animationController,
              dotSize: dotSize,
              rotationOrigin: rotationOrigin,
              firstInterval: 0.50,
              secondInterval: 0.70,
              thirdInterval: 0.80,
              fourthInterval: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PrograssiveDots extends StatefulWidget {
  final double size;
  final Color color;

  const PrograssiveDots({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<PrograssiveDots> createState() => _PrograssiveDotsState();
}

class _PrograssiveDotsState extends State<PrograssiveDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double dotSize = size * 0.17;
    final double negativeSpace = size - (4 * dotSize);
    final double gapBetweenDots = negativeSpace / 3;
    final double previousDotPosition = -(gapBetweenDots + dotSize);

    Widget translatingDot() => Transform.translate(
          offset: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(previousDotPosition, 0),
          )
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(
                    0.22,
                    0.82,
                  ),
                ),
              )
              .value,
          child: Dot.circular(
            dotSize: dotSize,
            color: color,
          ),
        );

    Widget scalingDot(bool scaleDown, Interval interval) => Transform.scale(
          scale: Tween<double>(
            begin: scaleDown ? 1.0 : 0.0,
            end: scaleDown ? 0.0 : 1.0,
          )
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: interval,
                ),
              )
              .value,
          child: Dot.circular(
            dotSize: dotSize,
            color: color,
          ),
        );

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              scalingDot(
                true,
                const Interval(
                  0.0,
                  0.4,
                ),
              ),
              translatingDot(),
              translatingDot(),
              Stack(
                children: <Widget>[
                  scalingDot(
                    false,
                    const Interval(
                      0.3,
                      0.7,
                    ),
                  ),
                  translatingDot(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class StaggeredDotsWave extends StatefulWidget {
  final double size;
  final Color color;

  const StaggeredDotsWave({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<StaggeredDotsWave> createState() => _StaggeredDotsWaveState();
}

class _StaggeredDotsWaveState extends State<StaggeredDotsWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _offsetController;

  @override
  void initState() {
    super.initState();

    _offsetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double oddDotHeight = widget.size * 0.4;
    final double evenDotHeight = widget.size * 0.7;

    return Container(
      alignment: Alignment.center,
      // color: Colors.black,
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _offsetController,
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StaggeredDot(
              controller: _offsetController,
              heightInterval: const Interval(0.0, 0.1),
              offsetInterval: const Interval(0.18, 0.28),
              reverseHeightInterval: const Interval(0.28, 0.38),
              reverseOffsetInterval: const Interval(0.47, 0.57),
              color: widget.color,
              size: widget.size,
              maxHeight: oddDotHeight,
            ),
            StaggeredDot(
              controller: _offsetController,
              heightInterval: const Interval(0.09, 0.19),
              offsetInterval: const Interval(0.27, 0.37),
              reverseHeightInterval: const Interval(0.37, 0.47),
              reverseOffsetInterval: const Interval(0.56, 0.66),
              color: widget.color,
              size: widget.size,
              maxHeight: evenDotHeight,
            ),
            StaggeredDot(
              controller: _offsetController,
              heightInterval: const Interval(0.18, 0.28),
              offsetInterval: const Interval(0.36, 0.46),
              reverseHeightInterval: const Interval(0.46, 0.56),
              reverseOffsetInterval: const Interval(0.65, 0.75),
              color: widget.color,
              size: widget.size,
              maxHeight: oddDotHeight,
            ),
            StaggeredDot(
              controller: _offsetController,
              heightInterval: const Interval(0.27, 0.37),
              offsetInterval: const Interval(0.45, 0.55),
              reverseHeightInterval: const Interval(0.55, 0.65),
              reverseOffsetInterval: const Interval(0.74, 0.84),
              color: widget.color,
              size: widget.size,
              maxHeight: evenDotHeight,
            ),
            StaggeredDot(
              controller: _offsetController,
              heightInterval: const Interval(0.36, 0.46),
              offsetInterval: const Interval(0.54, 0.64),
              reverseHeightInterval: const Interval(0.64, 0.74),
              reverseOffsetInterval: const Interval(0.83, 0.93),
              color: widget.color,
              size: widget.size,
              maxHeight: oddDotHeight,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _offsetController.dispose();
    super.dispose();
  }
}

class StretchedDots extends StatefulWidget {
  final double size;
  // final int time;
  final Color color;
  final double innerHeight;
  final double dotWidth;

  const StretchedDots({
    Key? key,
    required this.size,
    required this.color,
    // required this.time,
  })  : innerHeight = size / 1.3,
        dotWidth = size / 8,
        super(key: key);

  @override
  State<StretchedDots> createState() => _StretchedDotsState();
}

class _StretchedDotsState extends State<StretchedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Cubic firstCurve = Curves.easeInCubic;
  final Cubic secondCurve = Curves.easeOutCubic;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double innerHeight = widget.innerHeight;
    final double dotWidth = widget.dotWidth;
    final Color color = widget.color;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: SizedBox(
          height: innerHeight,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  StretchedDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.0,
                      0.15,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.15,
                      0.30,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.5,
                      0.65,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.65,
                      0.80,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  StretchedDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.05,
                      0.20,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.20,
                      0.35,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.55,
                      0.70,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.70,
                      0.85,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  StretchedDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.10,
                      0.25,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.25,
                      0.40,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.60,
                      0.75,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.75,
                      0.90,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                  StretchedDot(
                    controller: _animationController,
                    innerHeight: innerHeight,
                    firstInterval: Interval(
                      0.15,
                      0.30,
                      curve: firstCurve,
                    ),
                    secondInterval: Interval(
                      0.30,
                      0.45,
                      curve: secondCurve,
                    ),
                    thirdInterval: Interval(
                      0.65,
                      0.80,
                      curve: firstCurve,
                    ),
                    forthInterval: Interval(
                      0.80,
                      0.95,
                      curve: secondCurve,
                    ),
                    dotWidth: dotWidth,
                    color: color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

const double _kGapAngle = math.pi / 12;
const double _kMinAngle = math.pi / 36;

class ThreeArchedCircle extends StatefulWidget {
  final double size;
  final Color color;
  const ThreeArchedCircle({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<ThreeArchedCircle> createState() => _ThreeArchedCircleState();
}

class _ThreeArchedCircleState extends State<ThreeArchedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double ringWidth = size * 0.08;

    final CurvedAnimation firstRotationInterval = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.easeInOut,
      ),
    );

    final CurvedAnimation firstArchInterval = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.4,
        curve: Curves.easeInOut,
      ),
    );

    final CurvedAnimation secondRotationInterval = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.easeInOut,
      ),
    );

    final CurvedAnimation secondArchInterval = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        0.9,
        curve: Curves.easeInOut,
      ),
    );

    return Container(
      padding: EdgeInsets.all(size * 0.04),
      // color: Colors.green,
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return _animationController.value <= 0.5
              ? Transform.rotate(
                  angle: Tween<double>(
                    begin: 0,
                    end: 4 * math.pi / 3,
                  ).animate(firstRotationInterval).value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Arc.draw(
                        color: color,
                        size: size,
                        strokeWidth: ringWidth,
                        startAngle: 7 * math.pi / 6,
                        endAngle: Tween<double>(
                          begin: 2 * math.pi / 3 - _kGapAngle,
                          end: _kMinAngle,
                        ).animate(firstArchInterval).value,
                      ),
                      Arc.draw(
                        color: color,
                        size: size,
                        strokeWidth: ringWidth,
                        startAngle: math.pi / 2,
                        endAngle: Tween<double>(
                          begin: 2 * math.pi / 3 - _kGapAngle,
                          end: _kMinAngle,
                        ).animate(firstArchInterval).value,
                      ),
                      Arc.draw(
                        color: color,
                        size: size,
                        strokeWidth: ringWidth,
                        startAngle: -math.pi / 6,
                        endAngle: Tween<double>(
                          begin: 2 * math.pi / 3 - _kGapAngle,
                          end: _kMinAngle,
                        ).animate(firstArchInterval).value,
                      ),
                    ],
                  ),
                )
              : Transform.rotate(
                  angle: Tween<double>(
                    begin: 4 * math.pi / 3,
                    end: (4 * math.pi / 3) + (2 * math.pi / 3),
                  ).animate(secondRotationInterval).value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Arc.draw(
                        color: color,
                        size: size,
                        strokeWidth: ringWidth,
                        startAngle: 7 * math.pi / 6,
                        endAngle: Tween<double>(
                          begin: _kMinAngle,
                          end: 2 * math.pi / 3 - _kGapAngle,
                        ).animate(secondArchInterval).value,
                      ),
                      Arc.draw(
                        color: color,
                        size: size,
                        strokeWidth: ringWidth,
                        startAngle: math.pi / 2,
                        endAngle: Tween<double>(
                          begin: _kMinAngle,
                          end: 2 * math.pi / 3 - _kGapAngle,
                        ).animate(secondArchInterval).value,
                      ),
                      Arc.draw(
                        color: color,
                        size: size,
                        strokeWidth: ringWidth,
                        startAngle: -math.pi / 6,
                        endAngle: Tween<double>(
                          begin: _kMinAngle,
                          end: 2 * math.pi / 3 - _kGapAngle,
                        ).animate(secondArchInterval).value,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ThreeRotatingDots extends StatefulWidget {
  final double size;
  final Color color;

  const ThreeRotatingDots({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<ThreeRotatingDots> createState() => _ThreeRotatingDotsState();
}

class _ThreeRotatingDotsState extends State<ThreeRotatingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double dotSize = size / 3;
    final double edgeOffset = (size - dotSize) / 2;

    const Interval firstDotsInterval = Interval(
      0.0,
      0.50,
      curve: Curves.easeInOutCubic,
    );
    const Interval secondDotsInterval = Interval(
      0.50,
      1.0,
      curve: Curves.easeInOutCubic,
    );

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, size / 12),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ThreeRotatingDot.first(
                color: color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: math.pi,
                endAngle: 0,
                interval: firstDotsInterval,
              ),

              ThreeRotatingDot.first(
                color: color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 5 * math.pi / 3,
                endAngle: 2 * math.pi / 3,
                interval: firstDotsInterval,
              ),

              ThreeRotatingDot.first(
                color: color,
                size: dotSize,
                controller: _animationController,
                dotOffset: edgeOffset,
                beginAngle: 7 * math.pi / 3,
                endAngle: 4 * math.pi / 3,
                interval: firstDotsInterval,
              ),

              /// Next 3 dots

              ThreeRotatingDot.second(
                controller: _animationController,
                beginAngle: 0,
                endAngle: -math.pi,
                interval: secondDotsInterval,
                dotOffset: edgeOffset,
                color: color,
                size: dotSize,
              ),

              ThreeRotatingDot.second(
                controller: _animationController,
                beginAngle: 2 * math.pi / 3,
                endAngle: -math.pi / 3,
                interval: secondDotsInterval,
                dotOffset: edgeOffset,
                color: color,
                size: dotSize,
              ),

              ThreeRotatingDot.second(
                controller: _animationController,
                beginAngle: 4 * math.pi / 3,
                endAngle: math.pi / 3,
                interval: secondDotsInterval,
                dotOffset: edgeOffset,
                color: color,
                size: dotSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class TwistingDots extends StatefulWidget {
  final double size;
  final Color leftDotColor;
  final Color rightDotColor;

  const TwistingDots({
    Key? key,
    required this.size,
    required this.leftDotColor,
    required this.rightDotColor,
  }) : super(key: key);

  @override
  State<TwistingDots> createState() => _TwistingDotsState();
}

class _TwistingDotsState extends State<TwistingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color firstColor = widget.leftDotColor;
    final Color secondColor = widget.rightDotColor;
    final double dotSize = size / 3;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Visibility(
              visible: _animationController.value < 0.5,
              child: Transform.rotate(
                angle: Tween<double>(
                  begin: 0,
                  end: math.pi,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.0,
                          0.5,
                          curve: Curves.elasticOut,
                        ),
                      ),
                    )
                    .value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Dot.circular(
                      dotSize: dotSize,
                      color: firstColor,
                    ),
                    Dot.circular(
                      dotSize: dotSize,
                      color: secondColor,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value > 0.5,
              child: Transform.rotate(
                angle: Tween<double>(
                  begin: -math.pi,
                  end: 0,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.5,
                          1.0,
                          curve: Curves.elasticOut,
                        ),
                      ),
                    )
                    .value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Dot.circular(
                      dotSize: dotSize,
                      color: firstColor,
                    ),
                    Dot.circular(
                      dotSize: dotSize,
                      color: secondColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class TwoRotatingArc extends StatefulWidget {
  final double size;
  final Color color;
  const TwoRotatingArc({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<TwoRotatingArc> createState() => _TwoRotatingArcState();
}

class _TwoRotatingArcState extends State<TwoRotatingArc>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final Cubic firstCurve = Curves.easeInQuart;
  final Cubic secondCurve = Curves.easeOutQuart;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double strokeWidth = size / 10;
    final Color color = widget.color;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Stack(
        children: <Widget>[
          Visibility(
            visible: _animationController.value <= 0.5,
            child: Transform.rotate(
              angle: Tween<double>(
                begin: 0.0,
                end: 3 * math.pi / 4,
              )
                  .animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        0.0,
                        0.5,
                        curve: firstCurve,
                      ),
                    ),
                  )
                  .value,
              child: Arc.draw(
                color: color,
                size: size,
                strokeWidth: strokeWidth,
                startAngle: -math.pi / 2,
                // endAngle: math.pi / (size * size),
                endAngle: Tween<double>(
                  begin: math.pi / (size * size),
                  end: -math.pi / 2,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          0.0,
                          0.5,
                          curve: firstCurve,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ),
          Visibility(
            visible: _animationController.value >= 0.5,
            child: Transform.rotate(
              angle: Tween<double>(
                begin: math.pi / 4,
                end: math.pi,
              )
                  .animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        0.5,
                        1.0,
                        curve: secondCurve,
                      ),
                    ),
                  )
                  .value,
              child: Arc.draw(
                color: color,
                size: size,
                strokeWidth: strokeWidth,
                startAngle: -math.pi / 2,
                // endAngle: math.pi / (size * size),
                endAngle: Tween<double>(
                  begin: math.pi / 2,
                  end: math.pi / (size * size),
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          0.5,
                          1.0,
                          curve: secondCurve,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ),

          ///
          ///second one
          ///
          ///
          Visibility(
            visible: _animationController.value <= 0.5,
            child: Transform.rotate(
              angle: Tween<double>(begin: -math.pi, end: -math.pi / 4)
                  .animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.0, 0.5, curve: firstCurve),
                    ),
                  )
                  .value,
              child: Arc.draw(
                color: color,
                size: size,
                strokeWidth: strokeWidth,
                startAngle: -math.pi / 2,
                // endAngle: math.pi / (size * size),
                endAngle: Tween<double>(
                  begin: math.pi / (size * size),
                  end: -math.pi / 2,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          0.0,
                          0.5,
                          curve: firstCurve,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ),
          Visibility(
            visible: _animationController.value >= 0.5,
            child: Transform.rotate(
              angle: Tween<double>(
                begin: -3 * math.pi / 4,
                end: 0.0,
              )
                  .animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        0.5,
                        1.0,
                        curve: secondCurve,
                      ),
                    ),
                  )
                  .value,
              child: Arc.draw(
                color: color,
                size: size,
                strokeWidth: strokeWidth,
                startAngle: -math.pi / 2,
                // endAngle: math.pi / (size * size),
                endAngle: Tween<double>(
                  begin: math.pi / 2,
                  end: math.pi / (size * size),
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          0.5,
                          1.0,
                          curve: secondCurve,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class WaveDots extends StatefulWidget {
  final double size;
  final Color color;

  const WaveDots({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<WaveDots> createState() => _WaveDotsState();
}

class _WaveDotsState extends State<WaveDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  Widget _buildDot(
          {required Offset begin,
          required Offset end,
          required Interval interval}) =>
      Transform.translate(
        offset: Tween<Offset>(begin: begin, end: end)
            .animate(
              CurvedAnimation(
                parent: _controller,
                curve: interval,
              ),
            )
            .value,
        child: Container(
          width: widget.size / 5,
          height: widget.size / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      );

  Widget _buildBottomDot({required double begin, required double end}) {
    final double offset = -widget.size / 8;
    return _buildDot(
      begin: Offset.zero,
      end: Offset(0.0, offset),
      interval: Interval(begin, end),
    );
  }

  Widget _buildTopDot({required double begin, required double end}) {
    final double offset = -widget.size / 8;
    return _buildDot(
      begin: Offset(0.0, offset),
      end: Offset.zero,
      interval: Interval(begin, end),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _controller.value <= 0.50
                    ? _buildBottomDot(begin: 0.12, end: 0.50)
                    : _buildTopDot(begin: 0.62, end: 1.0),
                _controller.value <= 0.44
                    ? _buildBottomDot(begin: 0.06, end: 0.44)
                    : _buildTopDot(begin: 0.56, end: 0.94),
                _controller.value <= 0.38
                    ? _buildBottomDot(begin: 0.0, end: 0.38)
                    : _buildTopDot(begin: 0.50, end: 0.88),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
