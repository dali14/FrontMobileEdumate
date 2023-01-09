part of 'add_delete_update_event_bloc.dart';

abstract class AddDeleteUpdateEventEvent extends Equatable {
  const AddDeleteUpdateEventEvent();

  @override
  List<Object> get props => [];
}

class AddEventEvent extends AddDeleteUpdateEventEvent {
  final Event event;

  AddEventEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class UpdateEventEvent extends AddDeleteUpdateEventEvent {
  final Event event;

  UpdateEventEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class DeleteEventEvent extends AddDeleteUpdateEventEvent {
  final int eventId;

  DeleteEventEvent({required this.eventId});

  @override
  List<Object> get props => [eventId];
}
