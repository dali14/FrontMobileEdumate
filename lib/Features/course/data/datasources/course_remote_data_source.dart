import 'dart:convert';

import '../../../../core/error/exeptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../course/data/models/Course_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getAllCourses();
  Future<Unit> deleteCourse(int courseId);
  Future<Unit> updateCourse(CourseModel courseModel);
  Future<Unit> addCourse(CourseModel courseModel);
}
const BASE_URL = "https://jsonplaceholder.typicode.com";

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final http.Client client;

  CourseRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CourseModel>> getAllCourses() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/courses/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<CourseModel> postModels = decodedJson
          .map<CourseModel>((jsonPostModel) => CourseModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addCourse(CourseModel courseModel) async {
    final body = {
      "name": courseModel.name,
      "niveau": courseModel.niveau,
      "section": courseModel.section,
      "uploadFile": courseModel.uploadFile,
      "image": courseModel.image
    };

    final response =
    await client.post(Uri.parse(BASE_URL + "/courses/"), body: body );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteCourse(int courseId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "/courses/${courseId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateCourse(CourseModel courseModel) async {
    final courseId = courseModel.id.toString();
    final body = {
      "name": courseModel.name,
      "niveau": courseModel.niveau,
      "section": courseModel.section,
      "uploadFile": courseModel.uploadFile,
      "image": courseModel.image
    };

    final response = await client.patch(
      Uri.parse(BASE_URL + "/courses/$courseId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

