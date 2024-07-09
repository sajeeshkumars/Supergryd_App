import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/trip_rating/data/model/review_response.dart';
import 'package:mynewpackage/app/modules/trip_rating/data/review_service.dart';
import 'package:mynewpackage/services/api_service.dart';

class ReviewRepo implements ReviewService {
  ApiService apiService = Get.find();

  @override
  Future<ReviewResponse> postReview(Map<String, dynamic>? params) async {
    ReviewResponse reviewResponse;
    Response response =
        await apiService.reqst(url: 'ride-hail/ride-review', params: params);
    log(response.statusCode.toString());
    log("response ${response.body}");
    try {
      reviewResponse = ReviewResponse.fromJson(response.body);
      return reviewResponse;
    } catch (e, s) {
      log(s.toString());
      log(e.toString());
      return ReviewResponse(message: "Server Error", status: 401);
    }
  }
}
