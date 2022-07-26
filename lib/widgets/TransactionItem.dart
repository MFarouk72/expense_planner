import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.transaction, required this.deleteTx}) : super(key: key);
  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$ ${transaction.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title.toString(),
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle:Text(
          DateFormat.yMMMd().format(transaction.date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon:const Icon(Icons.delete,color: Colors.red,),
          onPressed: (){
            deleteTx(transaction.id);
          },
        ),
      ),
    );
  }
}
