import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/common_text.dart';
import '../../widgets/custom_button.dart';

class Utility{

static countConverter(count) {
  if (count > 999 && count < 99999) {
    return "${(count / 1000).toStringAsFixed(1)} K";
  } else if (count > 99999 && count < 999999) {
    return "${(count / 1000).toStringAsFixed(0)} K";
  } else if (count > 999999 && count < 999999999) {
    return "${(count / 1000000).toStringAsFixed(1)} M";
  } else if (count > 999999999) {
    return "${(count / 1000000000).toStringAsFixed(1)} B";
  } else {
    return count.toString();
  }
}

static Future<void> showAlert(
    {String? title,
      String? content,
      String? cancelText,
      String? confirmText,
      bool? barrierDismissible,
      bool? willPop,
      Decoration? decoration,
      bool hasDecoration = false,
      bool hasCancel = true,
      required RxBool isLoading,
      required Function() onConfirm,
      required Function() onCancel}) async {
  await Get.dialog(
    barrierDismissible: barrierDismissible ?? true,
    Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          return willPop ?? true;
        },
        child: Center(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: decoration,
                  color: hasDecoration ? null : Colors.grey,
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CommonText(
                          textAlign: TextAlign.center,
                          textColor: Colors.black,
                          text: title!,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        CommonText(
                          textAlign: TextAlign.center,
                          textColor: Colors.black,
                          text: content!,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              if (hasCancel)
                                Expanded(
                                    child: CommonButton(
                                      textColor: Colors.white,
                                      onPressed: onCancel,
                                      text: cancelText!,
                                      backgroundColor: Colors.amber,
                                    )),
                              if (hasCancel)
                                SizedBox(
                                  width: 16,
                                ),
                              Obx(() {
                                return Expanded(
                                    child: CommonButton(
                                        isLoading: isLoading.value,
                                        onPressed: onConfirm,
                                        text: confirmText!));
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}