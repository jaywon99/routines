import 'package:flutter/material.dart';
import 'package:routines/models/routines.dart';
import 'package:routines/widgets/common/colorpicker.dart';

class RoutineItemEditForm extends StatefulWidget {
  RoutineItemEditForm({Key key, this.routine}) : super(key: key);
  final Routine routine;

  @override
  _RoutineItemEditFormState createState() => _RoutineItemEditFormState();
}

class _RoutineItemEditFormState extends State<RoutineItemEditForm> {
  final titleController =
      TextEditingController(); // https://flutter.dev/docs/cookbook/forms/retrieve-input
  final subtitleController = TextEditingController();
  final colorController = ColorPickingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.routine?.title ?? "";
    subtitleController.text = widget.routine?.subtitle ?? "";
    colorController.color = widget.routine?.color ?? null;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    subtitleController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = (widget.routine == null) ? "New Routine" : "Edit Routine";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter Routine Title',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter title text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: subtitleController,
                decoration: InputDecoration(
                  labelText: 'SubTitle',
                  hintText: 'Enter Routine SubTitle',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter sub text';
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity, // match_parent
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ColorPickerRaisedButtonWidget(
                  controller: colorController,
                  child: Text('Pick Color'),
                ),),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pop(
                        Routine(
                          id: widget.routine?.id ?? -1,
                          title: titleController.text,
                          subtitle: subtitleController.text,
                          color: colorController.color,
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
