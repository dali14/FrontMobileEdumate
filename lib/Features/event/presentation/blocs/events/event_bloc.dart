
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:integration_project_version2/Features/event/domain/entities/event.dart';
import 'package:integration_project_version2/Features/event/domain/usecases/get_all_events.dart';
import 'package:integration_project_version2/Core/error/failures.dart';
import 'package:integration_project_version2/Core/strings/failures.dart';

part 'events_event.dart';
part 'events_state.dart';


class EventsBloc extends Bloc<EventEvent, EventsState> {
  final  GetAllEventUsecase getAllEvents;
  EventsBloc({
    required this.getAllEvents,
  }) : super(EventsInitial()) {
    on<EventEvent>((event, emit) async {
      if (event is GetAllEventEvent) {
        emit(LoadingEventsState());

        final failureOrEvents = await getAllEvents();
        emit(_mapFailureOrEventsToState(failureOrEvents));
      } else if (event is RefreshEventEvent) {
        emit(LoadingEventsState());

        final failureOrEvents = await getAllEvents();
        emit(_mapFailureOrEventsToState(failureOrEvents));
      }
    });
  }
  EventsState _mapFailureOrEventsToState(Either<Failure, List<Event>> either) {
    return either.fold(
      (failure) => ErrorEventsState(message: _mapFailureToMessage(failure)),
      (events) => LoadedEventsState(
        events: events,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}


