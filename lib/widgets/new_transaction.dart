import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime _pickedDate = DateTime.now();
  final amountController = TextEditingController();
  void pickTheDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(11, 2, 2019),
            lastDate: DateTime.now())
        .then(
      (value) {
        if (value == Null) {
          return;
        }
        setState(() {
          _pickedDate = value;
        });
      },
    );
  }

  void submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final enteredDate = _pickedDate;
    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      enteredDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Item Name'),
                controller: titleController,
                // onChanged: (val) => amountInput = val,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                onSubmitted: (value) => submitTransaction(),
                // onChanged: (val) => amountInput = val,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(_pickedDate == Null
                        ? "No Date"
                        : DateFormat.yMd().format(_pickedDate)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                      elevation: 2,
                      color: Theme.of(context).textTheme.button.color,
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                            color: Theme.of(context).textTheme.title.color),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: pickTheDate)
                ],
              ),
              SizedBox(
                height: 100,
              ),
              FlatButton(
                color: Theme.of(context).textTheme.button.color,
                child: Text(
                  'Add Transaction',
                  style:
                      TextStyle(color: Theme.of(context).textTheme.title.color),
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: submitTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
