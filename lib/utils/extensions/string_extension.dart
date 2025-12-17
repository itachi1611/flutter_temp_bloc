extension StringExtension on String? {
  bool get isValidate => this != null && this!.isNotEmpty;

  String? get capitalizeFirst {
    if (!isValidate) {
      return this;
    }
    return this![0].toUpperCase() + this!.substring(1);
  }
}