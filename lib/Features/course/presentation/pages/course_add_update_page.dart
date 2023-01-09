import '../../../../Core/widgets/loading_widget.dart';
import 'course_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/util/snackbar_message.dart';
import '../../domain/entities/course.dart';
import '../blocs/add_delete_update_course/add_delete_update_course_bloc.dart';
import '../widgets/course_add_update_page/form_widget.dart';

class courseAddUpdatePage extends StatelessWidget {
  final Course? course;
  final bool isUpdatecourse;
  const courseAddUpdatePage({Key? key, this.course, required this.isUpdatecourse})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatecourse ? "Edit course" : "Add course"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child:
          BlocConsumer<AddDeleteUpdateCourseBloc, AddDeleteUpdateCourseState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateCourseState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => CoursesPage()),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdateCourseState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateCourseState) {
                return LoadingWidget();
              }

              return FormWidget(
                  isUpdateCourse: isUpdatecourse, course: isUpdatecourse ? course : null);
            },
          )),
    );
  }
}
