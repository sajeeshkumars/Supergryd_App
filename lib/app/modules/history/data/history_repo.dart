import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/services/api_service.dart';

import 'history_service.dart';
import 'models/cab_history_response.dart';

class HistoryRepo implements HistoryService {
  ApiService apiService = Get.find();

  Future<CabHistoryResponse> getRideHistory({ String? filter , required String userId,required int page,required int limit }) async {
    CabHistoryResponse cabHistoryResponse;
    Response response = await apiService.reqst(
        url: 'ride-hail/booking-history?filter=$filter&user_id=$userId&page=$page&limit=$limit', method: Method.GET);
    log(response.statusCode.toString());
    try {
      cabHistoryResponse = CabHistoryResponse.fromJson(response.body);
      return cabHistoryResponse;
    } catch (e, s) {
      log(s.toString());
      return CabHistoryResponse(message: "Server Error", status: 401);
    }
  }
}
