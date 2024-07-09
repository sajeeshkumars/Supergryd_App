import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/trip_rating/data/review_repo.dart';

import '../../../../generated/assets.dart';
import '../../add_cash_to_wallet/views/add_cash_to_wallet_view.dart';
import '../../cab/controllers/cab_map_controller.dart';
import '../../home/controllers/home_controller.dart';

class TripRatingController extends GetxController {
  //TODO: Implement TripRatingController

  ReviewRepo reviewRepo = ReviewRepo();
  RxBool isReviewPosted = false.obs;
  RxDouble givenStar = 0.0.obs;
  TextEditingController feedBack = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> postReview({required BuildContext context,required int requestId}) async {
    isReviewPosted(true);

    await reviewRepo.postReview({
      "request_id": requestId,
      "star": givenStar.value,
      "feed_back": feedBack.text
    }).then((value) {
      if (value.status == 200) {
        isReviewPosted(false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CommonAlertDialog(
                imagePath: Assets.iconsSuccess,
                contentOne:
                    "Your Review Submitted\nSuccessfully",
                contentTwo:
                    'It help to improve our services',
                buttonTextOne: 'Explore Our Services',
                buttonTextTwo: '',
                onButtonOneTap: () {
                  debugPrint("explore button tap");
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  CabMapController cabMapController = Get.find();
                  HomeController homeController = Get.find();

                  cabMapController.resetRide();
                  homeController.clearValues();
                },
              );
            });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(
        //       value.message.toString(),
        //     )));


      } else {
        isReviewPosted(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              value.message.toString(),
            )));
      }
    });
  }
}
