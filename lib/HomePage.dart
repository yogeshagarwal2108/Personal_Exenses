//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/new_transaction.dart';
import './models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{

  _HomePageState(){
    print("Home PAge State");
  }

  @override
  void initState() {
    print("init()");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    super.didChangeAppLifecycleState(state);
    print(state);
  }
  @override
  void dispose() {
    print("dispose()");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool showChart= false;

  final List<Transaction> userTransactions= [
    Transaction(id: "t1", title: "new shirt", amount: 100.32, date: DateTime.now()),
    Transaction(id: "t2", title: "Shoes", amount: 34.56, date: DateTime.now()),
    Transaction(id: "t3", title: "Shoes", amount: 34.56, date: DateTime.now()),
    Transaction(id: "t4", title: "Shoes", amount: 34.56, date: DateTime.now()),
    Transaction(id: "t5", title: "Shoes", amount: 34.56, date: DateTime.now()),
  ];

  List<Transaction> get recentTransaction {
    return userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }


  _addNewTransaction(String title, double amount, DateTime chosenDate){
    final t= Transaction(id: DateTime.now().toString(),title: title, amount: amount, date: chosenDate);

    setState(() {
      userTransactions.add(t);
    });
  }

  _startAddNewTransaction(context)
  {
    showModalBottomSheet(
      context: context,
      builder: (context){
        return GestureDetector(
          onTap: (){},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  deleteTransaction(String id){
    setState(() {
      userTransactions.removeWhere((tx){
        return (tx.id== id);
      });
    });
  }


  //builder function for landscape and portrait mode
  List<Widget> buildLandscapeContent(mediaQuery, appbar, txList) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(showChart== false ? "Show chart" : "Show transactions", style: Theme.of(context).textTheme.headline6,),
        Switch.adaptive(
//                  activeColor: Theme.of(context).primaryColor,
          value: showChart,
          onChanged: (val){
            setState(() {
              showChart= val;
            });
          },
        ),
      ],
    ), showChart ? Container(
    height: (mediaQuery.size.height- appbar.preferredSize.height- mediaQuery.padding.top) * 0.7,
    child: Chart(recentTransaction)
    )
    : txList];
  }

  List<Widget> buildPortraitContent(mediaQuery, appbar, txList) {
    return [Container(
        height: (mediaQuery.size.height- appbar.preferredSize.height- mediaQuery.padding.top) * 0.33,
        child: Chart(recentTransaction)
    ), txList];
  }

  //builder method for navigation bar and appbar
  Widget buildNavigationBar() {
    print("build function");
    return CupertinoNavigationBar(
      middle: Text("Personal Expenses"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: (){
              _startAddNewTransaction(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Personal Expenses"),
      elevation: 3.0,
      backgroundColor: Colors.indigo,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            _startAddNewTransaction(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery= MediaQuery.of(context);

    final PreferredSizeWidget appbar= Platform.isIOS ? buildNavigationBar() : buildAppBar();

    final isLandscape= mediaQuery.orientation== Orientation.landscape;

    final txList= Container(
        height: (mediaQuery.size.height- appbar.preferredSize.height- mediaQuery.padding.top) * 0.67,
        child: TransactionList(userTransactions, deleteTransaction)
    );


    //body
    final pageBody= SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) ...buildLandscapeContent(mediaQuery, appbar, txList),
            if(!isLandscape) ...buildPortraitContent(mediaQuery, appbar, txList),
          ],
        ),
      ),
    );


    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appbar,
      child: pageBody,
    )
    : Scaffold(
      appBar: appbar,

      body: pageBody,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: (){
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
