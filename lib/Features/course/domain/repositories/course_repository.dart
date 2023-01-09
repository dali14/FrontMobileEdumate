import 'package:dartz/dartz.dart';
import '../entities/course.dart';
import '../../../../Core/error/failures.dart';


abstract class CoursesRepository {
  Future<Either<Failure,List<Course>>> getAllCourses();
  Future<Either<Failure, Unit>> deleteCourse(int id);
  Future<Either<Failure, Unit>> updateCourse(Course course);
  Future<Either<Failure, Unit>> addCourse(Course course);
}


