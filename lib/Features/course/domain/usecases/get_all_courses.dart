import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../entities/course.dart';
import '../repositories/course_repository.dart';

class GetAllCourseUsecase {
  final CoursesRepository repository;

  GetAllCourseUsecase(this.repository);

  Future<Either<Failure, List<Course>>> call() async {
    return await repository.getAllCourses();
  }
}