class SuperGrydException {
  final Exception? exception;
  final StackTrace? stackTrace;

  SuperGrydException(this.exception, this.stackTrace);
}
