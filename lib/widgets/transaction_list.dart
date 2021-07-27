import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  //list to save transactions
  final List<Transaction> transactions;
  //function to delete transaction
  final Function deleteTx;
  //Constructor
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (cntx, constraints) {
            //column for empty page, where no txs added yet
            return Column(
              children: <Widget>[
                //show this text if there are no txs added yet.
                Text(
                  'No tx added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                //Box for free place between widgets
                SizedBox(
                  height: 10,
                ),
                //show this image if there are no txs added yet
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        //scrolling list view for all transactions
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  //circle to show spend amount
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  //title of transactions
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  //subtitle of transactions (date of tx)
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  //delete icon with functionality
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
