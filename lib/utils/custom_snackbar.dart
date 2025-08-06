import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Colors/color_resources.dart';

void customSnackBar(String titleTxt, String msg, {SnackPosition position = SnackPosition.BOTTOM}) {
  
  if (Get.isRegistered<GetMaterialApp>() || Get.context != null) {
    Get.snackbar(
      '',
      '',
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
      duration: const Duration(seconds: 3),
      backgroundColor: titleTxt == 'Processing'
          ? const Color(0xff030D1F)
          : titleTxt == 'Success'
              ? const Color(0xFF4CAF50) // Standard green
              : titleTxt == 'Error'
                  ? const Color(0xFFF44336) // Standard red
              : titleTxt == 'Out of Stock'
                  ? const Color(0xFFFFCDD2) // Light red
                  : const Color.fromARGB(255, 85, 11, 14),
      colorText: titleTxt == 'Processing' 
          ? const Color.fromARGB(255, 13, 59, 146) 
          : titleTxt == 'Out of Stock'
              ? Colors.black87 // Dark text for light red background
              : Colors.white,
      icon: titleTxt == 'Processing'
          ? const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CupertinoActivityIndicator(
                radius: 12,
                color: Colors.white,
              ),
            )
          : Icon(
              titleTxt == 'Success' ? Icons.check_circle : Icons.error,
              color: titleTxt == 'Out of Stock' ? Colors.black87 : Colors.white,
              size: 28,
            ),
      snackPosition: position, // Use the passed position (TOP or BOTTOM)
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 12,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      shouldIconPulse: titleTxt != 'Processing',
      isDismissible: titleTxt != 'Processing',
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      titleText: Text(
        titleTxt,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: titleTxt == 'Out of Stock' ? Colors.black87 : Colors.white,
        ),
      ),
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (titleTxt == 'Processing') const SizedBox(width: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: titleTxt == 'Out of Stock' ? Colors.black87 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      mainButton: titleTxt == 'Processing'
          ? null
          : TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'DISMISS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
    );
  } else {
    // Fallback: Use ScaffoldMessenger if GetX is not available
    final context = WidgetsBinding.instance.focusManager.primaryFocus?.context;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}