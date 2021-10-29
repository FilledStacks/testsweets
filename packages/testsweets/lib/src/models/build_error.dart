class BuildError extends Error {
  final String message;
  BuildError(this.message);

  operator ==(other) => other is BuildError && other.message == this.message;

  int get hashCode => message.hashCode;

  @override
  String toString() => '$BuildError: $message';
}
