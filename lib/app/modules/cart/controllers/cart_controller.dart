import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/data/cart_repo.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_request.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/cancel_order_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/create_order_request.dart';
import 'package:mynewpackage/app/modules/cart/data/models/create_order_response.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/dish_listing_response.dart';
import 'package:mynewpackage/app/modules/track_order/views/track_order_view.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/widgets/common_text.dart';

import '../../../../widgets/custom_button.dart';
import '../../cab/model/cancel_reasons_response.dart';
import '../../restaurants_details/data/get_restaurant_details_response.dart';
import '../../track_order/data/models/order_track_response.dart';
import '../../track_order/data/order_track_repo.dart';
import '../data/models/view_cart_response.dart';

class CartController extends GetxController {
  // TODO: Implement CartController

  AddToCartResponse? addToCartResponse;
  AddToCartRequest? addToCartRequest = AddToCartRequest();
  CartRepository cartRepository = CartRepository();
  RxBool isAddToCartLoading = false.obs;
  var cartItems = <CartItems>[].obs;
  var finalCartItems = <CartItems>[].obs;
  HomeController homeController = Get.find();
  RxBool isViewCartLoading = false.obs;
  ViewCartResponse? viewCartResponse;
  RxBool isCreateOrderLoading = false.obs;
  RxBool isConfirmOrderLoading = false.obs;
  CreateOrderResponse? createOrderResponse;
  RxMap<int, int> productQuantities = <int, int>{}.obs;
  OrderTrackResponse? orderTrackResponse;
  OrderTrackRepository orderTrackRepository = OrderTrackRepository();
  RxBool isTrackOrderLoading = true.obs;
  RxInt selectedCancelReason = 0.obs;
  List<CancelReasons>? cancelReasons;
  RxInt selectedReasonId = 0.obs;
  RxString selectedCancelReasonText = ''.obs;
  RxBool isOrderCancelLoading = false.obs;
  CancelOrderResponse? cancelOrderResponse;
  RxBool canceled = false.obs;
  String? formattedTotal;
  RxBool isOrderCancelReasonsLoading = false.obs;

  int count = 1;

  @override
  void onInit() {
    orderCancelReasons();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  UserData userData = UserData(
    name: Constants.name,
    contactNumber: 3123424,
  );

  @override
  void onClose() {}

  void addProductToCart(Restaurant dish) {
    final existingItem =
        cartItems.firstWhereOrNull((item) => item.productId == dish.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromDish(dish));
    }
  }

