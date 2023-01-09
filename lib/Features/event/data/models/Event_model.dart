
import 'dart:html';

import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({int? id, required String name, required DateTime date, required DateTime duration , required String category, required String  description})
  : super(id: id, name: name, date: date, duration: duration, category: category,  description:  description);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(id: json['id'], name: json['name'], date: json['date'], duration: json['duration'], category: json['category'],   description: json[' description']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'date': date , 'duration': duration, 'category':category,  ' description':  description};
  }
}

