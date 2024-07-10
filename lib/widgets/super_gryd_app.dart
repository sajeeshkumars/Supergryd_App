import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/dependecy.dart';
import 'package:mynewpackage/model/super_gryd_exception.dart';

import '../app/core/utility.dart';
import '../app/modules/home/controllers/font_controller.dart';
import '../constants.dart';

class SuperGrydApp {
  SuperGrydApp._(); // Private constructor

  static final SuperGrydApp _instance = SuperGrydApp._();

  static SuperGrydApp get instance => _instance;

  static initialize(
      {required String clientId,
      required String clientSecret,
      required String name,
      required String mobile}) {
    DependencyCreator.init();

    final controller = Get.put(FontController());
    controller.registerFontsFromWeb();
    _initializePackage(
        clientId: clientId,
        clientSecret: clientSecret,
        name: name,
        mobile: mobile);
  }

  final _errorStreamController = StreamController<SuperGrydException>();

  Stream<SuperGrydException> get onError => _errorStreamController.stream;

  void errorCallback(Exception exception, {StackTrace? stack}) {
    _errorStreamController.sink.add(SuperGrydException(exception, stack));
  }

  static _initializePackage(
      {required String clientId,
      required String clientSecret,
      required String name,
      required String mobile}) {
    var apiKey = clientId;
    var apiSecret = clientSecret;
    log("initial secret $apiSecret", name: "SUPERGRYDAPP");
    var now = DateTime.now().millisecondsSinceEpoch;
    var utz = (now / 1000 / 300).floor();
    var key = '$utz:$apiSecret';
    var signature = Utility.generateSignature(apiSecret, key);
    Constants.key = apiKey;
    Constants.secrete = signature;
    log("api key ${Constants.key}", name: "SUPERGRYDAPP");
    log("api secret ${Constants.secrete}", name: "SUPERGRYDAPP");
    final controller = Get.put(HomeController());
    controller.setInitVariablesAndAuthenticate(
        clientId: clientId,
        clientSecret: clientSecret,
        name: name,
        mobile: mobile);
  }
}
