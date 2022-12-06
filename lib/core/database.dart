import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseInstance {
  final String _databaseName = "surat_generator.db";
  final int _databaseVersion = 1;

  // Account Table
  final String accountTable = 'accounts';
  final String accountId = 'id';
  final String accountName = 'name';
  final String accountParentName = 'parent_name';
  final String accountPlaceAndDateOfBirth = 'place_and_date_of_birth';
  final String accountGender = 'gender'; // male, female
  final String accountReligion = 'religion';
  final String accountLastEducation = 'last_education';
  final String accountEducationClass = 'education_class';
  final String accountEducationInstitution = 'education_institution';
  final String accountHeightOrWeight = 'height_or_weight'; // 30/23
  final String accountTelephone = 'telephone';
  final String accountEmail = 'email';
  final String accountMaritalStatus = 'marital_status';
  final String accountAddress = 'address';
  final String accountSignatureImage = 'signature_image';
  final String accountLetterCityWritten = 'letter_city_written';
  final String accountCreatedAt = 'created_at';
  final String accountUpdatedAt = 'updated_at';

  // My File Table
  final String letterTable = 'letters';
  final String letterId = 'id';
  final String letterAccountId = 'account_id';
  final String letterName = 'name';
  final String letterTitle = 'title';
  final String letterHtml = 'html';
  final String letterWithSignature = 'with_signature';
  final String letterCreatedAt = 'created_at';
  final String letterUpdatedAt = 'updated_at';

  // only have a single app-wide reference to the database
  Database? _db;
  Future<Database> get init async {
    if (_db != null) return _db!;
    // lazily instantiate the db the first time it is accessed
    _db = await _openDatabase();
    return _db!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _openDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $accountTable (
            $accountId INTEGER PRIMARY KEY,
            $accountParentName TEXT NULL,
            $accountName TEXT NULL,
            $accountPlaceAndDateOfBirth TEXT NULL,
            $accountGender TEXT NULL,
            $accountReligion TEXT NULL,
            $accountLastEducation TEXT NULL,
            $accountEducationClass TEXT NULL,
            $accountEducationInstitution TEXT NULL,
            $accountHeightOrWeight TEXT NULL,
            $accountTelephone TEXT NULL,
            $accountEmail TEXT NULL,
            $accountMaritalStatus TEXT NULL,
            $accountAddress TEXT NULL,
            $accountSignatureImage TEXT NULL,
            $accountLetterCityWritten TEXT NULL,
            $accountCreatedAt TEXT NULL,
            $accountUpdatedAt TEXT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $letterTable (
            $letterId INTEGER PRIMARY KEY,
            $letterAccountId INTEGER NULL,
            $letterName TEXT NULL,
            $letterTitle TEXT NULL,
            $letterHtml TEXT NULL,
            $letterWithSignature INTEGER NULL,
            $letterCreatedAt TEXT NULL,
            $letterUpdatedAt TEXT NULL
          )
          ''');
  }
}
