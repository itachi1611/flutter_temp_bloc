part of 'splash_cubit.dart';

class SplashState extends Equatable {
  const SplashState({
    this.logoStyle = FlutterLogoStyle.horizontal,
    this.textColor = Colors.red,
  });

  final FlutterLogoStyle logoStyle;

  final Color textColor;

  SplashState copyWith({
    FlutterLogoStyle? logoStyle,
    Color? textColor,
  }) {
    return SplashState(
      logoStyle: logoStyle ?? this.logoStyle,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  List<Object?> get props => [
        logoStyle,
        textColor,
      ];
}
