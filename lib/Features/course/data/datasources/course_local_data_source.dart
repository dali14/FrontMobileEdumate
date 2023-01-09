import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Core/error/exeptions.dart';
import '../models/Course_model.dart';

abstract class CourseLocalDataSource {
  Future<List<CourseModel>> getCachedCourses();
  Future<Unit> cacheCourses(List<CourseModel> courseModels);
}

const CACHED_COURSES = "CACHED_COURSES";

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final SharedPreferences sharedPreferences;

  CourseLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheCourses(List<CourseModel> courseModels) {
    List courseModelsToJson = courseModels
        .map<Map<String, dynamic>>((courseModel) => courseModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_COURSES, json.encode(courseModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CourseModel>> getCachedCourses() {
    final jsonString = sharedPreferences.getString(CACHED_COURSES);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CourseModel> jsonToPostModels = decodeJsonData
          .map<CourseModel>((jsonPostModel) => CourseModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
