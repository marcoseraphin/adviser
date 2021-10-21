import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/advicer_repository.dart';
import 'package:adviser/domain/usescases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advicer_usecases_test.mocks.dart';

// flutter packages run build_runner build --delete-conflicting-outputs
@GenerateMocks([AdvicerRepository])
void main() {
  late AdvicerUsecases advicerUsecases;
  late MockAdvicerRepository mockAdvicerRepository;

  setUp(() {
    mockAdvicerRepository = MockAdvicerRepository();
    advicerUsecases = AdvicerUsecases(advicerRepository: mockAdvicerRepository);
  });

  group("getAdviceUsescase", () {
    final t_Advice = AdviceEntity(advice: "Test", id: 1);

    test("should return the same advice as repository", () async {
// arrange
      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Right(t_Advice));
// act
      final result = await advicerUsecases.getAdviceUsecase();

// assert
      expect(result, Right(t_Advice));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });

    test("should return the same failure as repository", () async {
// arrange
      when(mockAdvicerRepository.getAdviceFromApi())
          .thenAnswer((_) async => Left(ServerFailure()));
// act
      final result = await advicerUsecases.getAdviceUsecase();

// assert
      expect(result, Left(ServerFailure()));
      verify(mockAdvicerRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRepository);
    });
  });
}
