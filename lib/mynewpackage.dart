library mynewpackage;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/second_screen.dart';

import 'controller.dart';

class MyPackage extends StatefulWidget {
  const MyPackage({super.key});

  @override
  State<MyPackage> createState() => _MyPackageState();
}

class _MyPackageState extends State<MyPackage> {
  ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    controller.getProducts();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.response?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: InkWell(
                        onTap: () {
                          Get.to(SecondScreen(
                            title: controller.response!.data?[index].name ==
                                    "cerulean"
                                ? "Food"
                                : controller.response!.data?[index].name ==
                                        "fuchsia rose"
                                    ? "Cabs"
                                    : controller.response!.data?[index].name ==
                                            "true red"
                                        ? "Salon Services"
                                        : controller.response!.data?[index]
                                                    .name ==
                                                "aqua sky"
                                            ? "Home Services"
                                            : controller.response!.data?[index]
                                                        .name ==
                                                    "tigerlily"
                                                ? "Furniture"
                                                : controller
                                                            .response!
                                                            .data?[index]
                                                            .name ==
                                                        "blue turquoise"
                                                    ? "Grocery"
                                                    : "",
                          ));
                        },
                        child: Text(controller.response!.data?[index].name ==
                                "cerulean"
                            ? "Food"
                            : controller.response!.data?[index].name ==
                                    "fuchsia rose"
                                ? "Cabs"
                                : controller.response!.data?[index].name ==
                                        "true red"
                                    ? "Salon Services"
                                    : controller.response!.data?[index].name ==
                                            "aqua sky"
                                        ? "Home Services"
                                        : controller.response!.data?[index]
                                                    .name ==
                                                "tigerlily"
                                            ? "Furniture"
                                            : controller.response!.data?[index]
                                                        .name ==
                                                    "blue turquoise"
                                                ? "Grocery"
                                                : "")),
                  );
                },
              );
      }),
    );
  }
}
