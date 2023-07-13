import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:todo/my_logger.dart';
import 'package:todo/constants.dart' as Constants;

class RemoteConfigRepositoryImpl {
  RemoteConfigRepositoryImpl({
    required FirebaseRemoteConfig remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final FirebaseRemoteConfig _remoteConfig;

  int? get highPriorityColor =>
      int.tryParse(_remoteConfig.getString(_ConfigFields.highPriorityColor));

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );

    await _remoteConfig.setDefaults({
      _ConfigFields.highPriorityColor: Constants.lightColorRed.toString(),
    });

    try{
      await _remoteConfig.fetchAndActivate();
    } catch(e){
      MyLogger.log('cant fetch remote configs from firebase server');
    }

  }
}

abstract class _ConfigFields {
  static const highPriorityColor = 'high_priority_color';
}
