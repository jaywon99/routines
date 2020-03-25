
import 'package:routines/models/routine.dart';

abstract class RoutinesRepository {
  // find all routines
  Future<List<Routine>> findAll();

  // find routine by id.
  Future<Routine> findById(int id);

  // add or update routine.
  // if not exist, add it, else update it.
  Future<int> update(Routine routine);

  // Remove routine.
  Future<int> remove(Routine routine);
}