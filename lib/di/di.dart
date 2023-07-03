import 'package:get_it/get_it.dart';
import 'package:todo/helpers/device_info.dart';

class DepInj {
  DepInj._();

  static Future<void> inject() async {
    final deviceModel = await DeviceInfo.getDeviceModel();
    GetIt.I.registerSingleton(deviceModel, instanceName: 'deviceModel');
  }
}

