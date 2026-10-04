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

  /// Total number of saved letters (unfiltered).
  Future<int> count() async {
    Database db = await dbInstance.init;
    final data = await db
        .rawQuery('SELECT COUNT(*) AS total FROM ${dbInstance.letterTable}');
    return int.tryParse(data.first['total'].toString()) ?? 0;
  }

  /// [query] matches the file title or template name; [templateNames]
  /// restricts to letters made from those templates (`name` column holds the
  /// template title). An empty [templateNames] list matches nothing.
  Future<List<LetterModel>> all(
      {int? limit,
      int? page,
      String? query,
      List<String>? templateNames}) async {
    try {
      // Setup pagination
      limit ??= 10;
      int offset = (limit * (page ?? 1)) - limit;

      final where = <String>[];
      final args = <Object?>[];
      if (query != null && query.trim().isNotEmpty) {
        where.add(
            '(${dbInstance.letterTitle} LIKE ? OR ${dbInstance.letterName} LIKE ?)');
        args.addAll(['%${query.trim()}%', '%${query.trim()}%']);
      }
      if (templateNames != null) {
        if (templateNames.isEmpty) return [];
        where.add(
            '${dbInstance.letterName} IN (${List.filled(templateNames.length, '?').join(',')})');
        args.addAll(templateNames);
      }
      final whereSql = where.isEmpty ? '' : 'WHERE ${where.join(' AND ')}';

      Database db = await dbInstance.init;
      final data = await db.rawQuery(
          'SELECT *  FROM ${dbInstance.letterTable} $whereSql ORDER BY ${dbInstance.letterTable}.${dbInstance.letterUpdatedAt} DESC LIMIT $limit OFFSET $offset',
          args);

      List<LetterModel> listLetters = [];
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          LetterModel letterModel = LetterModel(
            id: int.parse(data[i]['id'].toString()),
            accountId: int.parse((data[i]['account_id'] ?? 1).toString()),
            name: data[i]['name'].toString(),
            title: data[i]['title'].toString(),
            html: data[i]['html'].toString(),
            withSignature: int.parse(data[i]['with_signature'].toString()),
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
