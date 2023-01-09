import '../../blocs/add_delete_update_course/add_delete_update_course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int courseId;
  const DeleteDialogWidget({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdateCourseBloc>(context).add(
              DeleteCourseEvent(courseId: courseId),
            );
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
