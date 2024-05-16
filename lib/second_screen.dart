import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SecondScreen extends StatefulWidget {
   const SecondScreen({super.key, required this.title});

 final  String title;

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.title),
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
