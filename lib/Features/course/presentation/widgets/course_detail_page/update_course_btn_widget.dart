import 'package:flutter/material.dart';

import '../../../domain/entities/course.dart';
import '../../pages/course_add_update_page.dart';


class UpdateCourseBtnWidget extends StatelessWidget {
  final Course course;
  const UpdateCourseBtnWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => courseAddUpdatePage(
                isUpdatecourse: true,
                course: course,
              ),
            ));
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}
