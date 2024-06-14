import 'package:flutter/material.dart';

class AlertHelper {
  static Future<void> showAlert({
    required BuildContext context,
    String? title,
    String? content,
    String? cancelText,
    String? confirmText,
    bool? barrierDismissible,
    bool? willPop,
    Decoration? decoration,
    bool hasDecoration = false,
    bool hasCancel = true,
    required ValueNotifier<bool> isLoading,
    required Function() onConfirm,
    required Function() onCancel,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return willPop ?? true;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      decoration: decoration,
                      color: hasDecoration ? null : Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (title != null)
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                            if (title != null) SizedBox(height: 24),
                            if (content != null)
                              Text(
                                content,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            if (content != null) SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  if (hasCancel)
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          onCancel();
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber,
                                        ),
                                        child: Text(
                                          cancelText ?? 'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  if (hasCancel) SizedBox(width: 16),
                                  Expanded(
                                    child: ValueListenableBuilder<bool>(
                                      valueListenable: isLoading,
                                      builder: (context, value, child) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            onConfirm();
                                            Navigator.of(context).pop();
                                          },
                                          child: value
                                              ? CircularProgressIndicator(
                                            valueColor:
                                            AlwaysStoppedAnimation<
                                                Color>(Colors.white),
                                          )
                                              : Text(confirmText ?? 'Confirm'),
                                        );
                                      },
                                    ),
                                  ),
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
        );
      },
    );
  }
}
