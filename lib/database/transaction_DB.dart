import 'dart:io';

import 'package:checkpoint5/models/Transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  //บริการเกียวกับฐานข้อมูล
  String dbnames;

  TransactionDB({this.dbnames});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbnames);
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Expense");

    var keyID = store.add(db, {
      "title": statement.title,
      "lastname": statement.lastname,
      "address": statement.address,
      "amount": statement.amount,
      "email": statement.email,
      "password": statement.password,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  Future removeUser(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    print(statement.email);
    final finder = Finder(filter: Filter.equals('email', statement.email));
    print(finder);
    final res = await store.delete(db, finder: finder);
    print(res);
    db.close();
  }

  //ดึงข้อมูล
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List transactionList = List<Transactions>();
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"],
          lastname: record["lastname"],
          address: record["address"],
          amount: record["amount"],
          email: record["email"],
          password: record["password"],
          date: DateTime.parse(record["aate"])));
    }
    return transactionList;
  }
}
