import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "package:intl/intl.dart";
import './bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> sevenDayTransaction;
  Chart(this.sevenDayTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final dayOfTheWeek = DateTime.now().subtract(Duration(days: index));

      double sumTotal = 0;
      for (var i = 0; i < sevenDayTransaction.length; i++) {
        if (sevenDayTransaction[i].date.day == dayOfTheWeek.day &&
            sevenDayTransaction[i].date.month == dayOfTheWeek.month &&
            sevenDayTransaction[i].date.year == dayOfTheWeek.year) {
          sumTotal += sevenDayTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(dayOfTheWeek)[0],
        'amount': sumTotal
      };
    });
  }

  double get totalAmountSpent {
    return groupedTransactionValues.fold(0.0, (sum, tx) {
      return sum = sum + tx['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(),
      child: Container(
        //or use a padding widget to only add padding
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: groupedTransactionValues.map((value) {
            return Flexible(
              fit: FlexFit.tight,
              child: Bar(
                  value['day'],
                  value['amount'],
                  totalAmountSpent == 0.0
                      ? 0.0
                      : (value['amount'] as double) / totalAmountSpent),
            );
          }).toList(),
        ),
      ),
    );
  }
}
