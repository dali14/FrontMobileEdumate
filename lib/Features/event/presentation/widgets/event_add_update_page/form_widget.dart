
import '../../blocs/add_delete_update_event/add_delete_update_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../domain/entities/event.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateEvent;
  final Event? event;
  const FormWidget({
    Key? key,
    required this.isUpdateEvent,
    this.event,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateEvent) {
      _nameController.text = widget.event!.name;
      _dateController.text = widget.event!.date as String;
      _durationController.text = widget.event!.duration as String;
      _categoryController.text = widget.event!.category;
      _descriptionController.text = widget.event!.description;


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
                name: "Date", multiLines: true, controller: _dateController),
            TextFormFieldWidget(
                name: "Duration ", multiLines: true, controller: _durationController),
            TextFormFieldWidget(
                name: "Category", multiLines: true, controller: _categoryController),
            TextFormFieldWidget(
                name: "Description", multiLines: true, controller: _descriptionController),
            FormSubmitBtn(
              isUpdateEvent: widget.isUpdateEvent,
              onPressed: validateFormThenUpdateOrAddEvent, isUpdateevent: null,),
          ]),
    );
  }
    void validateFormThenUpdateOrAddEvent() {
      final isValid = _formKey.currentState!.validate();

      if (isValid) {
        final event = Event(
          id: widget.isUpdateEvent ? widget.event!.id : null,
          name: _nameController.text,
          date : DateTime.parse(_dateController.text),
          duration:  DateTime.parse(_durationController.text),
          category: _categoryController.text,
          description: _descriptionController.text,


        );

  if (widget.isUpdateEvent) {
        BlocProvider.of<AddDeleteUpdateEventBloc>(context)
            .add(UpdateEventEvent(event: event));
      } else {
        BlocProvider.of<AddDeleteUpdateEventBloc>(context)
            .add(AddEventEvent(event: event));
      }
    }
  }
}
