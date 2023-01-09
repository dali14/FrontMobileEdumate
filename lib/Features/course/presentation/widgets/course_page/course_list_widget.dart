import '../../../../course/domain/entities/course.dart';
import '../../pages/course_detail_page.dart';
import 'package:flutter/material.dart';


class CourseListWidget extends StatelessWidget {
  final List<Course> courses;
  const CourseListWidget({
    Key? key,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(courses[index].id.toString()),
          title: Text(courses[index].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(courses[index].name, style: TextStyle(fontSize: 16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CourseDetailPage(course: courses[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}
