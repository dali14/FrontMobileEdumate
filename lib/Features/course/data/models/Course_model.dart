
import 'dart:html';

import '../../domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({int? id, required String name, required int niveau, required String section, required String uploadFile , required String image})
      : super(id: id, name: name, niveau: niveau, section: section, uploadFile: uploadFile, image: image);



  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(id: json['id'], name: json['name'], niveau: json['niveau'], section: json['section'], uploadFile: json['uploadFile'],  image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'niveau': niveau , 'section': section, 'uploadFile': uploadFile,  'image': image};
  }
}
