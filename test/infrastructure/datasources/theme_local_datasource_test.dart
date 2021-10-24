import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ThemeLocalDatasorce themeLocalDatasorce;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeLocalDatasorce =
        ThemeLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getCashedThemeData", () {
    const tThemeData = true;

    test(
        "should return a bool (themeData) if there is one in shared preferences",
        () async {
// arrange

      when(mockSharedPreferences.getBool(any)).thenReturn(tThemeData);

// act
      final result = await themeLocalDatasorce.getCashedThemeData();

// assert
      verify(mockSharedPreferences.getBool(CHACHED_THEME_MODE));

      expect(result, tThemeData);
    });

    test(
        "should return a CachedException if there is NO data in shared preferences",
        () async {
// arrange

      when(mockSharedPreferences.getBool(any)).thenReturn(null);

// act
      final call = themeLocalDatasorce.getCashedThemeData;

// assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("chacheThemeData", () {
    const tThemeData = true;
    test("should call shared preferences to cache them mode", () {
//arrange
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => true);

// act
      themeLocalDatasorce.chacheThemeData(mode: tThemeData);

// assert
      verify(mockSharedPreferences.setBool(CHACHED_THEME_MODE, tThemeData));
    });
  });
}
