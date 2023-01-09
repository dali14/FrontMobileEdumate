//import 'update_course_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/course.dart';
import 'delete_course_btn_widget.dart';

class CourseDetailWidget extends StatelessWidget {
  final Course course;
  const CourseDetailWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            course.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //UpdateCourseBtnWidget(course: course),
              DeleteCourseBtnWidget(courseId: course.id!)
            ],
          )
        ],
      ),
    );
  }
}


