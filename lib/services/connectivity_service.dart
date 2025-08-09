import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final RxBool isConnected = true.obs;

  late final StreamSubscription<ConnectivityResult> _subscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _initializeConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_handleResult);
  }

  Future<void> _initializeConnectivity() async {
    try {
      final ConnectivityResult result = await _connectivity.checkConnectivity();
      _handleResult(result);
    } catch (_) {
      // Keep previous state if check fails
    }
  }

  void _handleResult(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}


