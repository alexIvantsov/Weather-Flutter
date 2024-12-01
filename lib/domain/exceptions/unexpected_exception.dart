class UnexpectedException implements Exception {
  final String message;

  UnexpectedException(this.message);

  factory UnexpectedException.from(Object exception) {
    return UnexpectedException(exception.toString());
  }
}
