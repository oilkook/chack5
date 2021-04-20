import 'package:checkpoint5/database/transaction_DB.dart';
import 'package:checkpoint5/models/Transactions.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  // ตัวอย่างข้อมูล
  List<Transactions> transactions = [];

  // ดึงข้อมูล
  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbnames: "transactions.db");
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbnames: "transactions.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    //แจ้งเตือน Consumer
    notifyListeners();
  }

  removeTransaction(Transactions statement) async {
    var db = TransactionDB(dbnames: "transactions.db");
    await db.removeUser(statement);
    notifyListeners();
  }
}
