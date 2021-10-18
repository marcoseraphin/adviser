part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerEvent {}

/// Event when button is pressed
class AdviceRequestedEvent extends AdvicerEvent {}
