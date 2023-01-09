part of 'add_delete_update_course_bloc.dart';

abstract class AddDeleteUpdateCourseEvent extends Equatable {
  const AddDeleteUpdateCourseEvent();

  @override
  List<Object> get props => [];
}

class AddCourseEvent extends AddDeleteUpdateCourseEvent {
  final Course course;

  AddCourseEvent({required this.course});

  @override
  List<Object> get props => [course];
}

class UpdateCourseEvent extends AddDeleteUpdateCourseEvent {
  final Course course;

  UpdateCourseEvent({required this.course});

  @override
  List<Object> get props => [course];
}

class DeleteCourseEvent extends AddDeleteUpdateCourseEvent {
  final int courseId;

  DeleteCourseEvent({required this.courseId});

  @override
  List<Object> get props => [courseId];
}
