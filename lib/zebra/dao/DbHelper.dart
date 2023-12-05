import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sheti_next/zebra/dao/models/UserModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const String Table_Farms = 'farms';

  static const int Version = 1;

  static const String C_firstName = 'firstName';
  static const String C_lastName = 'lastName';
  static const String C_email = 'email';
  static const String C_mobileNo = 'mobileNo';
  static const String C_pin = 'pin';

  static const String C_farmName = 'farmName';
  static const String C_farmAddress = 'farmAddress';
  static const String C_farmArea = 'farmArea';
  static const String C_unit = 'unit';
  static const String C_farmType = 'farmType';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), DB_Name);
    return await openDatabase(
      path,
      version: Version,
      onCreate: (db, version) {
        // Create user table
        db.execute(
          '''
          CREATE TABLE $Table_User (
            $C_firstName TEXT, 
            $C_lastName TEXT,
            $C_email TEXT,
            $C_mobileNo TEXT,
            $C_pin TEXT,
            UNIQUE($C_mobileNo)
          )
          ''',
        );

        // Create farms table
        db.execute(
          '''
          CREATE TABLE $Table_Farms (
            $C_farmName TEXT,
            $C_farmAddress TEXT,
            $C_farmArea REAL,
            $C_unit TEXT,
            $C_farmType TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> saveFarmData(FarmModel farm) async {
    final dbClient = await db;
    await dbClient.insert(
      Table_Farms,
      farm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Farm record inserted");
  }

  Future<List<FarmModel>> getAllFarms() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Farms);
    return List.generate(maps.length, (i) {
      return FarmModel.fromMap(maps[i]);
    });
  }

  Future<List<UserModel>> getAllUsers() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_User);
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }
  // Other methods remain unchanged...

  Future<void> closeDb() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}
