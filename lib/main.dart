import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'HomePage.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final _scaleFactor= MediaQuery.of(context).textScaleFactor;

    return MaterialApp(
      title: "Personal Expenses",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        fontFamily: "Quicksand",

        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 18.0,
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
               fontSize: 20.0,
            ),
          ),
        ),
      ),

      home: HomePage(),
    );
  }
}
