import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/history/data/history_repo.dart';
import 'package:mynewpackage/constants.dart';

import '../data/models/cab_history_response.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  RxString selectedFilter = 'This Month'.obs;
  RxBool isRideHistoryLoading = false.obs;
  HistoryRepo historyRepo = Get.put(HistoryRepo());
  RxList<RideHistoryList> historyList =  <RideHistoryList>[].obs;

  @override
  void onInit() {
    getRideHistory();
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

  Future<bool> getRideHistory() async {

    isRideHistoryLoading(true);



    await historyRepo.getRideHistory(filter: null, userId: Constants.userId, page: 1, limit: 100).then((value) {
      if ((value.data != null) && (value.status == 200)) {
        historyList.addAll(value.data!);


        isRideHistoryLoading(false);

        return true;
      } else {
        isRideHistoryLoading(false);
        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        //   content: Text(
        //     value.message.toString(),
        //   ),
        //   backgroundColor: Colors.red,
        // ));
        return false;
      }
    });
    return false;
  }

}
