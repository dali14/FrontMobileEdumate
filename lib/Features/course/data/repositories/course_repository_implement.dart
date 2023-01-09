

import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../../../../Core/network/network_info.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_local_data_source.dart';
import '../datasources/course_remote_data_source.dart';
import '../models/Course_model.dart';
import '../../../../core/error/exeptions.dart';

typedef Future<Unit> DeleteOrUpdateOrAddCourse();

class CoursesRepositoryImpl implements CoursesRepository {
  final CourseRemoteDataSource remoteDataSource;
  final CourseLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CoursesRepositoryImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.networkInfo});

  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCourses = await remoteDataSource.getAllCourses();

        localDataSource.cacheCourses(remoteCourses);
        return Right(remoteCourses);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCourses = await localDataSource.getCachedCourses();
        return Right(localCourses);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addCourse(Course course) async {
    final CourseModel courseModel = CourseModel(name: course.name,    niveau : course.niveau, section : course.section , uploadFile: course.uploadFile, image : course.image, id: null);

    return await _getMessage(() {
      return remoteDataSource.addCourse(courseModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(int courseId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteCourse(courseId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateCourse(Course course) async {
    final CourseModel courseModel =
    CourseModel(name: course.name,    niveau : course.niveau, section : course.section , uploadFile: course.uploadFile, image : course.image, id: null);

    return await _getMessage(() {
      return remoteDataSource.updateCourse(courseModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddCourse deleteOrUpdateOrAddCourse) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddCourse();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

