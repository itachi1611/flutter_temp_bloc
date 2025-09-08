extension NullableStringExt on String? {
  bool get validate => this != null && this!.validate;
}

extension StringExt on String {
  bool get validate => isNotEmpty;
}