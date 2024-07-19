import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_colors.dart';
import '../common_text.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog(
      {super.key,
      required this.imagePath,
      required this.contentOne,
      required this.contentTwo,
      required this.buttonTextOne,
      this.buttonTextTwo,
      required this.onButtonOneTap,
      this.onButtonTwoTap});

  final String imagePath;
  final String contentOne;
  final String contentTwo;
  final String buttonTextOne;
  final String? buttonTextTwo;
  final Function onButtonOneTap;
  final Function? onButtonTwoTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("imagePathBase/$imagePath"),
            SizedBox(height: 20),
            // Add spacing if needed
            Column(
              children: [
                const Text(
                  "Hi Michael,",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  contentOne,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                CommonText(
                  text: contentTwo,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                      onPressed: () {
                        onButtonOneTap;
                      },
                      child: Text(
                        buttonTextOne,
                        style: TextStyle(color: AppColors.white),
                      )),
                ),
                buttonTextTwo != ""
                    ? const SizedBox(
                        height: 10,
                      )
                    : SizedBox.shrink(),
                buttonTextTwo != ""
                    ? TextButton(
                        onPressed: () {
                          onButtonOneTap;
                        },
                        child: Text(buttonTextTwo!))
                    : SizedBox.shrink()
              ],
            ),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
