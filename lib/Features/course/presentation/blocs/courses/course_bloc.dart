
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:integration_project_version2/Features/course/domain/entities/course.dart';
import 'package:integration_project_version2/Features/course/domain/usecases/get_all_courses.dart';
import 'package:integration_project_version2/Core/error/failures.dart';
import 'package:integration_project_version2/Core/strings/failures.dart';

part 'courses_event.dart';
part 'courses_state.dart';


class CoursesBloc extends Bloc<CourseEvent, CoursesState> {
  final  GetAllCourseUsecase getAllCourses;
  CoursesBloc({
    required this.getAllCourses,
  }) : super(CoursesInitial()) {
    on<CourseEvent>((event, emit) async {
      if (event is GetAllCourseEvent) {
        emit(LoadingCoursesState());

        final failureOrCourses = await getAllCourses();
        emit(_mapFailureOrCoursesToState(failureOrCourses));
      } else if (event is RefreshCourseEvent) {
        emit(LoadingCoursesState());

        final failureOrCourses = await getAllCourses();
        emit(_mapFailureOrCoursesToState(failureOrCourses));
      }
    });
  }
  CoursesState _mapFailureOrCoursesToState(Either<Failure, List<Course>> either) {
    return either.fold(
          (failure) => ErrorCoursesState(message: _mapFailureToMessage(failure)),
          (courses) => LoadedCoursesState(
        courses: courses,
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


