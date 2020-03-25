import 'package:path/path.dart';

import 'package:routines/const.dart';
import 'package:sqflite/sqflite.dart';

import 'base_meta.dart';
import 'routines_meta.dart';

class SQLiteProvider { // DatabaseSQLite
  static final SQLiteProvider dbProvider = SQLiteProvider();
  static final int _version = 1;
  static final String dbFilename = Const.SQLITE_DB_FILENAME;
  static final List<BaseMetaSQLite> _tableMetas = List<BaseMetaSQLite>();

  void injectDAO(BaseMetaSQLite table) {
    _tableMetas.add(table);
  }

  SQLiteProvider() {
    injectDAO(RoutineMetaSQLite()); // TODO: Constructor를 쓰지 않고 INJECT 할 방법은?
  }

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    // When using path_provider, use below.
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentDirectory.path, dbFilename);
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbFilename);

    var database = await openDatabase(path, version: _version, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    Future.wait(_tableMetas.map((_table) async => _table.onUpgrade(database, oldVersion, newVersion)));
  }
  void initDB(Database database, int version) async {
    Future.wait(_tableMetas.map((_table) async => _table.initDB(database, version)));
  }
  
}