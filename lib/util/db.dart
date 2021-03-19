import 'dart:io';

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../model/transaction.dart' as transaction;

class DatabaseUtil {
  static final _databaseName = "transactions.db";
  static final _databaseVersion = 1;

  static final table = 'transactions';

  static final columnId = 'id';
  static final columnDescription = 'description';
  static final columnAmount = 'amount';
  static final columnCurrency = 'currency';

  // Make this a singleton class
  DatabaseUtil._privateConstructor();
  static final DatabaseUtil instance = DatabaseUtil._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // Lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnAmount REAL NOT NULL,
            $columnCurrency TEXT NOT NULL
          )
          ''');
  }

  // Returns the id of the inserted row.
  Future<int> insert(transaction.Transaction t) async {
    Database db = await instance.database;
    return await db.insert(table, t.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<transaction.Transaction>> getAllTransactions() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return transaction.Transaction(
          id: maps[i][columnId],
          description: maps[i][columnDescription],
          amount: maps[i][columnAmount],
          currency: maps[i][columnCurrency]);
    });
  }

  Future<int> getTransactionCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(transaction.Transaction t) async {
    Database db = await instance.database;
    return await db
        .update(table, t.toMap(), where: '$columnId = ?', whereArgs: [t.id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
