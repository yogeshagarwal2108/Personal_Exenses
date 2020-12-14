import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionItem extends StatefulWidget {

  final Transaction transaction;
  Function deleteTransaction;
  TransactionItem({Key key, @required this.transaction, @required this.deleteTransaction}): super(key:key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final colors= [Colors.red, Colors.blue, Colors.black, Colors.indigo, Colors.deepPurple];

  @override
  Widget build(BuildContext context) {
    final mediaQuery= MediaQuery.of(context);
    final _scaleFactor= mediaQuery.textScaleFactor;

    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: colors[Random().nextInt(5)],
          child: FittedBox(
            child: Text("\$${widget.transaction.amount}", style: TextStyle(fontSize: 13.0 * _scaleFactor),),
          ),
        ),
        title: Text(widget.transaction.title, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: mediaQuery.size.width > 400 ? FlatButton.icon(
          icon: Icon(Icons.delete),
          label: Text("Delete"),
          textColor: Theme.of(context).errorColor,
          onPressed: (){
            widget.deleteTransaction(widget.transaction.id);
          },
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: (){
            widget.deleteTransaction(widget.transaction.id);
          },
        ),
      ),
    );
  }
}
