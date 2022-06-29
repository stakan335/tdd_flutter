extension IntExt on int {
  static int fromJson(dynamic json) {
    return (json as num).toInt();
  }
}
