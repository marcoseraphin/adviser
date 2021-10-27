import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:adviser/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasorce])
void main() {
  late MockThemeLocalDatasorce mockThemeLocalDatasorce;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDatasorce = MockThemeLocalDatasorce();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDatasource: mockThemeLocalDatasorce);
  });

  group("getThemeMode", () {
    const tThemeMode = true;

    test("should return theme mode if cached data is present", () async {
      // arrange
      when(mockThemeLocalDatasorce.getCashedThemeData())
          .thenAnswer((_) async => tThemeMode);

      // act
      final result = await themeRepository.getThemeMode();

      // assert
      expect(result, const Right(tThemeMode));
      verify(mockThemeLocalDatasorce.getCashedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasorce);
    });

    test(
        "should return CacheFailure if local datasource throws a cache exception",
        () async {
      // arrange
      when(mockThemeLocalDatasorce.getCashedThemeData())
          .thenThrow(CacheException());

      // act
      final result = await themeRepository.getThemeMode();

      // assert
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDatasorce.getCashedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasorce);
    });
  });

  group("setThemeMode", () {
    const tThemeMode = true;

    test("should call function to cache theme mode in local datatsource", () {
//arrage
      when(mockThemeLocalDatasorce.chacheThemeData(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

// act
      themeRepository.setThemeMode(mode: tThemeMode);

// assert
      verify(mockThemeLocalDatasorce.chacheThemeData(mode: tThemeMode));
    });
  });
}
