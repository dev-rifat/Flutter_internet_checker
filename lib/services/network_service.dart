import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;


/// Service Layer

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  /// Check if the device is connected to any network (WiFi/Mobile)
  Future<bool> isConnectedToNetwork() async {
    var result = await _connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }

  /// Check if the device has actual internet access
  Future<bool> hasInternetAccess() async {
    try {
      final response = await http
          .get(Uri.parse("https://1.1.1.1/cdn-cgi/trace"))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Stream for listening to connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}

