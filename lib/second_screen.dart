import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Column(
            children: [
              Text("Welcome to my package Second screen"),
              ElevatedButton(onPressed: () {
                Get.back();
              }, child: Text("Back"),),
            ],
          ),
        ) ,
      ),
    );
  }
}