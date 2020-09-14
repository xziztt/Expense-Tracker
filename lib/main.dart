import 'package:flutter/cupertino.dart';

import './models/transaction.dart';
import 'dart:io'; // used for patform.is* ?
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //DeviceOrientation.portraitDown,
  //DeviceOrientation.portraitUp,
  //]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: "UbuntuMono",
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'UbuntuMono', fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.lightBlue)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'BebasNeue', fontSize: 17)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _deleteTransaction(id) {
    setState(() {
      _userTransactions
          .removeWhere((whichTransaction) => whichTransaction.id == id);
    });
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime pickedDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: pickedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    void _startNewTransaction(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        },
      );
    }

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Expense Tracker"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransaction(context),
                )
              ],
            ))
        : AppBar(
            title: Text(
              'Expense Tracker',
              style: TextStyle(fontFamily: "Open Sans"),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startNewTransaction(context))
            ],
          );
    final landscapeCheck =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (landscapeCheck)
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Show Chart"),
                    Switch(
                        value: switchValue,
                        onChanged: (val) {
                          setState(() {
                            switchValue = val;
                          });
                        }),
                  ]),
            if (!landscapeCheck)
              Container(
                width: double.infinity,
                child: Container(
                  height: (mediaQuery.size.height -
                          mediaQuery.padding.top -
                          mediaQuery.padding.bottom) *
                      0.2,
                  child: Card(
                    color: Colors.blue,
                    child: Chart(_recentTransactions),
                    elevation: 5,
                  ),
                ),
              ),
            if (!landscapeCheck)
              Container(
                  width: double.infinity,
                  height: (mediaQuery.size.height -
                          mediaQuery.padding.top -
                          mediaQuery.padding.bottom) *
                      0.7,
                  child:
                      TransactionList(_userTransactions, _deleteTransaction)),
            if (landscapeCheck)
              switchValue
                  ? Container(
                      width: double.infinity,
                      child: Container(
                        height: (mediaQuery.size.height -
                                mediaQuery.padding.top -
                                mediaQuery.padding.bottom) *
                            0.5,
                        child: Card(
                          color: Colors.blue,
                          child: Chart(_recentTransactions),
                          elevation: 5,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: (mediaQuery.size.height -
                              mediaQuery.padding.top -
                              mediaQuery.padding.bottom) *
                          0.7,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction)),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: appBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
