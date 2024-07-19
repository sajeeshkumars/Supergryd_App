import '../widgets/super_gryd_app.dart';

class ExceptionHandler {
  ExceptionHandler._(); // Private constructor

  static final ExceptionHandler _instance = ExceptionHandler._();

  static ExceptionHandler get instance => _instance;

  throwException(Exception exception, {StackTrace? stack}) {
    SuperGrydApp.instance.errorCallback(exception, stack: stack);
  }
}
