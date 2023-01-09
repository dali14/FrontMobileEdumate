
import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class UpdateCourseUsecase {
  final CoursesRepository repository;

  UpdateCourseUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Course course) async {
    return await repository.updateCourse(course);
  }
}