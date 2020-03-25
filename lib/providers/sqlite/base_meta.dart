import 'package:sqflite/sqflite.dart';

abstract class BaseMetaSQLite {
  void onUpgrade(Database database, int oldVersion, int newVersion);
  void initDB(Database database, int version);
}
