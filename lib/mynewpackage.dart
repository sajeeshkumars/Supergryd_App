library mynewpackage;



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/second_screen.dart';


class MyPackage extends StatefulWidget {
  const MyPackage({super.key});

  @override
  State<MyPackage> createState() => _MyPackageState();
}

class _MyPackageState extends State<MyPackage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to my package"),
            ElevatedButton(onPressed: (){
              Get.to(SecondScreen());
            }, child: Text("Next"))

          ],
        ),
      ),
    );
  }
}
