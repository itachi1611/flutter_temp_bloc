import 'package:cli_spinner/cli_spinner.dart' show Spinner;

extension SpinnerBuilder on String? {
  Spinner get renderSpinner => Spinner(this ?? 'Processing...');
}

extension StringExtension on String {
  String get firstLetterUppercase {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}