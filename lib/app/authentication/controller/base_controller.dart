import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../app_colors.dart';
import '../../../constants.dart';
import '../../../dependecy.dart';
import '../../../services/exception_handler.dart';
import '../../modules/home/controllers/color_controller.dart';
import '../../modules/home/controllers/font_controller.dart';
import '../authentication_repo.dart';
import '../model/authentication_request_model.dart';

class BaseController extends GetxController {
  RxString _clientId = "".obs;
  RxString _clientSecret = "".obs;
  RxBool isAuthenticated = false.obs;
  RxBool authenticationLoading = false.obs;
  String get clientID => _clientId.value;
  String get clientSecret => _clientSecret.value;
  final AuthRepository authRepository = Get.put(AuthRepository());
  final ColorController colorController = Get.put(ColorController());

  @override
  void onReady() {
    final controller = Get.put(FontController());

    DependencyCreator.init();
    controller.registerFontsFromWeb();
  }

  setInitVariablesAndAuthenticate({
    required String clientId,
    required String clientSecret,
  }) async {
    _clientId(clientId);
    _clientSecret(clientSecret);

    AuthenticationRequestModel requestModel = AuthenticationRequestModel(
        clientId: clientId, clientSecrete: clientSecret);
    authenticationLoading(true);
    var result = await InternetConnectionChecker().hasConnection;
    if (result == true && isAuthenticated.isFalse) {
      log("authenticated called from base_controller");

      await authRepository.authenticate(requestModel.toJson()).then((value) {
        authenticationLoading(false);
        // await authRepository.authenticate().then((value) {
        if (value.status == 200) {
          isAuthenticated(true);
          debugPrint("authenticated");
          debugPrint("${value.message}");
          debugPrint("token${value.data?.refreshToken}");
          Constants.accessToken = value.data?.accessToken ?? "";
          Constants.refreshToken = value.data?.refreshToken ?? "";
          Constants.isAuthenticated = true;
          AppColors.primaryColor =
              fromHex(value.data!.themes!.first.primaryColor.toString());
          AppColors.accentColor =
              fromHex(value.data!.themes!.first.accentColor.toString());
          debugPrint("color ${AppColors.primaryColor}");
          colorController.updateColors(
            value.data!.themes!.first.primaryColor.toString(),
            value.data!.themes!.first.accentColor.toString(),
          );
        } else {
          ExceptionHandler.instance
              .throwException(Exception("Unauthorized please check Your Key"));
        }
      });
    } else {
      authenticationLoading(false);
      ExceptionHandler.instance.throwException(Exception("No Internet"));
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
