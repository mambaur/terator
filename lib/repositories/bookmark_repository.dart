import 'package:sqflite/sqflite.dart';
import 'package:terator/core/database.dart';
import 'package:terator/models/bookmark_model.dart';

class BookmarkRepository {
  final dbInstance = DatabaseInstance();

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.init;
    return await db.insert(
      dbInstance.bookmarkTable,
      row,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<BookmarkModel>> all({int? limit, int? page}) async {
    try {
      Database db = await dbInstance.init;

      final String orderBy =
          'ORDER BY ${dbInstance.bookmarkTable}.${dbInstance.bookmarkCreatedAt} DESC';

      String query;
      if (limit != null) {
        final int offset = (limit * (page ?? 1)) - limit;
        query =
            'SELECT * FROM ${dbInstance.bookmarkTable} $orderBy LIMIT $limit OFFSET $offset';
      } else {
        query = 'SELECT * FROM ${dbInstance.bookmarkTable} $orderBy';
      }

      final data = await db.rawQuery(query, []);

      return data.map((row) => BookmarkModel.fromJson(row)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<BookmarkModel?> findByKey(String letterKey) async {
    Database db = await dbInstance.init;
    final data = await db.query(
      dbInstance.bookmarkTable,
      where: '${dbInstance.bookmarkLetterKey} = ?',
      whereArgs: [letterKey],
      limit: 1,
    );
    if (data.isEmpty) return null;
    return BookmarkModel.fromJson(data.first);
  }

  Future<int> deleteByKey(String letterKey) async {
    Database db = await dbInstance.init;
    return await db.delete(
      dbInstance.bookmarkTable,
      where: '${dbInstance.bookmarkLetterKey} = ?',
      whereArgs: [letterKey],
    );
  }

  Future<int> deleteAll() async {
    Database db = await dbInstance.init;
    return await db.delete(dbInstance.bookmarkTable);
  }
}
