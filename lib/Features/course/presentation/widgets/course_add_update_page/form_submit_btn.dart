import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdateCourse;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdateCourse, required isUpdatecourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdateCourse ? Icon(Icons.edit) : Icon(Icons.add),
        label: Text(isUpdateCourse ? "Update" : "Add"));
  }
}