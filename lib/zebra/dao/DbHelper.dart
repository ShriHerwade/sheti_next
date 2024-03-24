//DbHelper.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sheti_next/zebra/dao/models/AccountModel.dart';
import 'package:sheti_next/zebra/dao/models/CropModel.dart';
import 'package:sheti_next/zebra/dao/models/CropMetaModel.dart';
import 'package:sheti_next/zebra/dao/models/CropWiseExpenseModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmWiseExpenseModel.dart';
import 'package:sheti_next/zebra/dao/models/TaskModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseBarChartModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpenseModel.dart';
import 'package:sheti_next/zebra/dao/models/ExpensePieChartModel.dart';
import 'package:sheti_next/zebra/dao/models/FarmModel.dart';
import 'package:sheti_next/zebra/dao/models/IncomeModel.dart';
import 'package:sheti_next/zebra/dao/models/ViewExpenseModel.dart';
import 'package:sheti_next/zebra/dao/models/PoeModel.dart';
import 'package:sheti_next/zebra/dao/models/SettingModel.dart';
import 'package:sheti_next/zebra/dao/models/UserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'models/DropDownMetaModel.dart'; //do not remove, required for nonKey db access
//import 'package:sqflite_sqlcipher/sqflite.dart';

class DbHelper {
  static Database? _db;
  static const String encryptionKey = 'llm-cpt3-3d4-e9f-6g2-h1i0'; // encryption key, need to move to secure storage


  static const String DB_Name = 'shetiNext.db';
  static const String Table_Account = 'account';
  static const String Table_Users = 'users';
  static const String Table_Farms = 'farms';
  static const String Table_Crops = 'crops';
  static const String Table_CropsMeta = 'cropsMeta';
  static const String Table_DropDownsMeta = 'dropDownsMeta';
  static const String Table_Poes = 'poes';

  static const String Table_Tasks = 'tasks';
  static const String Table_Expenses = 'expenses';
  static const String Table_ExpenseTypeMeta = 'expenseTypeMeta';
  static const String Table_ExpenseSubTypeMeta = 'expenseSubTypeMeta';
  static const String Table_Incomes = 'incomes';
  static const String Table_AppSettings = 'settings';

  static const String View_LatestExpenses = 'viewLatestExpenses';
  static const String View_ExpensesByFarm = 'viewExpenseByFarm';
  static const String View_ExpensesByCrop = 'viewExpenseByCrop';
  static const String View_ExpenseForPieChartByCrop = 'viewExpenseForPaiChartByCrop';

  static const int Version = 2;

  static const String C_accountId = 'accountId';
  static const String C_activationDate = 'activationDate';
  static const String C_activationType = 'activationType';
  static const String C_expirationDate = 'expirationDate';
  static const String C_platform = 'platform'; //android or ios
  static const String C_transactionId = 'transactionId'; //ios
  static const String C_transactionDate = 'transactionDate';
  static const String C_receipt = 'receipt'; // android
  static const String C_rawData = 'rawData'; // key hash
  static const String C_disableAccount = 'disableAccount'; // disable account

  static const String C_expectedIncome = 'expectedIncome';
  static const String C_expectedYield = 'expectedYield';
  static const String C_expectedYieldUnit = 'expectedYieldUnit';
  static const String C_totalYield = 'totalYield';
  static const String C_totalYieldUnit = 'totalYieldUnit';
  static const String C_totalIncome = 'totalIncome';
  static const String C_totalExpense = 'totalExpense';
  static const String C_cropLifeState = 'cropLifeState';
  static const String C_stateUpdatedDate = 'stateUpdatedDate';

  static const String C_userId = 'userId';
  static const String C_farmId = 'farmId';
  static const String C_cropId = 'cropId';
  static const String C_taskId = 'taskId';
  static const String C_expenseId = 'expenseId';
  static const String C_incomeId = 'incomeId';
  static const String C_poeId = 'poeId';

  static const String C_firstName = 'firstName';
  static const String C_lastName = 'lastName';
  static const String C_email = 'email';
  static const String C_mobileNo = 'mobileNo';
  static const String C_pin = 'pin';
  static const String C_isAccountOwner = 'isaccountOwner';
  static const String C_role = 'role';

  static const String C_farmName = 'farmName';
  static const String C_farmAddress = 'farmAddress';
  static const String C_farmArea = 'farmArea';
  static const String C_unit = 'unit';
  static const String C_farmType = 'farmType';
  static const String C_createdDate = 'createdDate';
  static const String C_isActive = 'isActive';
  static const String C_lastAccessedDate = 'lastAccessedDate';

  static const String C_latitude = 'latitude';
  static const String C_longitude = 'longitude';

