import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(title, amount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10 ,right: 10 , bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_selectedDate!).toString()),
                  Expanded(
                    child: TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text('Choose Date'),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  submitData();
                },
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
