import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //var add new transaction function
  final Function addTx;

  //Constructor
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //variables to save title, amount and date of transaction
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  //add transaction button action
  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }

    //widget is a special property created with statefull state
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    //close new tx popup model sheet after adding tx
    Navigator.of(context).pop();
  }

  //pick date for transaction
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != _selectedDate)
        setState(() {
          _selectedDate = pickedDate;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    //scroll view to see all transactions
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //title text field
              TextField(
                decoration: InputDecoration(labelText: 'Title:'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (newTitle) {
                //   titleInput = newTitle;
                // },
              ),
              //amount text field
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (newAmount) {
                //   amountInput = newAmount;
                // },
                controller: _amountController,
              ),
              //container for date picker
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    //show picked date text
                    Expanded(
                      child: Text(
                        'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    //button to open date picker
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              //submit transaction button
              RaisedButton(
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
