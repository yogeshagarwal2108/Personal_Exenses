import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints){
          return Column(
            children: <Widget>[
              Text("No Transactions yet", style: Theme.of(context).textTheme.headline6,),
              SizedBox( height: constraints.maxHeight * 0.05, ),
              Container(
                height: constraints.maxHeight * 0.7,
                child: Image.asset("assets/image/waiting.png", fit: BoxFit.cover,),
              )
            ],
          );
        })
        : ListView(
            children: transactions.map((data){
              return TransactionItem(
                key: ValueKey(data.id),
                transaction: data, deleteTransaction: deleteTransaction
              );
            }).toList(),
          )
    );
  }
}
