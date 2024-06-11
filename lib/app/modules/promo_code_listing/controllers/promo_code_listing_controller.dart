import 'package:get/get.dart';

class PromoCodeListingController extends GetxController {
  //TODO: Implement PromoCodeListingController

  List title = ["\$10 discount","15% Cashback Guaranteed","\$10 discount"];



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

  void increment() => count.value++;
}
