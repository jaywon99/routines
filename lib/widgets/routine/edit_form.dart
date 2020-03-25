import 'package:flutter/material.dart';
import 'package:routines/blocs/bloc_provider.dart';
import 'package:routines/blocs/routine_bloc.dart';
import 'package:routines/models/routine.dart';
import 'package:routines/widgets/common/color_picker_raised_button.dart';

class RoutineEditForm extends StatefulWidget {
  RoutineEditForm({Key key, this.routine}) : super(key: key);
  final Routine routine;

  @override
  _RoutineEditFormState createState() => _RoutineEditFormState();
}

class _RoutineEditFormState extends State<RoutineEditForm> {
  final titleController =
      TextEditingController(); // https://flutter.dev/docs/cookbook/forms/retrieve-input
  final subtitleController = TextEditingController();
  final colorController = ColorPickingController();
  final _formKey = GlobalKey<FormState>();
  get _isNew => widget.routine == null;

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
    final title = _isNew ? "New Routine" : "Edit Routine";

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
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Routine routine = Routine(
                        id: widget.routine?.id ?? null,
                        title: titleController.text,
                        subtitle: subtitleController.text,
                        color: colorController.color,
                      );

                      final RoutineBloc bloc =
                          BlocProvider.of<RoutineBloc>(context);
                      bloc.update(routine);

                      // TODO: open snackbar after closing window or return back??
                      // String message = _isNew
                      //     ? "${routine.title} Added."
                      //     : "${routine.title} Updated.";
                      // _scaffoldKey.currentState
                      //   ..removeCurrentSnackBar()
                      //   ..showSnackBar(SnackBar(content: Text(message)));

                      Navigator.of(context).pop();
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
