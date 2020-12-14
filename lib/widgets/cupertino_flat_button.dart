import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class CupertinoFlatButton extends StatefulWidget {

  final String buttonText;
  final Function pickDate;
  CupertinoFlatButton(this.buttonText, this.pickDate);

  @override
  _CupertinoFlatButtonState createState() => _CupertinoFlatButtonState();
}

class _CupertinoFlatButtonState extends State<CupertinoFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(
      child: Text(widget.buttonText, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),),
      onPressed: (){
        widget.pickDate();
      },
    ) : FlatButton(
      child: Text(widget.buttonText, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),),
      onPressed: (){
        widget.pickDate();
      },
    );
  }
}