  static const String C_cropName = 'cropName';
  static const String C_cropVariety = 'cropVariety';
  static const String C_area = 'area';
  static const String C_startDate = 'startDate';
  static const String C_endDate = 'endDate';
  static const String C_irrigationType = 'irrigationType';
  static const String C_soilType = 'soilType';

  static const String C_taskType = 'taskType';
  static const String C_notes = 'notes';
  static const String C_isDone = 'isDone';

  static const String C_expenseDate = 'expenseDate';
  static const String C_expenseType = 'expenseType';
  static const String C_isCredit = 'isCredit';
  static const String C_creditBy = 'creditBy';
  static const String C_splitBetween = 'splitBetween';
  static const String C_invoiceNumber = 'invoiceNumber';
  static const String C_invoiceFilePath = 'invoiceFilePath';
  static const String C_fileExtension = 'fileExtension';
  static const String C_amount = 'amount';
  static const String C_isFarmLevel = 'isFarmLevel'; // if expense is not for a specific crop

  static const String C_settingId = 'settingId';
  static const String C_key = 'key';
  static const String C_value = 'value';
  static const String C_profile = 'profile';

  static const String C_poeName = 'poeName';
  static const String C_isCreditor = 'isCreditor';
  static const String C_isShopFirm = 'isShopFirm';
  static const String C_isBuyer = 'isBuyer';
  static const String C_isServiceProvider = 'isServiceProvider';
  static const String C_isFarmWorker = 'isFarmWorker';
  static const String C_address = 'address';

