import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/authentication/model/create_user_response.dart';

import '../../services/api_service.dart';
import 'authentication_service.dart';
import 'model/authentication_response.dart';

class AuthRepository implements AuthService {
  ApiService apiService = Get.find();

  @override
  // Future<AuthenticationResponse> authenticate()
  Future<AuthenticationResponse> authenticate(
      Map<String, dynamic>? params) async {
    AuthenticationResponse authenticationResponse;
    // Response response = await apiService.authenticationReqst(
    //     url: 'auth/auth-verification', params: params);
    Response response2 = await apiService.authenticationReqst(
        url: 'auth/auth-verificationV2', params: params);
    // log("authenticate ${response.statusCode}", name: "AUTHREPOSITORY");
    log("authenticate2 ${response2.statusCode} ${response2.body}",
        name: "AUTHREPOSITORY");
    try {
      authenticationResponse = AuthenticationResponse.fromJson(response2.body);
      log("inside repo ${authenticationResponse.status}",
          name: "AUTHREPOSITORY");

      return authenticationResponse;
    } catch (e, s) {
      log("authenticate Exception:$e,stack:$s", name: "AUTHREPOSITORY");
      return AuthenticationResponse(message: "Server Error", status: 500);
    }
  }

  @override
  Future<CreateUserResponse> createUser(Map<String, dynamic>? params) async {
    CreateUserResponse createUserResponse;
    Response response =
        await apiService.reqst(url: 'sdk/create-users', params: params);
    log("createUser ${response.statusCode}", name: "AUTHREPOSITORY");

    try {
      createUserResponse = CreateUserResponse.fromJson(response.body);
      log("inside repo ${createUserResponse.status}", name: "AUTHREPOSITORY");
      return createUserResponse;
    } catch (e, s) {
      log("createUser Exception:$e,stack:$s", name: "AUTHREPOSITORY");

      return CreateUserResponse(message: "Server Error", status: 401);
    }
  }
}
