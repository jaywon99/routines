import 'dart:async';
import 'dart:collection';

import 'package:routines/blocs/bloc_provider.dart';
import 'package:routines/models/routine.dart';

import 'package:routines/dao/memory/routines.dart';

class RoutineBloc implements BlocBase {
  // Synchronous Stream to handle the provision of the movie genres
  // data stream. you get data from here
  StreamController<List<Routine>> _routineController = StreamController<List<Routine>>.broadcast();
  Stream<List<Routine>> get routines => _routineController.stream;

  // DAO Object = Find a way to inject this. // Constructor??
  // interface or something similar
  RoutinesMemoryDAO _routinesDao = new RoutinesMemoryDAO();

  void dispose() {
    _routineController.close();
  }

  void update(Routine routine) {
    _routinesDao.update(routine).then((_) => _notify());
  }

  void remove(Routine routine) async {
    _routinesDao.remove(routine).then((_) => _notify());
  }

  void getAll() async {
    List<Routine> _routines = await _routinesDao.findAll();
    _routineController.sink.add(UnmodifiableListView<Routine>(_routines));
  }

  void _notify() async {
    List<Routine> _routines = await _routinesDao.findAll();
    _routineController.sink.add(UnmodifiableListView<Routine>(_routines));
  }

}