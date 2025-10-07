import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_chacker/controller/network_controller.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController controller = Get.find<NetworkController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Internet Checker"),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.hasInternet.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.wifi, color: Colors.green, size: 80),
                SizedBox(height: 20),
                Text(
                  "Internet Available ✅",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.signal_wifi_off, color: Colors.red, size: 80),
                const SizedBox(height: 20),
                const Text(
                  "No Internet ❌",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.hasInternet.value = false; // force refresh
                    controller.refresh();
                  },
                  child: const Text("Retry"),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
