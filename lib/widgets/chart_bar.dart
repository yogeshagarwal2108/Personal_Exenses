import 'dart:math';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double amount;
  final double percentAmount;

  ChartBar(this.label, this.amount, this.percentAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text("\$${this.amount.toStringAsFixed(0)}"),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),

            Container(
              height: constraints.maxHeight * 0.6,
              width: 15.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
//                      color: Colors.deepPurpleAccent,
                      border: Border.all(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentAmount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(this.label),
              ),
            ),
          ],
        );
      },
    );
  }
}
