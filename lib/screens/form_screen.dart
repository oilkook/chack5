import 'package:checkpoint5/main.dart';
import 'package:checkpoint5/models/Transactions.dart';
import 'package:checkpoint5/providers/transaction_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  double padding = 8;
  // controller
  final titleController = TextEditingController(); //รับค่าชื่อ
  final lastnameController = TextEditingController(); //รับค่านามสกุล
  final addressController = TextEditingController(); //รับค่าที่อยู่
  final phoneController = TextEditingController(); //รับค่าเบอร์
  final amountController = TextEditingController(); //รับตัวเลข
  final emailController = TextEditingController(); //รับเมลล์
  final passwordController = TextEditingController(); //รับรหัส
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "First Name"),
                  autofocus: false,
                  controller: titleController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "first name plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Last name"),
                  autofocus: false,
                  controller: lastnameController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "last name plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Address"),
                  autofocus: false,
                  controller: addressController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "address plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "phone";
                    }
                    if (double.parse(str) <= 0) {
                      return "เบอร์โทรศัพท์";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Email"),
                  autofocus: false,
                  controller: emailController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Email plase";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "Password"),
                  autofocus: false,
                  controller: passwordController,
                  validator: (String str) {
                    //ชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "Password plase";
                    }
                    return null;
                  },
                ),
                Column(
                  children: [
                    ElevatedButton(
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onSurface: Colors.red,
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          var title = titleController.text.trim();
                          var lastname = lastnameController.text.trim();
                          var address = addressController.text.trim();
                          var amount = amountController.text.trim();
                          var email = emailController.text.trim();
                          var password = passwordController.text.trim();
                          //เตรียมข้อมูล
                          Transactions statement = Transactions(
                              title: title,
                              lastname: lastname,
                              address: address,
                              amount: double.parse(amount),
                              email: email,
                              password: password,
                              date: DateTime.now()); //object

                          //เรียก Provider
                          var provider = Provider.of<TransactionProvider>(
                              context,
                              listen: false);
                          provider.addTransaction(statement);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return MyHomePage();
                                  }));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
