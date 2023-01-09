

import 'package:integration_project_version2/Core/error/failures.dart';
import 'package:integration_project_version2/Core/strings/failures.dart';
import '../../../../../Core/strings/messages.dart';
import '../../../domain/usecases/add_event.dart';
import '../../../domain/usecases/delete_event.dart';

import '../../../domain/usecases/update_event.dart';
import '../../../domain/entities/event.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_event_event.dart';
part 'add_delete_update_event_state.dart';



class AddDeleteUpdateEventBloc
    extends Bloc<AddDeleteUpdateEventEvent, AddDeleteUpdateEventState> {
  final AddEventUsecase addEvent;
  final DeleteEventUsecase deleteEvent;
  final UpdateEventUsecase updateEvent;
  AddDeleteUpdateEventBloc(
      {required this.addEvent,
      required this.deleteEvent,
      required this.updateEvent})
      : super(AddDeleteUpdateEventInitial()) {
    on<AddDeleteUpdateEventEvent>((event, emit) async {
      if (event is AddEventEvent) {
        emit(LoadingAddDeleteUpdateEventState());

        final failureOrDoneMessage = await addEvent(event.event);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdateEventEvent) {
        emit(LoadingAddDeleteUpdateEventState());

        final failureOrDoneMessage = await updateEvent(event.event);

        emit(
        _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteEventEvent) {
        emit(LoadingAddDeleteUpdateEventState());

        final failureOrDoneMessage = await deleteEvent(event.eventId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdateEventState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateEventState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateEventState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
