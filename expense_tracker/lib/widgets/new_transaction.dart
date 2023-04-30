import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addExpense;

  NewTransaction(this.addExpense);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  late DateTime? _selectedDate = null;
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    String titleText = _titleController.text;
    int amount = int.parse(_amountController.text);
    DateTime chosenDate = _selectedDate as DateTime;

    if (titleText.isEmpty || amount <= 0 || _selectedDate == null) return;

    widget.addExpense(titleText, amount, chosenDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            // onChanged: (value) => titleInput = value,
            controller: _titleController,
            onSubmitted: (_) => _submitData,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            // onChanged: (value) => amountInput = value,
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData,
          ),
          Container(
            height: 70,
            child: Row(children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? "No Date Chosen!"
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}'),
              ),
              TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    "Choose date",
                  ))
            ]),
          ),
          OutlinedButton(
              onPressed: _submitData,
              child: Text(
                "Add Transaction",
              ),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColorDark)))
        ]),
      ),
    );
  }
}
