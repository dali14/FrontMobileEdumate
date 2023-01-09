import 'package:equatable/equatable.dart';
import 'dart:html';
import 'package:flutter/widgets.dart';

class Event extends Equatable {
  final int? id;
  final String name;
  final DateTime date;
  final DateTime duration;
  final String category;
  final String description ;

  //const Event(this.id, this.name, this.date, this.duration, this.category , this.description );
  const Event({required this.name, required this.date, required this.duration, required this.category, required this.description, this.id});


  @override
  // TODO: implement props
  List<Object?> get props => [id, name, date, duration , category , description ];

}
