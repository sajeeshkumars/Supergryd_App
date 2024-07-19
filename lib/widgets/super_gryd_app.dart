import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/authentication/controller/base_controller.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/model/super_gryd_exception.dart';
import 'package:mynewpackage/services/exception_handler.dart';

import '../app/core/utility.dart';
import '../constants.dart';
import '../services/api_service.dart';

class SuperGrydApp {
  SuperGrydApp._(); // Private constructor

  static final SuperGrydApp _instance = SuperGrydApp._();

  static SuperGrydApp get instance => _instance;

  static initialize({
    required String clientId,
    required String clientSecret,
  }) {
    _initializePackage(
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }

  final _errorStreamController = StreamController<SuperGrydException>();

  Stream<SuperGrydException> get onError => _errorStreamController.stream;

  void errorCallback(Exception exception, {StackTrace? stack}) {
    _errorStreamController.sink.add(SuperGrydException(exception, stack));
  }

  static _initializePackage({
    required String clientId,
    required String clientSecret,
  }) {
    var apiKey = clientId;
    var apiSecret = clientSecret;
    log("initial secret $apiSecret", name: "SUPERGRYDAPP");

    (apiKey, apiSecret) = Utility.generateSignature(apiSecret, apiKey);
    Constants.key = apiKey;
    Constants.secrete = apiSecret;
    log("api key ${Constants.key}", name: "SUPERGRYDAPP");
    log("api secret ${Constants.secrete}", name: "SUPERGRYDAPP");
    Get.lazyPut<ApiService>(() => ApiService());
    // Get.lazyPut<ApiServiceExternal>(() => ApiServiceExternal(
    //       baseUrl:
    //           (ConfigEnvironments.getEnvironments()['externalUrl']).toString(),
    //     ));

    final controller = Get.put(BaseController());

    controller.setInitVariablesAndAuthenticate(
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }

  static createUser({required String username, required String mobile}) {
    try {
      if (Get.isRegistered<BaseController>()) {
        final controller = Get.find<BaseController>();
        if (controller.authenticationResponse != null) {
          if (controller.isAuthenticated.isTrue) {
            final homeController = Get.find<HomeController>();
            homeController.createUser(
                mobile: mobile, name: username, context: null);
          } else {
            ExceptionHandler.instance
                .throwException(Exception("Authentication failed"));
          }
        } else {}
      } else {
        ExceptionHandler.instance.throwException(
            Exception("create user called before initializing"));
      }
    } catch (e) {
      ExceptionHandler.instance.throwException(e as Exception);
    }
  }
}
