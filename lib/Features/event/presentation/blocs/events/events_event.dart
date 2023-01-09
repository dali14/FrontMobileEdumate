part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetAllEventEvent extends EventEvent {}

class RefreshEventEvent extends EventEvent {}
