import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/connectivity_service.dart';
import 'offline_ui_widget.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;
  final bool showOfflineUI;

  const ConnectivityWrapper({
    Key? key,
    required this.child,
    this.showOfflineUI = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Try to find the connectivity service, if not found, assume connected
    ConnectivityService? connectivityService;
    try {
      connectivityService = Get.find<ConnectivityService>();
    } catch (e) {
      // If service is not found, return the child (assume connected)
      return child;
    }
    
    return Obx(() {
      // If connectivity service is not available, assume connected
      if (connectivityService == null) {
        return child;
      }
      
      if (!connectivityService.isConnected.value && showOfflineUI) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: OfflineUIWidget(
            mediaQuery: MediaQuery.of(context),
          ),
        );
      }
      
      return child;
    });
  }
} 