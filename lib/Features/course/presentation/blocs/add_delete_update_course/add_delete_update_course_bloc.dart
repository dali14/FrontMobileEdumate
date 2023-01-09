

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../Core/error/failures.dart';
import '../../../../../Core/strings/failures.dart';

import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/usecases/add_course.dart';
import '../../../domain/usecases/delete_course.dart';
import '../../../domain/usecases/update_course.dart';

part 'add_delete_update_course_event.dart';
part 'add_delete_update_course_state.dart';





class AddDeleteUpdateCourseBloc
    extends Bloc<AddDeleteUpdateCourseEvent, AddDeleteUpdateCourseState> {
  final AddCourseUsecase addCourse;
  final DeleteCourseUsecase deleteCourse;
  final UpdateCourseUsecase updateCourse;
  AddDeleteUpdateCourseBloc(
      {required this.addCourse,
      required this.deleteCourse,
      required this.updateCourse})
      : super(AddDeleteUpdateCourseInitial()) {
    on<AddDeleteUpdateCourseEvent>((event, emit) async {
      if (event is AddCourseEvent) {
        emit(LoadingAddDeleteUpdateCourseState());

        final failureOrDoneMessage = await addCourse(event.course);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdateCourseEvent) {
        emit(LoadingAddDeleteUpdateCourseState());

        final failureOrDoneMessage = await updateCourse(event.course);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteCourseEvent) {
        emit(LoadingAddDeleteUpdateCourseState());

        final failureOrDoneMessage = await deleteCourse(event.courseId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdateCourseState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateCourseState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateCourseState(message: message),
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
