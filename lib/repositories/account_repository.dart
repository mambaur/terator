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

  Future<List<AccountModel>> all({int? limit, int? page}) async {
    try {
      // Setup pagination
      limit ??= 10;
      int offset = (limit * (page ?? 1)) - limit;

      Database db = await dbInstance.init;
      final data = await db.rawQuery(
          'SELECT *  FROM ${dbInstance.accountTable} ORDER BY ${dbInstance.accountTable}.${dbInstance.accountUpdatedAt} DESC LIMIT $limit OFFSET $offset',
          []);

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
            lastEducation: data[i]['last_education'].toString() == "null"
                ? null
                : data[i]['last_education'].toString(),
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
