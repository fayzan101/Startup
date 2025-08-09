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
    
    ConnectivityService? connectivityService;
    try {
      connectivityService = Get.find<ConnectivityService>();
    } catch (e) {
      
      return child;
    }
    
    return Obx(() {
      
      if (connectivityService == null) {
        return child;
      }
      
      if (!connectivityService.isConnected.value && showOfflineUI) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: OfflineUIWidget(
            mediaQuery: MediaQuery.of(context),
          ),
        );
      }
      
      return child;
    });
  }
} 