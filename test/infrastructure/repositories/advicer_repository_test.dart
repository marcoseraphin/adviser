import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/advicer_repository.dart';
import 'package:adviser/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:adviser/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_repository_test.mocks.dart';

@GenerateMocks([AdvicerRemoteDatasource])
void main() {
  late AdvicerRepository advicerRepository;
  late MockAdvicerRemoteDatasource mockAdvicerRemoteDatasource;

  setUp(() {
    mockAdvicerRemoteDatasource = MockAdvicerRemoteDatasource();
    advicerRepository = AdvicerRepositoryImpl(
        advicerRemoteDatasource: mockAdvicerRemoteDatasource);
  });

  group("getAdviceFromAPI", () {
    final tAdviceModel = AdviceModel(advice: "test", id: 1);
    final AdviceEntity tAdvice = tAdviceModel;

    test(
        "should return remote data if the call to remote datasorce is successfull",
        () async {
      // arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi())
          .thenAnswer((_) async => tAdviceModel);

      // act
      final result = await advicerRepository.getAdviceFromApi();

      // assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Right(tAdvice));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });

    test(
        "should return remote server failure if datasource throws server exception",
        () async {
      // arrange
      when(mockAdvicerRemoteDatasource.getRandomAdviceFromApi())
          .thenThrow(ServerException());

      // act
      final result = await advicerRepository.getAdviceFromApi();

      // assert
      verify(mockAdvicerRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockAdvicerRemoteDatasource);
    });
  });
}
