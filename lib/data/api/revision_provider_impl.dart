import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/api/revision_provider.dart';
import 'package:todo/constants.dart' as Constants;

class RevisionProviderImpl implements RevisionProvider {
  final SharedPreferences _prefs;

  RevisionProviderImpl({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  int getRevision() {
    return _prefs.getInt('revision') ?? Constants.defaultRevision;
  }

  @override
  Future<void> updateRevision(int revision) async {
    await _prefs.setInt(
      Constants.shPrefsRevisionKey,
      revision,
    );
  }
}
