import 'package:equatable/equatable.dart';
import 'dart:html';
import 'package:flutter/widgets.dart';
class Course  extends Equatable {
  final int? id;
  final String name;
  final int niveau;
  final String section;
  final String uploadFile;
  final String image;

  //const Course(this.id, this.name, this.niveau, this.section, this.uploadFile, this.image);
  const Course({required this.name, required this.niveau, required this.section, required this.uploadFile, required this.image, this.id});


  @override
  // TODO: implement props
  List<Object?> get props =>  [id, name , niveau ,uploadFile , image] ;
}



