import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List gridItemsName = ["Food","Cabs","Salon Services","Home Services","Gifts","Furniture","Courier","Grocery","Others"];
  List imagesItem = [Assets.iconsFood,Assets.iconsCab,Assets.iconsSalonService,Assets.iconsHomeService,Assets.iconsGifts,Assets.iconsFurniture,
  Assets.iconsCourier,Assets.iconsGrocery,Assets.iconsOthers];
  List addressTypeImage = [Assets.iconsHomeIcon,Assets.iconsOffice];
  List addressHeading = ["Home","Office"];
  List addressDescription = ["67/8, 4th cross Road, Lavella Road,  Bengaluru,Karnataka 560001, India","No. 63, 1st Floor, 14th Cross, 9th Main Road,Indiranagar, Bengaluru, Karnataka 560038, India"];
  RxString address = ''.obs;

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

}
