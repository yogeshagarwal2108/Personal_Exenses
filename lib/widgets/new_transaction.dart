import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'cupertino_flat_button.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {

  final Function addTx;
  NewTransaction(this.addTx){
    print("Constructor new transaction");
  }

  @override
  _NewTransactionState createState() {
    print("create state new transaction");
    return  _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController= TextEditingController();
  final amountController= TextEditingController();
  DateTime _dateTime;

  _NewTransactionState(){
    print("create state new transaction");
  }

  @override
  void initState() {
    super.initState();
    print("initState()");
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget()");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose()");
  }

  submitData(){
    String title= titleController.text;
    double amount= double.parse(amountController.text);

    if(title.isEmpty || amount<=0 || _dateTime==null){
      return;
    }

    widget.addTx(titleController.text, double.parse(amountController.text), _dateTime);

    Navigator.pop(context);
  }

  pickDate(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now()
    ).then((date){
      if(date== null){
        return;
      }
      setState(() {
        _dateTime= date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build function");
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: titleController,
                onSubmitted: (_)=> submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: amountController,
                onSubmitted: (_)=> submitData(),
                keyboardType: TextInputType.number,
              ),

              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_dateTime==null ? "No date chosen!" : "picked Date: ${DateFormat.yMd().format(_dateTime)}"),
                      CupertinoFlatButton("Choose Date", pickDate),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Add transaction"),
                onPressed: (){
                  submitData();
                },
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
