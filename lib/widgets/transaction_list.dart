import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteElement;

  TransactionList(this.transactions, this._deleteElement);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  "No entry found",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "Assets/Images/default.png",
                  width: 200,
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: FittedBox(
                        child: Text("\$${transactions[index].amount}"),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: FlatButton(
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => _deleteElement(transactions[index].id),
                  ),
                ),
              );
              /*return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );*/
            },
            itemCount: transactions.length,
          );
  }
}
