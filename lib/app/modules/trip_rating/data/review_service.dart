import 'package:mynewpackage/app/modules/trip_rating/data/model/review_response.dart';

abstract class ReviewService {
  Future<ReviewResponse> postReview(Map<String, dynamic>? params);
}
