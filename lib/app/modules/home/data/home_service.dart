

import 'package:mynewpackage/app/authentication/model/create_user_response.dart';
import 'package:mynewpackage/app/modules/home/data/models/ride_estimation_response.dart';

import 'models/request_ride_response.dart';
import 'models/service_category_response.dart';


abstract class HomeService {
  Future<ServiceCategoryResponse> getServiceList();
  Future<RideEstimationResponse> getRideEstimation(Map<String, dynamic>? params);
  Future<RequestRideResponse> requestRide(Map<String, dynamic>? params);



}
