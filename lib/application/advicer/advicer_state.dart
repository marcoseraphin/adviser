part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerState {}

class AdvicerInitial extends AdvicerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdvicerStateLoading extends AdvicerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdvicerStateLoaded extends AdvicerState with EquatableMixin {
  final String advice;
  AdvicerStateLoaded({required this.advice});
  @override
  List<Object?> get props => [advice];
}

class AdvicerStateError extends AdvicerState with EquatableMixin {
  final String message;
  AdvicerStateError({required this.message});
  @override
  List<Object?> get props => [message];
}
