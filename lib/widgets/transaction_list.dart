import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses_managements/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final DateFormat dateFormat = DateFormat.yMMMd().add_jms();

  final List<Transaction> transactionsList;
  final Function deletedTransaction;

  TransactionList({this.transactionsList, this.deletedTransaction});

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
                              deletedTransaction(transactionsList[index].id),
                        )),
                  );
                  // return Card(
                  //     child: Row(children: <Widget>[
                  //   Container(
                  //       padding: EdgeInsets.all(10.0),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               width: 1.0,
                  //               color: Theme.of(context).primaryColor)),
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: 10.0, horizontal: 15.0),
                  //       child: FittedBox(
                  //         fit: BoxFit.scaleDown,
                  //         child: Text(
                  //           '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 20.0,
                  //               color: Theme.of(context).primaryColor),
                  //         ),
                  //       )),
                  //   Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Text(userTransactions[index].title,
                  //             style: Theme.of(context).textTheme.title),
                  //         Text(
                  //           dateFormat.format(userTransactions[index].date),
                  //           style: TextStyle(color: Colors.grey),
                  //         )
                  //       ])
                  // ]));
                }));
  }
}
