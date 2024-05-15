import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mynewpackage/productt_response.dart';
import 'package:mynewpackage/repo.dart';


class ProductController extends GetxController {
  //TODO: Implement IntroController

  RxBool isLoading = false.obs;
  ProductRepo productRepo = ProductRepo();
  ProducttResponse? response;
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

  getProducts() async {
    debugPrint("inside controller");


    isLoading(true);

    response  = await productRepo.getProducts();
    debugPrint("response inside controller $response");

    isLoading(false);
  }


}
