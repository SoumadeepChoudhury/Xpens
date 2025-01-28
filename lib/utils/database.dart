import 'package:sqflite/sqflite.dart';
import 'package:xpens/utils/functions.dart';
import 'package:xpens/utils/transaction_model.dart';
import 'package:xpens/variables.dart';
import 'package:xpens/utils/card_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $accountTableName (
        $accountTableCardNoColumnName TEXT PRIMARY KEY,
        $accountTableAccountColumnName TEXT NOT NULL,
        $accountTableBalanceColumnName REAL NOT NULL,
        $accountTableisPrimaryColumnName TEXT
      )
''');
      },
    );
    return database;
  }

  void addNewAccount(String cardNo, String accountName, double balance,
      {String isPrimary = "No"}) async {
    final db = await database;
    await db.insert(accountTableName, {
      accountTableCardNoColumnName: cardNo,
      accountTableAccountColumnName: accountName,
      accountTableBalanceColumnName: balance,
      accountTableisPrimaryColumnName: isPrimary
    });
    createTransactionTable(getTransactionTableName(cardNo, accountName));
  }

  //Fetch the existing accounts
  Future<List<AccountCard>> fetchAccounts() async {
    final db = await database;
    final data = await db.query(accountTableName);
    List<AccountCard> cards = data
        .map((item) => AccountCard(
            cardNo: item['card_no'] as String,
            title: item['account'] as String,
            balance: item['balance'] as double,
            isPrimary: item['isPrimary'] as String))
        .toList();
    return cards;
  }

  //Delete account
  void deleteAccount(String card_no) async {
    final db = await database;
    db.delete(accountTableName,
        where: '$accountTableCardNoColumnName = ?',
        whereArgs: [
          card_no,
        ]);
  }

  //Change Primary account [Updation]
  void updatePrimaryAccount(
      String oldPrimaryCardNo, String newPrimaryCardNo) async {
    final db = await database;
    String query = '''
      UPDATE $accountTableName
      SET 
        $accountTableisPrimaryColumnName = CASE 
            WHEN $accountTableCardNoColumnName = ? THEN '' 
            WHEN $accountTableCardNoColumnName = ? THEN 'Yes' 
            ELSE $accountTableisPrimaryColumnName 
        END
      WHERE 
        $accountTableCardNoColumnName IN (?, ?);
    ''';

    await db.rawUpdate(query, [
      oldPrimaryCardNo,
      newPrimaryCardNo,
      oldPrimaryCardNo,
      newPrimaryCardNo
    ]);
  }

  //Update balance value in the account
  void updateBalance(String cardNo, double newBalance) async {
    final db = await database;
    await db.update(
        accountTableName, {accountTableBalanceColumnName: newBalance},
        where: "$accountTableCardNoColumnName = ?",
        whereArgs: [
          cardNo,
        ]);
  }

  //Create transaction table
  void createTransactionTable(String tableName) async {
    final db = await database;
    tableName = tableName.replaceAll("-", "_");
    db.execute('''
  CREATE TABLE $tableName(
    $transactionTableSlNoColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
    $transactionTableDateColumnName TEXT NOT NULL,
    $transactionTableCardNoColumnName TEXT NOT NULL,
    $transactionTableTitleColumnName TEXT NOT NULL,
    $transactionTableCategoryColumnName TEXT NOT NULL,
    $transactionTableModeColumnName TEXT NOT NULL,
    $transactionTableAmountColumnName REAL NOT NULL
  )
''');
  }

  //Enter New transaction
  void addNewTransaction(String tableName,
      {required String date,
      required String cardNo,
      required String title,
      required String category,
      required String mode,
      required double amount}) async {
    final db = await database;
    tableName = tableName.replaceAll("-", "_");
    db.insert(tableName, {
      transactionTableDateColumnName: date,
      transactionTableCardNoColumnName: cardNo,
      transactionTableTitleColumnName: title,
      transactionTableCategoryColumnName: category,
      transactionTableModeColumnName: mode,
      transactionTableAmountColumnName: amount
    });
  }

  //Read the Transaction
  Future<List<AccountTransaction>> fetchTransactions(
      String tableName, String cardNo) async {
    final db = await database;
    tableName = tableName.replaceAll("-", "_");
    final data = await db.query(tableName,
        where: '$transactionTableCardNoColumnName = ?',
        whereArgs: [
          cardNo,
        ]);
    List<AccountTransaction> transactions = data
        .map((item) => AccountTransaction(
            date: item[transactionTableDateColumnName] as String,
            title: item[transactionTableTitleColumnName] as String,
            category: item[transactionTableCategoryColumnName] as String,
            amount: item[transactionTableAmountColumnName] as double,
            isReceived: item[transactionTableModeColumnName] == "Received"
                ? true
                : false))
        .toList();
    return transactions;
  }

  Future<List<AccountTransaction>> getSpecificTransactions(
      String tableName, String fieldValue) async {
    final db = await database;
    tableName = tableName.replaceAll("-", "_");
    final data = await db.query(tableName,
        where: '$transactionTableCategoryColumnName = ?',
        whereArgs: [
          fieldValue,
        ]);
    List<AccountTransaction> transactions = data
        .map((item) => AccountTransaction(
            date: item[transactionTableDateColumnName] as String,
            title: item[transactionTableTitleColumnName] as String,
            category: item[transactionTableCategoryColumnName] as String,
            amount: item[transactionTableAmountColumnName] as double,
            isReceived: item[transactionTableModeColumnName] == "Received"
                ? true
                : false))
        .toList();
    return transactions;
  }

  void deleteTransactionTable(String tableName) async {
    final db = await database;
    tableName = tableName.replaceAll("-", "_");
    db.delete(tableName);
  }
}
