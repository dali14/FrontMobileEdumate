import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class AddCourseUsecase {
  final CoursesRepository repository;

  AddCourseUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Course course) async {
    return await repository.addCourse(course);
  }
}