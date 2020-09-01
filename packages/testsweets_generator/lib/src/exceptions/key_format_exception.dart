class KeyFormatException implements Exception {
  final String message;

  KeyFormatException(this.message);

  @override
  String toString() => message;
}
