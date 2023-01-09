

part of 'course_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class LoadingCoursesState extends CoursesState {}

class LoadedCoursesState extends CoursesState {
  final List<Course> courses;

  LoadedCoursesState({required this.courses});

  @override
  List<Object> get props => [courses];
}

class ErrorCoursesState extends CoursesState {
  final String message;

  ErrorCoursesState({required this.message});

  @override
  List<Object> get props => [message];
}
