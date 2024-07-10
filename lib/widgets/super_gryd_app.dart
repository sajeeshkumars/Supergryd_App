import 'dart:async';

import 'package:get/get.dart';
import 'package:mynewpackage/model/super_gryd_exception.dart';

import '../app/modules/home/controllers/font_controller.dart';

class SuperGrydApp {
  SuperGrydApp._(); // Private constructor

  static final SuperGrydApp _instance = SuperGrydApp._();

  static SuperGrydApp get instance => _instance;

  static initialize({String? clientId, String? clientSecret}) {
    final controller = Get.put(FontController());
    controller.registerFontsFromWeb();
  }

  final _errorStreamController = StreamController<SuperGrydException>();

  Stream<SuperGrydException> get onError => _errorStreamController.stream;

  void errorCallback(Exception exception, {StackTrace? stack}) {
    _errorStreamController.sink.add(SuperGrydException(exception, stack));
  }
}

class ExceptionHandler {
  ExceptionHandler._(); // Private constructor

  static final ExceptionHandler _instance = ExceptionHandler._();

  static ExceptionHandler get instance => _instance;

  throwException(Exception exception, {StackTrace? stack}) {
    SuperGrydApp.instance.errorCallback(exception, stack: stack);
  }
}
