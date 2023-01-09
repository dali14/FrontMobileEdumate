part of 'add_delete_update_course_bloc.dart';

abstract class AddDeleteUpdateCourseState extends Equatable {
  const AddDeleteUpdateCourseState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateCourseInitial extends AddDeleteUpdateCourseState {}

class LoadingAddDeleteUpdateCourseState extends AddDeleteUpdateCourseState {}

class ErrorAddDeleteUpdateCourseState extends AddDeleteUpdateCourseState {
  final String message;

  ErrorAddDeleteUpdateCourseState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateCourseState extends AddDeleteUpdateCourseState {
  final String message;

  MessageAddDeleteUpdateCourseState({required this.message});

  @override
  List<Object> get props => [message];
}
