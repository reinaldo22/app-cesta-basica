import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();
  factory DatabaseHelper() => _instance;

  static Database _database;

  Future<Database> get database async {
    // If database ja existe, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDb();

    return _database;
  }

  // Create the database and the  table
  Future initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mercados.db');
    print("db $path");

    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Mercados('
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
      await db.execute("alter table mercadinho add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await _database;
    return dbClient.close();
  }
}
