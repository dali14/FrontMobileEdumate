import 'package:flutter/material.dart';

import '../../domain/entities/course.dart';
import '../widgets/course_detail_page/course_detail_widget.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;
  const CourseDetailPage({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("Course Detail"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CourseDetailWidget(course: course),
      ),
    );
  }
}
