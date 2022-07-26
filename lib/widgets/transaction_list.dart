import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/TransactionItem.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList({Key? key, required this.transactions,required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Text(
                'No transactions added yet',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                  height: constraints.maxHeight * .6,
                  width: 200,
                  child: Image.asset('assets/images/waiting.png')),
            ],
          );
        })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return TransactionItem(transaction: transactions[index], deleteTx: deleteTransaction);
            },
          );
  }
}
