import 'package:flutter/material.dart';
import 'package:routines/models/routines.dart';
import 'package:routines/widgets/routines/editform.dart';
import 'package:routines/widgets/routines/listitem.dart';

class RoutineList extends StatefulWidget {
  @override
  _RoutineListState createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList> {
  List<Routine> routines = <Routine>[
    Routine(
        id: 1,
        title: 'Routine1',
        subtitle: 'Routine Subtitle Red',
        color: Colors.red),
    Routine(
        id: 2,
        title: 'Routine2',
        subtitle: 'Routine Subtitle Green',
        color: Colors.green),
    Routine(
        id: 3,
        title: 'Routine3',
        subtitle: 'Routine Subtitle Blue',
        color: Colors.blue),
  ];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Routines Management'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: routines.length,
          itemBuilder: (context, index) {
            return RoutineListItem(
              routine: routines[index],
              onDismissedAction: _dismissRoutineItem,
              onEditAction: _editRoutineItem,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newRoutineItem,
        tooltip: 'New Routine',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _newRoutineItem() async {
    final resultRoutine = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoutineItemEditForm()),
    );
    if (resultRoutine != null) {
      resultRoutine.id = routines.last.id + 1;
      setState(() {
        routines.add(resultRoutine);
      });

      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text("${resultRoutine.title} Added.")));
    }
  }

  Future<void> _editRoutineItem(Routine routine) async {
    final resultRoutine = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RoutineItemEditForm(routine: routine)),
    );
    if (resultRoutine != null) {
      setState(() {
        // 1. 찾아서 바꿔끼자.
        int idx = routines.indexWhere((item) => item.id == resultRoutine.id);
        routines[idx] = resultRoutine;
      });

      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text("${resultRoutine.title} Edited.")));
    }
  }

  void _dismissRoutineItem(Routine routine) {
    setState(() {
      routines.removeWhere((item) => item.id == routine.id);
    });

    // Then show a snackbar.
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("${routine.title} dismissed")));
  }
}

// RoutineListPage 와 RoutineList로 나눌까??
