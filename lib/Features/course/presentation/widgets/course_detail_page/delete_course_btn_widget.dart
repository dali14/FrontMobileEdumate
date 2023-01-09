import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/util/snackbar_message.dart';
import '../../../../../Core/widgets/loading_widget.dart';
import '../../blocs/add_delete_update_course/add_delete_update_course_bloc.dart';
import '../../pages/course_page.dart';
import 'delete_dialog_widget.dart';

class DeleteCourseBtnWidget extends StatelessWidget {
  final int courseId;
  const DeleteCourseBtnWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, courseId),
      icon: Icon(Icons.delete_outline),
      label: Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int courseId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdateCourseBloc,
              AddDeleteUpdateCourseState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateCourseState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => CoursesPage(),
                    ),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdateCourseState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateCourseState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(courseId: courseId);
            },
          );
        });
  }
}
