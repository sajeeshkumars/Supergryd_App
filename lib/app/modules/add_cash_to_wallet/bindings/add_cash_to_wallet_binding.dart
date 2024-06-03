import 'package:get/get.dart';

import '../controllers/add_cash_to_wallet_controller.dart';

class AddCashToWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCashToWalletController>(
      () => AddCashToWalletController(),
    );
  }
}
