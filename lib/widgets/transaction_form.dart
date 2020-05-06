import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransaction;
  // final GlobalKey<ScaffoldState> scaffoldKey;

  TransactionForm({this.addTransaction});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final DateFormat dateFormat = DateFormat.yMd();

  DateTime _selectedDate;

  void _submittedData() {
    // This is to avoid throw an error when leave amount field empty
    if (_amountController.text.isEmpty) {
      // _showScaffoldKey('Fill Them Correctly');
      Navigator.of(context).pop();
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      // _showScaffoldKey('Nothing happend: Please try again');
      Navigator.of(context).pop();
      return;
    } else {
      widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  // void _showScaffoldKey(String msg) {
  //   widget.scaffoldKey.currentState.showSnackBar(_snackBar(msg));
  // }

  // Widget _snackBar(String msg) {
  //   return SnackBar(
  //     behavior: SnackBarBehavior.floating,
  //     content: Text(msg),
  //     action: SnackBarAction(
  //       label: 'Undo',
  //       onPressed: widget.scaffoldKey.currentState.hideCurrentSnackBar,
  //     ),
  //   );
  // }

  void _openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 20)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) => _submittedData(),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    onSubmitted: (_) => _submittedData(),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    height: 70.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(_selectedDate == null
                              ? 'No Date Chosen'
                              : 'Picked Date: ${dateFormat.format(_selectedDate)}'),
                        ),
                        FlatButton(
                          child: Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _openDatePicker,
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: _submittedData)
                ])));
  }
}
