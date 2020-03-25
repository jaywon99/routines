import 'package:sqflite/sqflite.dart';

import 'package:routines/providers/sqlite/base_meta.dart';

class RoutineMetaSQLite extends BaseMetaSQLite {
  static final String tableName = "routines";

  // 아래 두개를 개별 class로 옮길 방법은?
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {
      // DO Upgrade DB
    }
  }

  void initDB(Database database, int version) async {
    // Version 1
    await database.execute("CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY autoincrement, "
      "title TEXT, "
      "subtitle TEXT, "
      "color INTEGER "
      ")");
  }
}