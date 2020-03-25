import 'dart:ui';

import 'package:routines/models/routine.dart';
import 'package:routines/repositories/routines.dart';

import 'package:routines/providers/sqlite/provider.dart';

import 'routines_meta.dart';

// interface style로 만들어야 하지 않을지..
class RoutinesSQLiteProvider extends RoutinesRepository {
  SQLiteProvider dbProvider = SQLiteProvider.dbProvider; // 이건 inject할 필요가 없음. 설마 다른 걸 쓸 수 있을리가.. ㅋㅋ

  // get all routines
  Future<List<Routine>> findAll({List<String> columns}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(RoutineMetaSQLite.tableName, columns: columns);
    List<Routine> routines = result.isNotEmpty
        ? result.map((item) => fromDatabaseJson(item)).toList()
        : [];
    return routines;
  }

  // find routine by id.
  Future<Routine> findById(int id) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(RoutineMetaSQLite.tableName, where: 'id = ?', whereArgs: [id]);
    Routine routine = result.isNotEmpty
        ? fromDatabaseJson(result.first)
        : null; // TODO: Exception??
    return routine;
  }

  // add or update routine.
  // if not exist, add it, else update it.
  Future<int> update(Routine routine) async {
    final db = await dbProvider.database;
    var result;
    if (routine.id == null) {
      result = db.insert(RoutineMetaSQLite.tableName, toDatabaseJson(routine));
    } else {
      result = await db.update(
          RoutineMetaSQLite.tableName, toDatabaseJson(routine),
          where: "id = ?", whereArgs: [routine.id]);
    }
    return result;
  }

  // Remove from list.
  Future<int> remove(Routine routine) async {
    final db = await dbProvider.database;
    var result = await db.delete(RoutineMetaSQLite.tableName,
        where: "id = ?", whereArgs: [routine.id]);
    return result;
  }

  static Routine fromDatabaseJson(Map<String, dynamic> data) => Routine(
        //Factory method will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Todo object

        id: data['id'],
        title: data['title'],
        subtitle: data['subtitle'],
        color: Color(data['color']),

        //Since sqlite doesn't have boolean type for true/false,
        //we will use 0 to denote that it is false
        //and 1 for true
        // isDeleted: data['is_deleted'] == 0 ? false : true,
      );

  static Map<String, dynamic> toDatabaseJson(Routine routine) => {
        //A method will be used to convert Todo objects that
        //are to be stored into the datbase in a form of JSON

        "id": routine.id,
        "title": routine.title,
        "subtitle": routine.subtitle,
        "color": routine.color.value,
        // "is_deleted": this.isDeleted == false ? 0 : 1,
      };
}
