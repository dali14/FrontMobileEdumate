import 'dart:io';
import 'dart:html';

import '../../blocs/add_delete_update_course/add_delete_update_course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/course.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateCourse;
  final Course? course;
  const FormWidget({
    Key? key,
    required this.isUpdateCourse,
    this.course,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _niveauController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _uploadFileController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateCourse) {
      _nameController.text = widget.course!.name;
      _niveauController.text = widget.course!.niveau as String;
      _sectionController.text = widget.course!.section;
    _uploadFileController.text = widget.course!.uploadFile ;
      //_uploadFileController= File(_uploadFileController.text);
      //_uploadFileController.text = widget.course!.uploadFile.toString();
      _imageController.text = widget.course!.image;



    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Name", multiLines: false, controller: _nameController),
            TextFormFieldWidget(
                name: "Niveau", multiLines: true, controller: _niveauController),
            TextFormFieldWidget(
                name: "Section", multiLines: true, controller: _sectionController),
        TextFormFieldWidget(
            name: "UploadFile", multiLines: true, controller: _uploadFileController),
            TextFormFieldWidget(
                name: "Image", multiLines: true, controller: _imageController),

            FormSubmitBtn(
              isUpdateCourse: widget.isUpdateCourse,
              onPressed: validateFormThenUpdateOrAddCourse, isUpdatecourse: null,),
          ]),
    );
  }

  void validateFormThenUpdateOrAddCourse() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final course = Course(
        id: widget.isUpdateCourse ? widget.course!.id : null,
        name: _nameController.text,
        niveau: int.parse(_niveauController.text) ,
        section: _sectionController.text,
        uploadFile: _uploadFileController.text,
        //uploadFile: _uploadFile,
        image: _imageController.text,
      );

      if (widget.isUpdateCourse) {
        BlocProvider.of<AddDeleteUpdateCourseBloc>(context)
            .add(UpdateCourseEvent(course: course));
      } else {
        BlocProvider.of<AddDeleteUpdateCourseBloc>(context)
            .add(AddCourseEvent(course: course));
      }
    }
  }
}
//o