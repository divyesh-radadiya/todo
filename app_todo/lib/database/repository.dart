import 'package:sqflite/sqflite.dart';
import 'package:app_todo/database/database_connection.dart';

class Repository {
  DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table, data) async {
    var con = await database;
    return await con.insert(table, data);
  }

  readData(table) async {
    var con = await database;
    return await con.query(table);
  }

  readDataById(table, itemId) async {
    var con = await database;
    return await con.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var con = await database;
    return await con
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async {
    var con = await database;
    return await con.rawDelete("DELETE from $table where id =$itemId");
  }
}
