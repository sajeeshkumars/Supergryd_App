import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/authentication/controller/base_controller.dart';
import 'package:mynewpackage/model/super_gryd_exception.dart';

import '../app/core/utility.dart';
import '../constants.dart';
import '../services/api_service.dart';
import '../services/api_service_external.dart';
import '../services/config.dart';

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
    Get.lazyPut<ApiService>(() => ApiService(
          baseUrl: (ConfigEnvironments.getEnvironments()['url']).toString(),
        ));
    Get.lazyPut<ApiServiceExternal>(() => ApiServiceExternal(
          baseUrl:
              (ConfigEnvironments.getEnvironments()['externalUrl']).toString(),
        ));

    final controller = Get.put(BaseController());

    controller.setInitVariablesAndAuthenticate(
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }
}
