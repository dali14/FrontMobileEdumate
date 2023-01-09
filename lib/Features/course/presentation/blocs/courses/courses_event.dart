

part of 'course_bloc.dart';



abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetAllCourseEvent extends CourseEvent {}

class RefreshCourseEvent extends CourseEvent {}
