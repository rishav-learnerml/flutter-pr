// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          primarySwatch: Colors.purple,
          errorColor: Colors.red,
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.pink)),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Macbook',
    //   amount: 133000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Banana Shake',
    //   amount: 30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Firebolt Watch',
    //   amount: 2200,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Harry Potter Books',
    //   amount: 2800,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'Hp Mouse',
    //   amount: 1000,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransactions(String title, int amount, DateTime chodenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chodenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  // late String titleInput;
  _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx, builder: (_) => NewTransaction(_addNewTransactions));
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        "Expense Tracker",
      ),
      // actions: [
      //   IconButton(
      //       onPressed: () => _startAddNewTransaction(context),
      //       icon: Icon(Icons.add))
      // ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_userTransactions)),
            _userTransactions.isEmpty
                ? Column(children: [
                    Text(
                      "No Expenses Yet!!!",
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/no_expense.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ])
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(_recentTransaction, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
    );
  }
}
