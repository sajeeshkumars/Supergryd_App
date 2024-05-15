import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/productt_response.dart';

import 'api_service.dart';


class ProductDataSource {
  ApiService apiService = Get.put(ApiService());

  Future<ProducttResponse> getProducts() async {

    try {
      var response = await apiService.get('unknown');
      if (response.statusCode == 200) {
        debugPrint("200 success");
        return ProducttResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e,s) {
      debugPrint("stack $s");
      throw Exception('Failed to perform request: $e');
    }
  }




}

