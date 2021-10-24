import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const CHACHED_THEME_MODE = 'CHACHED_THEME_MODE';

abstract class ThemeLocalDatasorce {
  Future<bool> getCashedThemeData();

  Future<void> chacheThemeData({required bool mode});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasorce {
  final SharedPreferences sharedPreferences;

  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> chacheThemeData({required bool mode}) {
    return sharedPreferences.setBool(CHACHED_THEME_MODE, mode);
  }

  @override
  Future<bool> getCashedThemeData() {
    final modeBool = sharedPreferences.getBool(CHACHED_THEME_MODE);

    if (modeBool != null) {
      return Future.value(modeBool);
    } else {
      throw CacheException();
    }
  }
}
