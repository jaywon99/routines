import 'package:flutter/material.dart';
import 'package:routines/blocs/bloc_provider.dart';
import 'package:routines/blocs/routine_bloc.dart';
import 'package:routines/const.dart';
import 'package:routines/models/routine.dart';
import 'package:routines/widgets/common/loading_widget.dart';
import 'package:routines/widgets/routine/list_item_widget.dart';

class RoutineListPage extends StatefulWidget {
  @override
  _RoutineListPageState createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final RoutineBloc bloc = BlocProvider.of<RoutineBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Routines Management'),
      ),
      body: Center(
        child: StreamBuilder<List<Routine>>(
          stream: bloc.routines,
          builder:
              (BuildContext context, AsyncSnapshot<List<Routine>> snapshot) {
            if (snapshot.data == null) {
              bloc.getAll();
              return LoadingWidget();
            }
            List<Routine> routines = snapshot.data;
            return ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, index) {
                return RoutineListItem(
                  routine: routines[index],
                  onEditAction: (routine) => _editRoutineItem(context, routine),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newRoutineItem(context),
        tooltip: 'New Routine',
        child: Icon(Icons.add),
      ),
    );
  }

  // TODO: Moving to editform.dart (handle Snackbar)
  Future<void> _newRoutineItem(BuildContext context) async {
    final resultRoutine = await Navigator.pushNamed(
      context,
      Const.ROUTE_ROUTINE_EDIT_FORM,
      arguments: null,
    );

    if (resultRoutine != null) {
      Routine routine = resultRoutine as Routine;
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("${routine.title} Added.")));
    }
  }

  // TODO: Moving to editform.dart (handle Snackbar)
  Future<void> _editRoutineItem(BuildContext context, Routine routine) async {
    final resultRoutine = await Navigator.pushNamed(
      context,
      Const.ROUTE_ROUTINE_EDIT_FORM,
      arguments: routine,
    );
    if (resultRoutine != null) {
      Routine routine = resultRoutine as Routine;
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text("${routine.title} Edited.")));
    }
  }
}

// RoutineListPage 와 RoutineList로 나눌까??
