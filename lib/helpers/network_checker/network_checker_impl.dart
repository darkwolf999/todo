import 'dart:io';

import 'package:todo/data/api/constants/api_constants.dart';
import 'package:todo/helpers/network_checker/network_checker.dart';
import 'package:todo/my_logger.dart';

class NetworkCheckerImpl implements NetworkChecker {

  @override
  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup(ApiConstants.host);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      MyLogger.warningLog('Internet off');
      return false;
    }
  }

}
