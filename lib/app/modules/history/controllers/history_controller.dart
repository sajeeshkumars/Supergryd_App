import 'package:get/get.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final count = 0.obs;
  RxString selectedFilter = 'This Month'.obs;
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