  void addProductToCartFromCart(ViewCartItems dish) {
    final existingItem =
        cartItems.firstWhereOrNull((item) => item.productId == dish.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromCart(dish));
    }
  }

  void addProductToCartFromListing(Dishes dish) {
    final existingItem = cartItems.firstWhereOrNull(
        (item) => item.productId == dish.storeProducts?.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromDishList(dish));
    }
  }

  bool areAllDishesFromSameShop(List<Dishes> dishesList) {
    int firstStoreId = dishesList.first.storeId ?? -1;
    return dishesList.every((dish) => dish.storeId == firstStoreId);
  }

  /// Add/update cart API call
  Future<void> addToCart({BuildContext? context, required int storeId}) async {
    debugPrint("inside addToCart");

    isAddToCartLoading(true);

    AddToCartRequest request = AddToCartRequest(
      storeId: storeId,
      cartItems: cartItems,
      addressId: null,
      providerCode: "BHZ",
      userId: Constants.userId,
      deviceId: addToCartResponse?.data?.deviceId ?? null,
      location: DeliveryLocation(
        lat: homeController.selectedLocationCoordinates['lat'],
        long: homeController.selectedLocationCoordinates['long'],
      ),
    );

    debugPrint("inside addToCart2");
    await cartRepository.addToCart(request.toJson()).then((value) {
      if (value.status == 200) {
        isAddToCartLoading(false);
        addToCartResponse = value;

        /// 1 - Successfully added to cart 3- empty cart

        if (value.data?.statusCode == 1 || value.data?.statusCode == 3) {
          finalCartItems.addAll(cartItems);
          viewCart(context: context!);
        } else {
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(content: Text(value.data!.statusMessage.toString())),
          );
        }
      } else {
        isAddToCartLoading(false);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(content: Text(value.data!.statusMessage.toString())),
        );
      }
    });
  }

  void removeFromCart(CartItems item) {
    if (item.quantity! >= 0) {
      item.decrementQuantity();
    } else {
      cartItems.remove(item);
    }
  }

  Future<void> viewCart({required BuildContext context}) async {
    isViewCartLoading(true);

    await cartRepository.viewCart({
      "device_id": addToCartResponse?.data?.deviceId,
      "store_id": addToCartResponse?.data?.storeId,
    }).then((value) {
      if (value.status == 200) {
        isViewCartLoading(false);
        viewCartResponse = value;
        num cartCGST =
            viewCartResponse?.data?.cartMeta?.gSTDetails?.cartCGST ?? 0;
        num cartSGST =
            viewCartResponse?.data?.cartMeta?.gSTDetails?.cartSGST ?? 0;
        num packingCharge =
            viewCartResponse?.data?.cartMeta?.restaurantPackingCharge ?? 0;

        num total = cartCGST + cartSGST + packingCharge;

        formattedTotal = total.toStringAsFixed(2);
        value.data?.cartItmes?.forEach((item) {
          productQuantities[item.productId!.toInt()] = (item.quantity!.toInt());
        });
        productQuantities.refresh();
        debugPrint("asasasasa ${productQuantities.values}");
        // viewCartResponse?.data?.cartItmes?.firstWhereOrNull((item) => item.productId == dish.id)?.quantity?.toInt();
      } else {
        isViewCartLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value.message.toString())),
        );
      }
      isViewCartLoading(false);

      return null;
    });
  }

  Future<void> createOrder({required BuildContext context}) async {
    isCreateOrderLoading(true);

    CreateOrderRequest request = CreateOrderRequest(
      storeId: viewCartResponse?.data?.storeId,
      cartId: viewCartResponse?.data?.cartMeta?.cartId,
      deviceId: viewCartResponse?.data?.deviceId,
      addressData: [
        AddressData(
          lat: homeController.selectedLocationCoordinates['lat'],
          lng: homeController.selectedLocationCoordinates['long'],
          address: homeController.address.value,
          doorFlatNo: "369/3",
          landmark: "",
        ),
      ],
      userData: [
        UserData(
          name: 'Najib',
          contactNumber: 1234567890,
        ),
      ],
      userId: "66826ba73ff1d692ff0ef51c",
      providerCode: null,
      location: Location(
        lat: homeController.selectedLocationCoordinates['lat'],
        lng: homeController.selectedLocationCoordinates['long'],
      ),
      foodRemark: 'test',
    );

    await cartRepository.createOrder(request.toJson()).then((value) {
      if (value.status == 200) {
        isCreateOrderLoading(false);
        createOrderResponse = value;

        if (value.data?.statusCode == 1) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: CommonText(
                  text:
                      'Confirm Order of ₹ ${viewCartResponse?.data?.cartMeta?.cartTotal}',
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'No',
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Obx(
                          () {
                            return CommonButton(
                              isLoading: isConfirmOrderLoading.value,
                              onPressed: () {
                                confirmOrder(
                                    context: context,
                                    onSuccess: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: CommonText(
                                                text:
                                                    'Order Placed Successfully'),
                                            actions: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: CommonButton(
                                                      onPressed: () {
                                                        debugPrint("clicked");
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TrackOrderView()));
                                                      },
                                                      text: 'Track Order',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    flex: 2,
                                                    child: CommonButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Services',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                              },
                              text: 'Confirm',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    CommonText(text: value.data!.statusMessage.toString())),
          );
          isCreateOrderLoading(false);
        }
      }
    });
  }

  Future<void> confirmOrder(
      {required BuildContext context, required Function onSuccess}) async {
    isConfirmOrderLoading(true);

    await cartRepository.confirmOrder({
      "order_id": createOrderResponse?.data?.orderReferance?.first.orderId,
      "device_id": viewCartResponse?.data?.deviceId,
      "payment_method": "CASH",
    }).then((value) {
      if (value.status == 200) {
        isConfirmOrderLoading(false);
        cartItems.clear();
        finalCartItems.clear();
        productQuantities.clear();
        if (value.data?.statusCode == 1) {
          onSuccess();
          if (orderTrackResponse?.status != 11) {
            Timer.periodic(Duration(seconds: 5), (timer) async {
              await trackOrder(
                  orderId: createOrderResponse!
                      .data!.orderReferance!.first.orderId!
                      .toInt(),
                  deviceId: viewCartResponse!.data!.deviceId.toString());
            });
          } else if (orderTrackResponse?.status == 11) {
            debugPrint("stoping on top");
            orderTrackResponse = null;
            count = 1;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    CommonText(text: value.data!.statusMessage.toString())),
          );
        }
      } else {
        isCreateOrderLoading(false);
      }
    });
  }

  Future trackOrder({required int orderId, required String deviceId}) async {
    isTrackOrderLoading(true);

    /// status 11 is delivered
    if (!canceled.value) {
      if (orderTrackResponse?.status != 11) {
        count++;

        try {
          isTrackOrderLoading(true);
          // if (!isCancelClicked.value) {
          orderTrackResponse = await orderTrackRepository.trackOrder(
              orderId: orderId, deviceId: deviceId);

          if (orderTrackResponse?.orderId != null) {
            isTrackOrderLoading(false);
          } else {
            isTrackOrderLoading(false);

            return null;
          }
          // }
        } catch (e) {
          isTrackOrderLoading(false);

          return null;
        }
      }
    }
    isTrackOrderLoading(false);
  }

  Future<void> orderCancelReasons() async {
    isOrderCancelReasonsLoading(true);
    await cartRepository.orderCancelReasons().then((value) {
      if (value.data != []) {
        isOrderCancelReasonsLoading(false);
        cancelReasons = value.data;
        selectedCancelReasonText.value = cancelReasons?.first.reason ?? "";
        selectedReasonId.value = cancelReasons?.first.reasonId?.toInt() ?? 1;
      } else {
        isOrderCancelReasonsLoading(false);
      }
    });
  }

  Future<void> cancelOrder({
    required BuildContext context,
  }) async {
    isOrderCancelLoading(true);
    await cartRepository.cancelOrder({
      "order_id": createOrderResponse?.data?.orderReferance?.first.orderId,
      "device_id": viewCartResponse?.data?.deviceId,
      "cancel_reason_id": selectedReasonId.value
    }).then((value) {
      if (value.status == 200) {
        cancelOrderResponse = value;

        isOrderCancelLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          value.message.toString(),
        )));
        if (value.data?.statusCode == 1) {
          canceled.value = true;
        }

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        isOrderCancelLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          value.message.toString(),
        )));
      }
    });
  }
}
