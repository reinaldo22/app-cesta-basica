import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();
  factory DatabaseHelper() => _instance;

  static Database _db;


   Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  // Create the database and the  table
  Future initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
   // String databasesPath = await getDatabasesPath();
    String path = join(documentsDirectory.path, 'mercados.db');
    print("db $path");

    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE mercado('
        'id INTEGER PRIMARY KEY,'
        'colaborador TEXT,'
        'categoria TEXT,'
        'nomeMercado TEXT,'
        'preco float,'
        'produto TEXT'
        ')');
  }

  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("alter table mercado add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
