import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import "./chart_bar.dart";

class Chart extends StatelessWidget {

  List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (i){
      final weekDay= DateTime.now().subtract(Duration(days: i));
      double totalAmt= 0.0;

      for(int j=0;j<recentTransaction.length;j++){
        if(recentTransaction[j].date.day== weekDay.day && recentTransaction[j].date.month== weekDay.month && recentTransaction[j].date.year== weekDay.year)
        {
          totalAmt+= recentTransaction[j].amount;
        }
      }
//      print("day : ${DateFormat.E().format(DateTime.now())}");
//      print("amt:  ${totalAmt}");
      return {"day": DateFormat.E().format(weekDay).substring(0, 1), "amount": totalAmt};
    }).reversed.toList();
  }

  double get totalAmount{
    return groupedTransactionValues.fold(0.0, (sum, data){
      return sum + data["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(groupedTransactionValues);
    return Container(
//      height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupedTransactionValues.map((value){
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(value["day"], value["amount"], totalAmount==0.0 ? 0.0 : (value["amount"] as double) / totalAmount)
              );
//            return Text("${value["day"]} : \$${value["amount"]}");
            }).toList(),
          ),
        ),
      ),
    );
  }
}
