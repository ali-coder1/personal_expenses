import 'package:flutter/material.dart';

import 'package:expenses_managements/models/transaction.dart';
import 'package:expenses_managements/widgets/chart.dart';
import 'package:expenses_managements/widgets/transaction_add.dart';
import 'package:expenses_managements/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Transaction> _userTransactions = [
    Transaction(
        id: 'tran1',
        title: 'Black Shoes',
        amount: 80.99,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: 'tran2',
        title: 'White Shoes',
        amount: 100.99,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 'tran3',
        title: 'Yallow Shoes',
        amount: 1.99,
        date: DateTime.now().subtract(Duration(days: 7))),
    Transaction(
        id: 'tran4',
        title: 'Green Shoes',
        amount: 62.99,
        date: DateTime.now().subtract(Duration(days: 13))),
    Transaction(
        id: 'tran5', title: 'Brown Shoes', amount: 0.99, date: DateTime.now()),
    Transaction(
        id: 'tran6', title: 'Red Shoes', amount: 54.99, date: DateTime.now()),
    Transaction(
        id: 'tran7', title: 'Blue Shoes', amount: 38.99, date: DateTime.now()),
    Transaction(
        id: 'tran8',
        title: 'Grey Shoes',
        amount: 44.99,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: 'tran9',
        title: 'Blue Shoes',
        amount: 15.99,
        date: DateTime.now().subtract(Duration(days: 20))),
    Transaction(
        id: 'tran10', title: 'Sky Shoes', amount: 7.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.insert(0, newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTx(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: TransactionAdd(
                scaffoldKey: _key,
                addNewTx: _addNewTransaction,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
            title: Text('Personal Expenses'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewTx(context))
            ]),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              child: Card(
                  child: Chart(
            recentTransaction: _recentTransaction,
          ))),
          TransactionList(
            userTransactions: _userTransactions,
            deletedTransactions: _deleteTransaction,
          )
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTx(context),
        ));
  }
}
