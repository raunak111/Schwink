import 'package:flutter/material.dart';
import 'package:login/root_page.dart';
import 'package:login/auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Schwink - Your Fast lane',
      theme: new ThemeData(
        //primarySwatch: Colors.blue,
        accentColor: Colors.white,
        primaryColor: Colors.red,
        backgroundColor: Colors.deepOrange,
        
        //iconTheme: IconThemeData(color: Colors.greenAccent)

      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}
