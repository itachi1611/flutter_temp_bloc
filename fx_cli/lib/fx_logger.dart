import 'package:ansicolor/ansicolor.dart';

final AnsiPen successPen = AnsiPen()..green(bold: true);
final AnsiPen errorPen = AnsiPen()..red(bold: true);
final AnsiPen infoPen = AnsiPen()..blue(bold: true);
final AnsiPen warnPen = AnsiPen()..yellow(bold: true);
final AnsiPen normalPen = AnsiPen()..white(bold: true);

void s(String msg) => print(successPen(msg));
void e(String msg) => print(errorPen(msg));
void i(String msg) => print(infoPen(msg));
void w(String msg) => print(warnPen(msg));
void t(String msg) => print(normalPen(msg));
