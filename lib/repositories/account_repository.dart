import 'package:sqflite/sqflite.dart';
import 'package:terator/core/database.dart';
import 'package:terator/models/account_model.dart';

class AccountRepository {
  // reference to our single class that manages the database
  final dbInstance = DatabaseInstance();

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await dbInstance.init;
    return await db.insert(dbInstance.accountTable, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await dbInstance.init;
    int id = row[dbInstance.accountId];
    return await db.update(dbInstance.accountTable, row,
        where: '${dbInstance.accountId} = ?', whereArgs: [id]);
  }

  /// Total number of saved accounts (unfiltered); used for the free-tier
  /// account limit.
  Future<int> count() async {
    Database db = await dbInstance.init;
    final data = await db
        .rawQuery('SELECT COUNT(*) AS total FROM ${dbInstance.accountTable}');
    return int.tryParse(data.first['total'].toString()) ?? 0;
  }

  /// [query] matches name, address, telephone or email.
  Future<List<AccountModel>> all({int? limit, int? page, String? query}) async {
    try {
      // Setup pagination
      limit ??= 10;
      int offset = (limit * (page ?? 1)) - limit;

      String whereSql = '';
      final args = <Object?>[];
      if (query != null && query.trim().isNotEmpty) {
        final columns = [
          dbInstance.accountName,
          dbInstance.accountAddress,
          dbInstance.accountTelephone,
          dbInstance.accountEmail,
        ];
        whereSql = 'WHERE ${columns.map((c) => '$c LIKE ?').join(' OR ')}';
        args.addAll(List.filled(columns.length, '%${query.trim()}%'));
      }

      Database db = await dbInstance.init;
      final data = await db.rawQuery(
          'SELECT *  FROM ${dbInstance.accountTable} $whereSql ORDER BY ${dbInstance.accountTable}.${dbInstance.accountUpdatedAt} DESC LIMIT $limit OFFSET $offset',
          args);

      List<AccountModel> listAccounts = [];
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++) {
          AccountModel accountModel = AccountModel(
            id: int.parse(data[i]['id'].toString()),
            name: data[i]['name'].toString(),
            parentName: data[i]['parent_name'].toString() == "null"
                ? null
                : data[i]['parent_name'].toString(),
            placeAndDateOfBirth:
                data[i]['place_and_date_of_birth'].toString() == "null"
                    ? null
                    : data[i]['place_and_date_of_birth'].toString(),
            gender: data[i]['gender'].toString() == "null"
                ? null
                : data[i]['gender'].toString(),
            religion: data[i]['religion'].toString() == "null"
                ? null
                : data[i]['religion'].toString(),
            educationNumber: data[i]['education_number'].toString() == "null"
                ? null
                : data[i]['education_number'].toString(),
            lastEducation: data[i]['last_education'].toString() == "null"
                ? null
                : data[i]['last_education'].toString(),
            educationFaculty: data[i]['education_faculty'].toString() == "null"
                ? null
                : data[i]['education_faculty'].toString(),
            educationStudyProgram:
                data[i]['education_study_program'].toString() == "null"
                    ? null
                    : data[i]['education_study_program'].toString(),
            educationAddress: data[i]['education_address'].toString() == "null"
                ? null
                : data[i]['education_address'].toString(),
            educationClass: data[i]['education_class'].toString() == "null"
                ? null
                : data[i]['education_class'].toString(),
            educationInstitution:
                data[i]['education_institution'].toString() == "null"
                    ? null
                    : data[i]['education_institution'].toString(),
            heightOrWeight: data[i]['height_or_weight'].toString() == "null"
                ? null
                : data[i]['height_or_weight'].toString(),
            telephone: data[i]['telephone'].toString() == "null"
                ? null
                : data[i]['telephone'].toString(),
            email: data[i]['email'].toString() == "null"
                ? null
                : data[i]['email'].toString(),
            maritalStatus: data[i]['marital_status'].toString() == "null"
                ? null
                : data[i]['marital_status'].toString(),
            position: data[i]['position'].toString() == "null"
                ? null
                : data[i]['position'].toString(),
            address: data[i]['address'].toString() == "null"
                ? null
                : data[i]['address'].toString(),
            signatureImage: data[i]['signature_image'].toString() == "null"
                ? null
                : data[i]['signature_image'].toString(),
            letterCityWritten:
                data[i]['letter_city_written'].toString() == "null"
                    ? null
                    : data[i]['letter_city_written'].toString(),
            createdAt: data[i]['created_at'].toString(),
            updatedAt: data[i]['updated_at'].toString(),
          );
          listAccounts.add(accountModel);
        }
      }

      return listAccounts;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> delete(int id) async {
    Database db = await dbInstance.init;
    return await db.delete(dbInstance.accountTable,
        where: '${dbInstance.accountId} = ?', whereArgs: [id]);
  }
}
