import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../repositories/course_repository.dart';

class DeleteCourseUsecase {
  final CoursesRepository repository;

  DeleteCourseUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int courseId) async {
    return await repository.deleteCourse(courseId);
  }
}
