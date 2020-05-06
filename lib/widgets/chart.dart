import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses_managements/widgets/chart_bar.dart';
import 'package:expenses_managements/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get chartBarTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return chartBarTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: chartBarTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  dayLable: data['day'],
                  spendingAmount: data['amount'],
                  totalSpendingAmounts: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}