  static const String C_quantity = 'quantity';
  static const String C_ratePerUnit = 'ratePerUnit';
  static const String C_rateUnit = 'rateUnit';
  static const String C_receiptNumber = 'receiptNumber';
  static const String C_receiptFilePath = 'receiptFilePath';
  static const String C_incomeType = 'incomeType';
  static const String C_incomeDate = 'incomeDate';
  static const String C_buyersName = 'buyersName';



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
      //password: encryptionKey,
      version: Version,
      onCreate: (db, version) async {
        try {
          db.execute(
            '''
          CREATE TABLE account (
            $C_accountId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_activationDate TEXT,
            $C_activationType INTEGER,
            $C_expirationDate TEXT,
            $C_platform TEXT NOT NULL,
            $C_transactionId TEXT,
            $C_receipt TEXT,
            $C_rawData TEXT,
            $C_disableAccount INTEGER NOT NULL DEFAULT 0,           
            $C_createdDate TEXT           
          )
          ''',
          );

          db.execute(
            '''
          CREATE TABLE $Table_Users (
            $C_userId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_accountId INTEGER,
            $C_firstName TEXT, 
            $C_lastName TEXT,
            $C_email TEXT UNIQUE ON CONFLICT ROLLBACK,
            $C_mobileNo TEXT UNIQUE ON CONFLICT ROLLBACK,
            $C_pin TEXT,
            $C_isAccountOwner INTEGER NOT NULL DEFAULT 0,
            $C_role TEXT,            
            $C_expirationDate TEXT,
            $C_lastAccessedDate TEXT,
            $C_isActive INTEGER NOT NULL DEFAULT 1,
            $C_createdDate TEXT,
            FOREIGN KEY ($C_accountId) REFERENCES $Table_Account ($C_accountId)
          )
          ''',
          );

          // Create farms table
          db.execute(
            '''
          CREATE TABLE $Table_Farms (
            $C_farmId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_accountId INTEGER,
            $C_farmName TEXT NOT NULL,
            $C_farmAddress TEXT,
            $C_farmArea REAL,
            $C_unit TEXT,
            $C_farmType TEXT,
            $C_irrigationType TEXT,
            $C_soilType TEXT,
            $C_latitude REAL,
            $C_longitude REAL,
            $C_isActive INTEGER NOT NULL DEFAULT 1,
            $C_createdDate TEXT,
             FOREIGN KEY ($C_accountId) REFERENCES $Table_Account ($C_accountId)
          )
          ''',
          );

          // Create crops table
          db.execute(
            '''
          CREATE TABLE $Table_Crops (
            $C_cropId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_farmId INTEGER NOT NULL,
            $C_cropName TEXT NOT NULL,
            $C_cropVariety TEXT,
            $C_farmName TEXT,
            $C_area REAL,
            $C_unit TEXT,
            $C_startDate TEXT,
            $C_endDate TEXT,
            $C_expectedIncome REAL,
            $C_expectedYield REAL,
            $C_expectedYieldUnit TEXT,
            $C_totalYield REAL,
            $C_totalYieldUnit TEXT,
            $C_totalIncome REAL,
            $C_totalExpense REAL,
            $C_cropLifeState TEXT NOT NULL,
            $C_stateUpdatedDate TEXT,
            $C_isActive INTEGER NOT NULL DEFAULT 1,
            $C_createdDate TEXT,
            FOREIGN KEY ($C_farmId) REFERENCES $Table_Farms ($C_farmId)
          )
          ''',
          );

          // Create cropsMeta table
          db.execute(
            '''
          CREATE TABLE $Table_CropsMeta (
            cropMetaId INTEGER PRIMARY KEY AUTOINCREMENT,
            en TEXT,
            mr TEXT,
            ka TEXT,
            hi TEXT,
            ta TEXT,
            te TEXT,
            ml TEXT,
            gu TEXT,
            pa TEXT,
            es TEXT,
            $C_isActive BOOLEAN,
            isCreatedByUser BOOLEAN DEFAULT 0,
            $C_createdDate DATETIME DEFAULT CURRENT_DATE
          );
          ''',
          );

          // Create cropsMeta table
          db.execute(
              '''
          CREATE TABLE $Table_DropDownsMeta (
              dropdownItemId INTEGER PRIMARY KEY AUTOINCREMENT,
              key TEXT,
              en TEXT,
              mr TEXT,
              ka TEXT,
              hi TEXT,
              ta TEXT,
              te TEXT,
              ml TEXT,
              gu TEXT,
              pa TEXT,
              es TEXT,
              category TEXT,
              displayOrder INTEGER,
              $C_isActive BOOLEAN,
              isCreatedByUser BOOLEAN DEFAULT 0,
              $C_createdDate DATETIME DEFAULT CURRENT_DATE
          );
          ''',
          );

          // Create Tasks table
          db.execute(
            '''
          CREATE TABLE $Table_Tasks (
            $C_taskId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_farmId INTEGER NOT NULL,
            $C_cropId INTEGER,
            $C_userId INTEGER NOT NULL,
            $C_taskType TEXT,
            $C_notes TEXT,
            $C_startDate TEXT,
            $C_endDate TEXT,            
            $C_isActive INTEGER NOT NULL DEFAULT 1,
            $C_isDone INTEGER NOT NULL DEFAULT 1,
            $C_createdDate TEXT,
            FOREIGN KEY ($C_farmId) REFERENCES $Table_Farms ($C_farmId),
            FOREIGN KEY ($C_cropId) REFERENCES $Table_Crops ($C_cropId),
            FOREIGN KEY ($C_userId) REFERENCES $Table_Users ($C_userId)
          )
          ''',
          );

          // Create Expenses table
          db.execute(
            '''
          CREATE TABLE $Table_Expenses (
            $C_expenseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_farmId INTEGER NOT NULL,
            $C_cropId INTEGER,
            $C_userId INTEGER NOT NULL,
            $C_isFarmLevel INTEGER NOT NULL DEFAULT 0,
            $C_expenseType TEXT,
            $C_expenseDate TEXT,
            $C_amount INTEGER NOT NULL DEFAULT 0,
            $C_invoiceNumber TEXT,
            $C_invoiceFilePath TEXT,
            $C_fileExtension TEXT,
            $C_isCredit INTEGER NOT NULL DEFAULT 0,
            $C_poeId INTEGER,
            $C_splitBetween INTEGER NOT NULL DEFAULT 0,           
            $C_notes TEXT,
            $C_isActive INTEGER,            
            $C_createdDate TEXT,
            FOREIGN KEY ($C_farmId) REFERENCES $Table_Farms ($C_farmId),
            FOREIGN KEY ($C_cropId) REFERENCES $Table_Crops ($C_cropId),
            FOREIGN KEY ($C_userId) REFERENCES $Table_Users ($C_userId),
            FOREIGN KEY ($C_poeId) REFERENCES $Table_Poes ($C_poeId) ON DELETE NO ACTION

          )
          ''',
          );

          // Create Income table
          db.execute(
            '''
          CREATE TABLE $Table_Incomes (
            $C_incomeId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $C_farmId INTEGER NOT NULL,
            $C_cropId INTEGER,
            $C_userId INTEGER NOT NULL,            
            $C_incomeType TEXT,
            $C_quantity REAL,
            $C_unit TEXT,
            $C_ratePerUnit REAL,
            $C_rateUnit TEXT,           
            $C_amount INTEGER NOT NULL DEFAULT 0,
            $C_buyersName TEXT,
            $C_incomeDate TEXT,
            $C_receiptNumber TEXT,
            $C_receiptFilePath TEXT,
            $C_fileExtension TEXT,                       
            $C_notes TEXT,
            $C_isActive INTEGER,
            $C_createdDate TEXT,
            FOREIGN KEY ($C_farmId) REFERENCES $Table_Farms ($C_farmId),
            FOREIGN KEY ($C_cropId) REFERENCES $Table_Crops ($C_cropId),
            FOREIGN KEY ($C_userId) REFERENCES $Table_Users ($C_userId)          

          )
          ''',
          );
          // Create AppSetting table
          db.execute(
            '''
          CREATE TABLE $Table_AppSettings (
            $C_settingId INTEGER PRIMARY KEY AUTOINCREMENT,          
            $C_key TEXT,
            $C_value TEXT,
            $C_profile TEXT,
            $C_isActive INTEGER NOT NULL DEFAULT 1 ,                 
            $C_createdDate TEXT                 
          )
          ''',
          );

          // Create poes table
          db.execute(
            '''
          CREATE TABLE $Table_Poes (
            $C_poeId INTEGER PRIMARY KEY AUTOINCREMENT,          
            $C_accountId INTEGER,
            $C_poeName TEXT,
            $C_mobileNo TEXT,
            $C_email TEXT ,
            $C_address TEXT , 
            $C_isCreditor INTEGER NOT NULL DEFAULT 1 ,
            $C_isBuyer INTEGER NOT NULL DEFAULT 0 ,
            $C_isShopFirm INTEGER NOT NULL DEFAULT 0 ,
            $C_isServiceProvider INTEGER NOT NULL DEFAULT 0 ,
            $C_isFarmWorker INTEGER NOT NULL DEFAULT 0 ,
            $C_isActive INTEGER NOT NULL DEFAULT 1 ,                  
            $C_createdDate TEXT,
            FOREIGN KEY ($C_accountId) REFERENCES $Table_Account ($C_accountId)                 
          )
          ''',
          );

          // Create the LatestExpenseView
          db.execute('''
      CREATE VIEW IF NOT EXISTS $View_LatestExpenses AS
      SELECT
          f.$C_farmId,
          f.$C_farmName,
          c.$C_cropId,
          c.$C_cropName,
          e.$C_expenseId,
          e.$C_expenseType,
          e.$C_expenseDate,
          e.$C_amount
      FROM
          $Table_Farms f
      JOIN $Table_Crops c ON f.$C_farmId = c.$C_farmId
      JOIN $Table_Expenses e ON c.$C_cropId = e.$C_cropId
      WHERE
          e.$C_isActive = 1
      ORDER BY
          e.$C_expenseDate DESC;
        ''');


          // Create the ExpensesByFarm
          db.execute('''
      CREATE VIEW IF NOT EXISTS $View_ExpensesByFarm AS
      SELECT
          f.$C_farmId,
          f.$C_farmName,
          c.$C_cropId,
          c.$C_cropName,
          e.$C_expenseId,
          e.$C_expenseType,
          e.$C_expenseDate,
          e.$C_amount
      FROM
          $Table_Farms f
      JOIN $Table_Crops c ON f.$C_farmId = c.$C_farmId
      JOIN $Table_Expenses e ON c.$C_cropId = e.$C_cropId
      WHERE
          e.$C_isActive = 1
      GROUP BY
          f.$C_farmId, c.$C_cropId
      ORDER BY
          e.$C_expenseDate DESC;
        ''');

          // Create the ExpensesByCrop
          db.execute('''
      CREATE VIEW IF NOT EXISTS $View_ExpensesByCrop AS
      SELECT
          c.$C_cropId,
          c.$C_cropName,
          e.$C_expenseId,
          e.$C_expenseType,
          e.$C_expenseDate,
          e.$C_amount
      FROM
          $Table_Crops c
      JOIN $Table_Expenses e ON c.$C_cropId = e.$C_cropId
      WHERE
          e.$C_isActive = 1
      GROUP BY
          c.$C_cropId
      ORDER BY
          e.$C_expenseDate DESC;
        ''');

          // Create the PieChartByCropExpense
          db.execute('''
      CREATE VIEW IF NOT EXISTS $View_ExpenseForPieChartByCrop AS
      SELECT
          c.$C_cropName AS crop_name,
          c.$C_farmName AS farm_name,
          SUM(e.$C_amount) AS total_amount_spent
      FROM
          $Table_Farms f
      JOIN $Table_Crops c ON f.$C_farmId = c.$C_farmId
      JOIN $Table_Expenses e ON c.$C_cropId = e.$C_cropId
      WHERE
          e.$C_isActive = 1
      GROUP BY
          c.$C_cropId
      ORDER BY
          total_amount_spent DESC;
        ''');

          //await _handleInsertInitialMetaData(db);
            await _initMetadata(db);
        } catch (e) {
          print('Error creating tables: $e');
        }
      },
    );
  }

 //do not change the wrapper method calls as it will, go in infinite loop
   Future<void> _initMetadata(Database db) async {
    try {
      SettingModel? setting = await getSetting(db, "metaDataLoaded");

      if (setting != null) {
        //metadata are already initialized
        print('Metadata is already initialized.');
        print('Setting found: ${setting.key} - ${setting.value}');

        //for future use
        /* if (setting.value.toLowerCase() == 'true') {
              // The setting is present, and the value is "true"
            } else if (setting.value.toLowerCase() == 'false') {
              // The setting is present, and the value is "false"
            } else {
              // The value is neither "true" nor "false"
            }*/
      } else {
        print('Metadata is not initialized prior, initializing now ...');
        _handleInsertInitialMetaData(db);
      }
    } catch (ex) {
      print('Error while pulling Settings or initializing metadata : $ex');
    }
  }

  Future<void> _handleInsertInitialMetaData(Database db) async {
    await insertInitialMetaData(db);
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

  Future<void> saveCropData(CropModel crop) async {
    final dbClient = await db;
    await dbClient.insert(
      Table_Crops,
      crop.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Crop record inserted");
  }

  Future<List<AccountModel>> getAccountList() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient
        .query(Table_Account, where: 'disableAccount = ? ', whereArgs: [0]);
    return List.generate(maps.length, (i) {
      return AccountModel.fromMap(maps[i]);
    });
  }

  Future<AccountModel?> getActiveAccount() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(
      Table_Account,
      where: 'disableAccount = ?',
      whereArgs: [0],
      limit: 1,
    );
    print('active accounts : ' + result.length.toString());
    return result.isNotEmpty ? AccountModel.fromMap(result.first) : null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Users);
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }

  Future<List<FarmModel>> getAllFarms() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Farms,
        where: 'isActive = ? AND isActive IS NOT NULL',
        whereArgs: [1],
        orderBy: 'createdDate DESC');
    return List.generate(maps.length, (i) {
      return FarmModel.fromMap(maps[i]);
    });
  }

  Future<List<CropModel>> getAllCrops() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Crops,
        where: 'isActive = ? AND isActive IS NOT NULL',
        whereArgs: [1],
        orderBy: 'createdDate DESC');
    return List.generate(maps.length, (i) {
      return CropModel.fromMap(maps[i]);
    });
  }

  Future<List<CropModel>> getCropsByFarmId(int farmId) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Crops,
        where: 'isActive = ? AND farmId = ? AND isActive IS NOT NULL',
        whereArgs: [1, farmId],
        orderBy: 'createdDate DESC');
    return List.generate(maps.length, (i) {
      return CropModel.fromMap(maps[i]);
    });
  }

  Future<List<PoeModel>> getAllPoe() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Poes,
        where: 'isActive = ? AND isActive IS NOT NULL',
        whereArgs: [1],
        orderBy: 'createdDate DESC');
    return List.generate(maps.length, (i) {
      return PoeModel.fromMap(maps[i]);
    });
  }

  Future<List<TaskModel>> getAllTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(Table_Tasks,
        where: 'isActive = ? AND isActive IS NOT NULL',
        whereArgs: [1],
        orderBy: 'createdDate DESC');
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  Future<List<TaskModel>> getTasksByCropId(int cropId) async {
    final dbClient = await db;
    try {
    final List<Map<String, dynamic>> maps = await dbClient.query(
      Table_Tasks,
      where: 'isActive = ? AND isActive IS NOT NULL AND cropId = ?', // Add condition for cropId
      whereArgs: [1, cropId], // Pass cropId as a whereArg
      orderBy: 'createdDate DESC',
    );
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
    }catch(e){
      print("Error while pulling task data : $e");
      rethrow;
    }
  }

  Future<List<ExpenseModel>> getExpenseByCropId(int cropId) async {
    final dbClient = await db;
    try {
      final List<Map<String, dynamic>> maps = await dbClient.query(
        Table_Expenses,
        where: 'isActive = ? AND isActive IS NOT NULL AND cropId = ?',
        // Add condition for cropId
        whereArgs: [1, cropId],
        // Pass cropId as a whereArg
        orderBy: 'createdDate DESC',
      );
      return List.generate(maps.length, (i) {
        return ExpenseModel.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error while pulling Expense data : $e");
      rethrow;
    }
  }

  Future<List<ExpenseModel>> getAllExpense() async {
    final dbClient = await db;
    try {
      final List<Map<String, dynamic>> maps = await dbClient.query(
          Table_Expenses,
          where: 'isActive = ? AND isActive IS NOT NULL',
          whereArgs: [1],
          orderBy: 'createdDate DESC');
      return List.generate(maps.length, (i) {
        return ExpenseModel.fromMap(maps[i]);
      });
    }catch(e){
      print("Error while saving expense data : $e");
      rethrow;
    }
  }

  //return all settings
  Future<List<SettingModel>> getAllSettings() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(
        Table_AppSettings,
        where: 'isActive = ? AND isActive IS NOT NULL',
        whereArgs: [1],
        orderBy: 'createdDate DESC');
    return List.generate(maps.length, (i) {
      return SettingModel.fromMap(maps[i]);
    });
  }

  //return only the required setting
  Future<SettingModel?> getSetting(Database db, String key) async {
    try {
      // final dbClient = await db;
      final List<Map<String, dynamic>> result = await db.query(
          Table_AppSettings,
          where: 'isActive = ? AND key = ? AND isActive IS NOT NULL',
          whereArgs: [1, key]);
      return result.isNotEmpty ? SettingModel.fromMap(result.first) : null;
    } catch (e) {
      print("Error while pulling settings metadata  : $e");
      rethrow;
    }
  }

// Add this method is used to save data of user
  Future<void> saveUserData(UserModel user) async {
    final dbClient = await db;
    await dbClient.insert(
      Table_Users,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("User record inserted");
  }

// method to save Task
  Future<void> saveTaskData(TaskModel task) async {
    final dbClient = await db;
    await dbClient.insert(
      Table_Tasks,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Task record inserted");
  }

// method to save expense data
  Future<void> saveExpenseData(ExpenseModel expense) async {
    final dbClient = await db;
    try{
    await dbClient.insert(
      Table_Expenses,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );}catch(e){
      print("Error while saving expense data : $e");
      rethrow;
    }
    print("Expenses record inserted");
  }

  Future<void> saveIncomeData(IncomeModel income) async {
    final dbClient = await db;
    try{
      await dbClient.insert(
        Table_Incomes,
        income.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );}catch(e){
      print("Error while saving income data : $e");
      rethrow;
    }
    print("Income record inserted");
  }


  Future<void> savePoeData(PoeModel poe) async {
    final dbClient = await db;
    try{
      await dbClient.insert(
        Table_Poes,
        poe.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );}catch(e){
      print("Error while saving poe data : $e");
      rethrow;
    }
    print("Poe record inserted");
  }

  Future<void> insertInitialMetaData(Database db) async {
    try {
      //1. Read JSON data from account file
      String accountMetaFilePath =
          'assets/metadataFiles/account_initialization.json';
      String accountMetaJsonString =
          await rootBundle.loadString(accountMetaFilePath);
      print(accountMetaJsonString);
      var accountMetadata = json.decode(accountMetaJsonString);

      // Parse JSON data AccountModel
      AccountModel account = AccountModel.fromJson(accountMetadata);
      print("Account object initialized !");

      //2. Read JSON data from user file -- this is dummy data remove once ready
      String userMetaFilePath =
          'assets/metadataFiles/dummyUser_initialization.json';
      String userMetaJsonString = await rootBundle.loadString(userMetaFilePath);
      print("Load : userMetaJsonString");
      var userMetadata = json.decode(userMetaJsonString);
      print("create userMetadata");
      UserModel user = UserModel.fromJson(userMetadata);

      print("User object initialized !");

      //3. Read JSON data from cropsMeta file
      String cropsMetaFilePath =
          'assets/metadataFiles/crops_initialization.json';
      String cropsMetaJsonString =
          await rootBundle.loadString(cropsMetaFilePath);
      print("Load : cropsMetaJsonString");
      var cropsMetaJsonList = json.decode(cropsMetaJsonString) as List<dynamic>;
      print("CropMetadata list  initialized !");

      //4. Read JSON data from cropsMeta file
      String ddMetaFilePath =
          'assets/metadataFiles/dropDownMeta_initialization.json';
      String ddMetaJsonString = await rootBundle.loadString(ddMetaFilePath);
      var ddMetaJsonList = json.decode(ddMetaJsonString) as List<dynamic>;
      print("dropDown meta object initialized!");

      //5. Read JSON data from settings file
      String settingsMetaFilePath =
          'assets/metadataFiles/settings_initialization.json';
      String settingsMetaJsonString =
          await rootBundle.loadString(settingsMetaFilePath);
      print("Load : settingsMetaJsonString");
      var settingsJsonList =
          json.decode(settingsMetaJsonString) as List<dynamic>;
      print("Settings object initialized.. saving account !");

      // Insert the data into the accounts
      await db.insert(Table_Account, account.toMap());
      print("Account record saved... saving UserDummy");
      await db.insert(Table_Users, user.toMap());
      print("Dummy User record saved.");

      // Iterate through the JSON list and insert each cropMeta into the cropMeta
      /* int i = 0;
      int j = 0;*/
      for (var jsonData in cropsMetaJsonList) {
        /*i = i + 1;
        print("CropMeta adding " + i.toString());
        print("Setttings JSON Object: $jsonData");*/ //uncomment only while debugging
        await saveCropsMetaData(CropMetaModel.fromJson(jsonData));
      }
      print("CropMetadata records saved.");

      for (var jsonData in ddMetaJsonList) {
        await saveDdMetaData(DropDownMetaModel.fromJson(jsonData));
      }
      print("DropDownMeta records saved.");

      // Iterate through the JSON list and insert each setting into the settings
      for (var jsonData in settingsJsonList) {
        /*j = j + 1;
        print("Settings adding " + j.toString());
        print("Crop JSON Object: $jsonData");*/ //uncomment only while debugging
        await saveSettingData(SettingModel.fromJson(jsonData));
      }
      print("Settings records saved.");
    } catch (e) {
      print("Error while initialization of data from JSON: $e");
      rethrow;
    }
  }

  Future<int> saveCropsMetaData(CropMetaModel cropsMeta) async {
    final dbClient = await db;
    int res = await dbClient.insert(Table_CropsMeta, cropsMeta.toMap());
    return res;
  }

  Future<int> saveDdMetaData(DropDownMetaModel ddMeta) async {
    final dbClient = await db;
    int res = await dbClient.insert(Table_DropDownsMeta, ddMeta.toMap());
    return res;
  }

  Future<int> saveSettingData(SettingModel setting) async {
    final dbClient = await db;
    int res = await dbClient.insert(Table_AppSettings, setting.toMap());
    return res;
  }

  Future<List<ViewExpenseModel>> getLatestExpenses() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result =
        await dbClient.rawQuery('SELECT * FROM $View_LatestExpenses');

    return result
        .map((item) => ViewExpenseModel(
              farmId: item['farmId'],
              farmName: item['farmName'],
              cropId: item['cropId'],
              cropName: item['cropName'],
              expenseId: item['expenseId'],
              expenseType: item['expenseType'],
              expenseDate: DateTime.parse(item['expenseDate']),
              amount: item['amount'].toDouble(),
            ))
        .toList();
  }

  Future<List<ViewExpenseModel>> getExpenseByFarm() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result =
    await dbClient.rawQuery('SELECT * FROM $View_ExpensesByFarm');

    return result
        .map((item) => ViewExpenseModel(
      farmId: item['farmId'],
      farmName: item['farmName'],
      cropId: item['cropId'],
      cropName: item['cropName'],
      expenseId: item['expenseId'],
      expenseType: item['expenseType'],
      expenseDate: DateTime.parse(item['expenseDate']),
      amount: item['amount'].toDouble(),
    ))
        .toList();
  }

  Future<List<ViewExpenseModel>> getExpenseByCrop() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result =
    await dbClient.rawQuery('SELECT * FROM $View_ExpensesByCrop');

    return result
        .map((item) => ViewExpenseModel(
      farmId: item['farmId'],
      farmName: item['farmName'],
      cropId: item['cropId'],
      cropName: item['cropName'],
      expenseId: item['expenseId'],
      expenseType: item['expenseType'],
      expenseDate: DateTime.parse(item['expenseDate']),
      amount: item['amount'].toDouble(),
    ))
        .toList();
  }

  Future<List<ExpenseBarChartModel>> getExpenseForBarChartByYear(Database db, int year) async {
    List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT
          strftime('%B', e.$C_expenseDate) AS month_name,
          SUM(e.$C_amount) AS total_amount
      FROM
          $Table_Farms f
      JOIN $Table_Crops c ON f.$C_farmId = c.$C_farmId
      JOIN $Table_Expenses e ON c.$C_cropId = e.$C_cropId
      WHERE
          e.$C_isActive = 1
          AND strftime('%Y', e.$C_expenseDate) = ?
      GROUP BY
          month_name
      ORDER BY
          strftime('%m', e.$C_expenseDate) ASC;
    ''', [year.toString()]);

    return result.map((item) {
      return ExpenseBarChartModel(
        monthName: item['month_name'],
        totalAmount: item['total_amount'].toDouble(),
      );
    }).toList();
  }

  Future<List<ExpensePieChartModel>> getExpenseForPieChartByCrop() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.rawQuery('''
    SELECT
        crop_name,
        farm_name,
        total_amount_spent
    FROM
        $View_ExpenseForPieChartByCrop
  ''');

    return result.map((item) {
      return ExpensePieChartModel(
        cropName: item['crop_name'],
        farmName: item['farm_name'],
        totalAmountSpent: item['total_amount_spent'].toDouble(),
      );
    }).toList();
  }

  static Future<List<ViewExpenseModel>> getExpensesTillPastDate(Database db, String pastDateString) async {
    DateTime pastDate = DateTime.parse(pastDateString);
    List<Map<String, dynamic>> results = await db.rawQuery('''
        SELECT
            f.$C_farmId,
            f.$C_farmName,
            c.$C_cropId,
            c.$C_cropName,
            e.$C_expenseId,
            e.$C_expenseType,
            e.$C_expenseDate,
            e.$C_amount
        FROM
            $Table_Farms f
        JOIN $Table_Crops c ON f.$C_farmId = c.$C_farmId
        JOIN $Table_Expenses e ON c.$C_cropId = e.$C_cropId
        WHERE
            e.$C_isActive = 1
            AND e.$C_expenseDate >= ?
        ORDER BY
            e.$C_expenseDate DESC;
          ''', [pastDate.millisecondsSinceEpoch]);

    List<ViewExpenseModel> expenseModels = results.map((map) {
      return ViewExpenseModel(
        farmId: map[C_farmId],
        farmName: map[C_farmName],
        cropId: map[C_cropId],
        cropName: map[C_cropName],
        expenseId: map[C_expenseId],
        expenseType: map[C_expenseType],
        expenseDate: DateTime.fromMillisecondsSinceEpoch(map[C_expenseDate]),
        amount: map[C_amount],
      );
    }).toList();

    return expenseModels;
  }


  Future<List<String>> getCropNamesByLanguage(String languageCode) async {
    print('loading cropNames by LanguageCode');
    Database database = await db;
    try {
      // Get crop names for the specified language code
      List<Map<String, dynamic>> result =
          await database.rawQuery('SELECT $languageCode FROM cropsMeta');

      // Extract crop names from the result
      List<String> cropNames =
          result.map((row) => row[languageCode]?.toString() ?? '').toList();

      return cropNames;
    } catch (e) {
      print('SQLite error while pulling cropNames : $e');
      return [];
    }
  }

  Future<List<FarmWiseExpenseModel>> getFarmWiseExpenseData() async {
    List<FarmWiseExpenseModel> farmExpenseList = [];
    final Database database = await db;

    List<Map<String, dynamic>> farmData = await database.rawQuery('''
    SELECT $C_farmName, $C_cropName, * FROM $Table_Expenses
    INNER JOIN $Table_Crops ON $Table_Expenses.$C_cropId = $Table_Crops.$C_cropId
  ''');

    for (var data in farmData) {
      String farmName = data[C_farmName];
      String cropName = data[C_cropName];
      ExpenseModel expense = ExpenseModel.fromMap(data);

      bool farmExists = farmExpenseList.any((farm) => farm.farmName == farmName);
      if (farmExists) {
        int index = farmExpenseList.indexWhere((farm) => farm.farmName == farmName);
        if (farmExpenseList[index].cropExpensesMap.containsKey(cropName)) {
          farmExpenseList[index].cropExpensesMap[cropName]!.add(expense);
        } else {
          farmExpenseList[index].cropExpensesMap[cropName] = [expense];
        }
      } else {
        farmExpenseList.add(FarmWiseExpenseModel(farmName: farmName, cropExpensesMap: {cropName: [expense]}));
      }
    }
    return farmExpenseList;
  }

  Future<List<CropWiseExpenseModel>> getCropWiseExpenseData() async {
    List<CropWiseExpenseModel> cropExpenseList = [];
    final Database database = await db;
    List<Map<String, dynamic>> cropData = await database.rawQuery('''
    SELECT $C_cropName, $C_farmName, * FROM $Table_Expenses
    INNER JOIN $Table_Crops ON $Table_Expenses.$C_cropId = $Table_Crops.$C_cropId
  ''');

    for (var data in cropData) {
      String cropName = data[C_cropName];
      String farmName = data[C_farmName];
      ExpenseModel expense = ExpenseModel.fromMap(data);

      bool cropExists = cropExpenseList.any((crop) => crop.cropName == cropName);
      if (cropExists) {
        int index = cropExpenseList.indexWhere((crop) => crop.cropName == cropName);
        cropExpenseList[index].expenses.add(expense);
      } else {
        cropExpenseList.add(CropWiseExpenseModel(cropName: cropName, expenses: [expense]));
      }
    }
    return cropExpenseList;
  }


  Future<void> closeDb() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  updateFarmData(FarmModel updatedFarm) {}


}
