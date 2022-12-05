import 'package:sqflite/sqflite.dart';
import 'package:terator/core/database.dart';
import 'package:terator/models/letter_model.dart';

class LetterRepository {
  // reference to our single class that manages the database
  final dbInstance = DatabaseInstance();

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.init;
    return await db.insert(dbInstance.letterTable, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await dbInstance.init;
    int id = row[dbInstance.letterId];
    return await db.update(dbInstance.letterTable, row,
        where: '${dbInstance.letterId} = ?', whereArgs: [id]);
  }

  Future<List<LetterModel>> all({int? limit, int? page}) async {
    try {
      // Setup pagination
      limit ??= 10;
      int offset = (limit * (page ?? 1)) - limit;

      Database db = await dbInstance.init;
      final data = await db.rawQuery(
          'SELECT *  FROM ${dbInstance.letterTable} ORDER BY ${dbInstance.letterTable}.${dbInstance.letterUpdatedAt} DESC LIMIT $limit OFFSET $offset',
          []);

      List<LetterModel> listLetters = [];
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          LetterModel letterModel = LetterModel(
            id: int.parse(data[i]['id'].toString()),
            accountId: int.parse((data[i]['account_id'] ?? 1).toString()),
            name: data[i]['name'].toString(),
            title: data[i]['title'].toString(),
            html: data[i]['html'].toString(),
            withSignature: data[i]['with_signature'].toString(),
            createdAt: data[i]['created_at'].toString(),
            updatedAt: data[i]['updated_at'].toString(),
          );
          listLetters.add(letterModel);
        }
      }

      return listLetters;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> delete(int id) async {
    Database db = await dbInstance.init;
    return await db.delete(dbInstance.letterTable,
        where: '${dbInstance.letterId} = ?', whereArgs: [id]);
  }
}
