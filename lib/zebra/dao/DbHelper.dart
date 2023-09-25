import 'package:sheti_next/zebra/dao/models/UserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;

  //static Database? _database;

  static const String DB_Name = 'test.db'; //database name
  static const String Table_User = 'user'; // table name
  //final String tableName = 'products';
  static const int Version = 1; // version

  // column name for tables

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

/*
Future<Database?> get db async{
  if (_db!=null){
    return _db;
  }
  _db = await initDb();
  return _db;
}
*/

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

/*initDb() async{

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,DB_Name);

  var db= await openDatabase(path,version: Version,onCreate: _onCreate);
  return db;
}*/
  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), DB_Name);
    return await openDatabase(
      path,
      version: Version,
      onCreate: (db, version) {
        return db.execute(
          '''
      CREATE TABLE $Table_User (
      $C_UserID TEXT, 
      $C_UserName TEXT,
      $C_Email TEXT,
       $C_Password TEXT,
       PRIMARY KEY ($C_UserID)
      )
          ''',
        );
      },
    );
  }

  /* _onCreate( Database db,int intVersion) async{
  await db.execute("CREATE TABLE $Table_User ("
      " $C_UserID TEXT,"
      " $C_UserName TEXT,"
      " $C_Email TEXT,"
      " $C_UserID TEXT,"
      " $C_Password TEXT,"
      " PRIMARY KEY ($C_UserID)"
      ")");
}*/
/*Future<int?> saveData(UserModel user) async{
  var dbClient = await db;
  var res= await dbClient?.insert(Table_User, user.toMap());
  return res;
}*/
  /* Future<int?> saveData(UserModel user) async {
    final dbClient = await db;
    var res=
    await dbClient.insert(
      Table_User,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }*/
  Future<void> saveData(UserModel user) async {
    final dbClient = await db;
    await dbClient.insert(
      Table_User,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("record inserted");
  }

  Future<UserModel?> getLoginUser(String pin) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Password = '$pin'");
    if (res!.isNotEmpty) {
      return UserModel.fromMap(res!.first);
    }

    return null;
  }

  Future<List<UserModel>> getAllProducts() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_User);
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }

/*Future<int? > updateUser(UserModel user)async{
  var dbClient = await db;
  var res = await dbClient?.update(Table_User, user.toMap(),
    where: '$C_UserID = ?', whereArgs: [user.user_id]);
  return res;
}*/
  Future<int> updateUser(UserModel user) async {
    final dbClient = await db;
    var res = await dbClient.update(
      Table_User,
      user.toMap(),
      where: '$C_UserID = ?',
      whereArgs: [user.user_id],
    );
    return res;
  }

  /* Future<int?> updateUser(UserModel user) async {
    final dbClient = await db;
    var res =await dbClient?.update(
      Table_User,
      user.toMap(),
      where: '$C_UserID = ?',
      whereArgs: [user.user_id],
    );
    return res;
  }*/

/*Future<int?> deleteUser (String user_id) async{
  var dbClient =await db;
  var res = await dbClient?.delete(Table_User,where: '$C_UserID= ?',whereArgs: [user_id]);
  return res;
}*/
  Future<int?> deleteUser(String user_id) async {
    final dbClient = await db;
    var res = await dbClient.delete(
      Table_User,
      where: 'user_id = ?',
      whereArgs: [user_id],
    );
    return res;
  }

// latest code
}
