import 'dart:async';
import 'package:get/get.dart';
import 'package:network_chacker/services/network_service.dart';


class NetworkController extends GetxController {
  final NetworkService _networkService = NetworkService();

  RxBool hasInternet = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _checkConnection(); // initial check
    _networkService.onConnectivityChanged.listen((_) => _checkConnection());
  }

  /// Main logic: update connection state
  Future<void> _checkConnection() async {
    bool isConnected = await _networkService.isConnectedToNetwork();

    if (!isConnected) {
      _updateStatus(false);
      _stopPeriodicCheck();
      return;
    }

    bool hasAccess = await _networkService.hasInternetAccess();
    _updateStatus(hasAccess);

    // If network exists but no internet → start periodic check
    if (!hasAccess) {
      _startPeriodicCheck();
    } else {
      _stopPeriodicCheck();
    }
  }

  /// Start periodic re-check when network exists but no internet
  void _startPeriodicCheck() {
    _stopPeriodicCheck();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      bool hasAccess = await _networkService.hasInternetAccess();
      if (hasAccess) {
        _updateStatus(true);
        _stopPeriodicCheck();
      }
    });
  }

  void _stopPeriodicCheck() {
    _timer?.cancel();
    _timer = null;
  }

  /// Update observable
  void _updateStatus(bool status) {
    if (hasInternet.value != status) {
      hasInternet.value = status;
    }
  }

  @override
  void onClose() {
    _stopPeriodicCheck();
    super.onClose();
  }
}