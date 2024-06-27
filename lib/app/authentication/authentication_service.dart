

import 'package:mynewpackage/app/authentication/model/create_user_response.dart';

import 'model/authentication_response.dart';

abstract class AuthService {
  Future<AuthenticationResponse> authenticate(Map<String, dynamic>? params);
  // Future<AuthenticationResponse> authenticate();
  Future<CreateUserResponse> createUser(Map<String, dynamic>? params);


}
