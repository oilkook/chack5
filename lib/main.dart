import 'package:checkpoint5/providers/transaction_providers.dart';
import 'package:checkpoint5/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'ลงทะเบียน'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.green,
        body: TabBarView(
          children: [HomeScreen(), FormScreen()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.list_alt),
              text: "List",
            ),
            Tab(icon: Icon(Icons.add_box), text: "Add")
          ],
        ),
      ),
    );
  }
}
