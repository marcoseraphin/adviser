import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/usescases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

// ignore: constant_identifier_names
const GENERAL_FAILURE_MESSAGE = "Ups, something gone wrong. Please try again!";
// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = "Ups API Error, please try again";

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases usescases;

  AdvicerBloc({required this.usescases}) : super(AdvicerInitial()) {
    // ignore: void_checks
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());

      // use usecase getAdviceUsescase
      Either<Failure, AdviceEntity> adviceOrFailure =
          await usescases.getAdviceUsecase();

      adviceOrFailure.fold(
          (failure) =>
              emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
          (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
    });
  }

  // ignore: non_constant_identifier_names
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;

      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}
