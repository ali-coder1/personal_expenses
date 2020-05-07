import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses_managements/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final DateFormat dateFormat = DateFormat.yMMMd().add_jms();

  final List<Transaction> transactionsList;
  final Function deleteTransaction;

  TransactionList({this.transactionsList, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 470.0,
        child: transactionsList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Text(
                      'No transactions yet !!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Container(
                        height: 250.0,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.contain,
                        ))
                  ])
            : ListView.builder(
                itemCount: transactionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                    child: ListTile(
                        leading: CircleAvatar(
                            radius: 30.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                  child: Text(
                                      '\$${transactionsList[index].amount}')),
                            )),
                        title: Text(
                          transactionsList[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                            dateFormat.format(transactionsList[index].date)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).primaryColor,
                          onPressed: () =>
                              deleteTransaction(transactionsList[index].id),
                        )),
                  );
                }));
  }
}
