import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  final String name;
  final String returnDate;
  Book({this.name,this.returnDate});
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Card(
          child: Container(
        child: Column(
          children: <Widget>[
            Text(widget.name),
            Text(widget.returnDate)
          ],
        ),
      ),
    );
  }
}