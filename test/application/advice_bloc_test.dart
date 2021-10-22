import 'package:adviser/application/advicer/advicer_bloc.dart';
import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/usescases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main() {
  late AdvicerBloc advicerBloc;
  late MockAdvicerUsecases mockAdvicerUsecases;

  setUp(() {
    mockAdvicerUsecases = MockAdvicerUsecases();
    advicerBloc = AdvicerBloc(usescases: mockAdvicerUsecases);
  });

  test("initState should be AdvicerInitial", () {
    // assert
    expect(advicerBloc.state, equals(AdvicerInitial()));
  });

  group("AdviceRequestedEvent", () {
    final tAdvice = AdviceEntity(advice: "test", id: 1);
    final tAdviceString = "test";

    test("should call use case if event is added", () async {
// arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

// act
      advicerBloc.add(AdviceRequestedEvent());
      await untilCalled(mockAdvicerUsecases.getAdviceUsecase());

// assert
      verify(mockAdvicerUsecases.getAdviceUsecase());
      verifyNoMoreInteractions(mockAdvicerUsecases);
    });

    test("should emit loading then the loaded state after event is added",
        () async {
// arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

// assert later
      final expected = [
        AdvicerStateLoading(),
        AdvicerStateLoaded(advice: tAdviceString)
      ];

      expectLater(advicerBloc.stream, emitsInOrder(expected));

// act
      advicerBloc.add(AdviceRequestedEvent());
    });

    test(
        "should emit loading then the error state after event is added => usecase fails => ServerFailure",
        () async {
// arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(ServerFailure()));

// assert later
      final expected = [
        AdvicerStateLoading(),
        AdvicerStateError(message: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(advicerBloc.stream, emitsInOrder(expected));

// act
      advicerBloc.add(AdviceRequestedEvent());
    });

    test(
        "should emit loading then the error state after event is added => usecase fails => GeneralFailure",
        () async {
// arrange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(GeneralFailure()));

// assert later
      final expected = [
        AdvicerStateLoading(),
        AdvicerStateError(message: GENERAL_FAILURE_MESSAGE)
      ];

      expectLater(advicerBloc.stream, emitsInOrder(expected));

// act
      advicerBloc.add(AdviceRequestedEvent());
    });
  });
}
