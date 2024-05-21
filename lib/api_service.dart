
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'dart:developer' as developer;


class ApiService extends GetxService {
  final _baseUrl = "https://reqres.in/api/"; //test

  var xAuthClient = "12345";
  var xAuthToken = '12345';

  String get baseUrl => _baseUrl;
  var auth = '';
  var token = '';

  Map<String, String> getHeaders() {
    return {
      'X-Auth-Client': xAuthClient,
      'X-Auth-Token': xAuthToken,
      'grant_type': 'client_credentials',
      'content-type': 'application/json',
    };
  }


  Future<bool> refreshToken() async {
    return true;
  }

  Future<bool> accessDenied() async {
    return true;
  }








  ///give [path] starting with [/], eg: /test
  Future<http.Response> get(String path) async {
    developer.log("checking connection");

    developer.log('**** get request : $path ****');
    http.Response res;
    // try {
      res = await http.get(Uri.parse(baseUrl + path), headers: getHeaders());
    // } catch (e) {
    //   developer.log("get request timeout : $e");
    //   // timeoutDialog();
    //   return http.Response(
    //     json.encode({
    //       'status': false,
    //       'detail': 'Connection timeout',
    //       "body": {"status": false, "message": 'Connection timeout'}
    //     }),
    //     408,
    //   );
    // }
    developer.log('status code : ${res.statusCode}');
    developer.log('response body : ${res.body}');
    developer.log('**** get request end : $path ****');

    return res;
  }



}





// Future<ProductResponse> fetchProducts() async {
//   final response = await http
//       .get(Uri.parse(
//       "https://fakestoreapi.com/products"));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return ProductResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load products');
//   }
// }