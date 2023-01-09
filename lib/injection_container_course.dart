import 'core/network/network_info.dart';
import 'features/course/data/datasources/course_local_data_source.dart';
import 'features/course/data/datasources/course_remote_data_source.dart';
import 'features/course/data/repositories/course_repository_implement.dart';
import 'features/course/domain/repositories/course_repository.dart';
import 'features/course/domain/usecases/add_course.dart';
import 'features/course/domain/usecases/delete_course.dart';
import 'features/course/domain/usecases/get_all_courses.dart';
import 'features/course/domain/usecases/update_course.dart';
import 'features/course/presentation/blocs/add_delete_update_course/add_delete_update_course_bloc.dart';
import 'features/course/presentation/blocs/courses/course_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupCourseDI() async {
//! Features - courses

// Bloc

  sl.registerFactory(() => CoursesBloc(getAllCourses: sl()));
  sl.registerFactory(() => AddDeleteUpdateCourseBloc(
      addCourse: sl(), updateCourse: sl(), deleteCourse: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllCourseUsecase(sl()));
  sl.registerLazySingleton(() => AddCourseUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCourseUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCourseUsecase(sl()));

// Repository

  sl.registerLazySingleton<CoursesRepository>(() => CoursesRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<CourseRemoteDataSource>(
          () => CourseRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CourseLocalDataSource>(
          () => CourseLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
