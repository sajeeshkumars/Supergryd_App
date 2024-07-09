import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/common_text.dart';
import 'package:mynewpackage/widgets/custom_button.dart';

import '../controllers/trip_rating_controller.dart';

class TripRatingView extends GetView<TripRatingController> {
  const TripRatingView(this.requestId, {super.key});

  final int requestId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Card(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const CommonText(
                            text: "How is your ride?",
                            textColor: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CommonText(
                            text:
                                "Your feedback will help improve\n driving experience",
                            textColor: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RatingBar.builder(
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              controller.givenStar.value = rating;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Container(
                              color: Colors.grey[200],
                              // Background color of the text field
                              child: TextFormField(
                                controller: controller.feedBack,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Additional comments....',
                                  hintStyle:
                                      TextStyle(color: AppColors.borderColor),
                                  filled: true,
                                  fillColor: AppColors.textFieldBackground,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 6.0, top: 8.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Obx(
                              () {
                                return CommonButton(
                                  isLoading: controller.isReviewPosted.value,
                                    onPressed: () {
                                      if(controller.givenStar >= 1){
                                      controller.postReview(
                                          context: context,
                                          requestId: requestId);
                                    }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CommonText(text: 'Minimum one start is required',)));
                                      }
                                  },
                                    text: "Submit Review");
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        height: 120, width: 120, child: CircleAvatar()))
              ],
            ),
          ),
        ));
  }
}
