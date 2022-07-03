import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data_layer/models/clinic_model.dart';
import '../../../data_layer/models/user_model.dart';

class SQFLiteHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "shady.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  static void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, full_name TEXT, id_type TEXT, gender TEXT, birth_date TEXT, personal_address TEXT, city TEXT,region TEXT, mobile TEXT, email TEXT,password TEXT, license_image TEXT,main_speciality TEXT, scientific_degree TEXT, user_audio TEXT, user_video TEXT)");
    await db.execute(
        "CREATE TABLE Clinic(id INTEGER PRIMARY KEY, user_id INTEGER, name TEXT, address TEXT, phone TEXT)");
    print("Created tables");
  }

  static Future saveUser(UserModel user) async {
    var dbClient = await db;
    await dbClient.insert('User', user.toJson());
  }

  static Future saveClinic(ClinicModel clinic) async {
    var dbClient = await db;
    await dbClient.insert('Clinic', clinic.toJson());
  }
  // static Future saveClinic(ClinicModel clinic) async {
  //   var dbClient = await db;
  //   await dbClient.insert('Clinic', clinic.toJson());
  //   List<Map> list = await dbClient.rawQuery('SELECT * FROM Clinic');
  //   print('aas');
  // }

  static Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    return await dbClient
        .update('User', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<List<UserModel>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    List<UserModel> users = [];
    for (int i = 0; i < list.length; i++) {
      users.add(
        UserModel.fromJson(list[i]),
      );
    }
    print(users.length);
    return users;
  }

  static Future<List<ClinicModel>> getUserClinics({required int userId}) async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Clinic WHERE id = $userId');
    List<ClinicModel> clinics = [];
    for (int i = 0; i < list.length; i++) {
      clinics.add(
        ClinicModel.fromJson(list[i]),
      );
    }
    print(clinics.length);
    return clinics;
  }
}
