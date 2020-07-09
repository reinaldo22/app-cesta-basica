import 'package:cesta/database/database_helper.dart';
import 'package:cesta/model/mercado.dart';
import 'package:sqflite/sqlite_api.dart';

class MercadoDAO {
  Future<Database> get db => DatabaseHelper.getInstance().database;

  Future<int> save(Mercado mercado) async {
    var dbClient = await db;
    var id = await dbClient.insert("mercados", mercado.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<Mercado>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from mercados');

    final mercados =
        list.map<Mercado>((json) => Mercado.fromJson(json)).toList();

    return mercados;
  }

  Future<Mercado> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from mercados where id = ?', [id]);

    if (list.length > 0) {
      return new Mercado.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(Mercado mercado) async {
    Mercado c = await findById(mercado.id);
    var exists = c != null;
    return exists;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from mercados where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from mercados');
  }

  Future<List<Mercado>> findAllByColaborador(String colaborador) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(
        'select * from mercados where colaborador =? ', [colaborador]);

    final carros = list.map<Mercado>((json) => Mercado.fromJson(json)).toList();

    return carros;
  }
}
