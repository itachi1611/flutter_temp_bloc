extension StringExt on String? {
  bool get validate => this != null && this!.isNotEmpty;
}