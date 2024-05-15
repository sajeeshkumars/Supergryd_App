library mynewpackage;


import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Obx(
         () {
          return controller.isLoading.value ? const Center(child: CircularProgressIndicator()):
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount:controller.response?.data?.length ,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: InkWell(
                  onTap: (){
                    Get.to(SecondScreen());
                  },
                    child: Text(controller.response!.data?[index].name ?? "")),
              );
            },
          );
        }
      ),
    );


      }

  }

