import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_base/base/app.dart';

class DeviceInfoService {
  late AndroidDeviceInfo androidInfo;
  late IosDeviceInfo iOSDeviceInfo;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> init() async {
    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfoPlugin.androidInfo;
        isEmulator = !androidInfo.isPhysicalDevice!;
        sharedPref.setString(Keys.deviceType, "android");
        sharedPref.setString(Keys.deviceOS, (androidInfo.version.baseOS)!);
        return;
      }

      if (Platform.isIOS) {
        iOSDeviceInfo = await deviceInfoPlugin.iosInfo;
        isEmulator = !iOSDeviceInfo.isPhysicalDevice;
        sharedPref.setString(Keys.deviceType, "apple");
        sharedPref.setString(Keys.deviceOS, (iOSDeviceInfo.systemVersion)!);
        return;
      }
    } catch (e, stackTrace) {
      showLog("deviceInfoInit exception =====>>> $e");
      showLog("deviceInfoInit exception stackTrace =====>>> $stackTrace");
    }
  }
}
