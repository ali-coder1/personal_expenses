import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLable;
  final double spendingAmount;
  final double totalSpendingAmounts;

  ChartBar({this.dayLable, this.spendingAmount, this.totalSpendingAmounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 20.0,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(height: 4.0),
        Container(
          height: 60.0,
          width: 15.0,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              FractionallySizedBox(
                heightFactor: totalSpendingAmounts,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(dayLable)
      ],
    );
  }
}
