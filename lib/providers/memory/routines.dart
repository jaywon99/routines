import 'package:flutter/material.dart';
import 'package:routines/models/routine.dart';
import 'package:routines/repositories/routines.dart';

class RoutinesMemoryProvider extends RoutinesRepository {
  List<Routine> _routines;
  int _lastId = 0;

  RoutinesMemoryProvider() {
    _routines = List<Routine>();
    // PUT INITIAL DATA for testing
    this.update(Routine(
        title: 'Routine1',
        subtitle: 'Routine Subtitle Red',
        color: Colors.red));
    this.update(Routine(
        title: 'Routine2',
        subtitle: 'Routine Subtitle Green',
        color: Colors.green));
    this.update(Routine(
        title: 'Routine3',
        subtitle: 'Routine Subtitle Blue',
        color: Colors.blue));
  }

  // get all routines
  Future<List<Routine>> findAll() async {
    // PUT DELAY for TESTING
    return Future.delayed(Duration(seconds: 1)).then((onValue) => _routines);
  }

  // find routine by id.
  Future<Routine> findById(int id) async =>
      Future.value(_routines.firstWhere((r) => r.id == id));

  // add or update routine.
  // if not exist, add it, else update it.
  Future<int> update(Routine routine) async {
    // print("before ${routine.id} ${routine.title}");
    if (routine.id == null) {
      // NEW data
      routine.id = (await _nextId());
    }
    int idx = _routines.indexWhere((item) => item.id == routine.id);
    if (idx == -1) {
      _routines.add(routine);
    } else {
      _routines[idx] = routine;
    }
    // print("after ${routine.id} ${routine.title}");
    return Future.value(routine.id);
  }

  // Remove from list.
  Future<int> remove(Routine routine) {
    _routines.removeWhere((item) => item.id == routine.id);
    return Future.value(1);
  }

  Future<int> _nextId() async {
    _lastId = _lastId + 1;
    return Future.value(_lastId);
  }
}
