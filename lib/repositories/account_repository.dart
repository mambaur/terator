import 'package:sqflite/sqflite.dart';
import 'package:terator/core/database.dart';

class AccountRepository {
  // reference to our single class that manages the database
  final dbInstance = DatabaseInstance();

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.init;
    return await db.insert(dbInstance.accountTable, row);
  }

  Future<int> delete(int id) async {
    Database db = await dbInstance.init;
    return await db.delete(dbInstance.accountTable,
        where: '${dbInstance.accountId} = ?', whereArgs: [id]);
  }
}
