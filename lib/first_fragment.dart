/*import 'package:flutter/material.dart';

class FirstFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Hello Fragment 1"),
    );
  }

}*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:login/Book.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstFragment(),
    ));

class FirstFragment extends StatefulWidget {
  @override
  FirstFragmentState createState() {
    return new FirstFragmentState();
  }
}

class FirstFragmentState extends State<FirstFragment> with SingleTickerProviderStateMixin{
  String result = "Fast Scan or Enter the Barcode Manually :)";
  String bookId;
  int _currentIndex=0;
  TextEditingController _bookidController=TextEditingController();
 TabController tc;
 List<Book> _books =<Book>[];
  void initState(){
    super.initState();
    tc=new TabController(
      vsync: this,
      length: 2,
      initialIndex: 0
    );
  }
  void submitBook(String id,BuildContext context){
    setState(() {
          Book _book =new Book(name: id,returnDate:"0000" );
    _books.insert(0, _book);
    _bookidController.clear();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Book Issued"),));
    _currentIndex=1;
        });
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        bookId = qrResult;
        _bookidController.text=bookId;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "It's okay if it didn't scan , enter that manually";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }
  onTabTapped(int index){
    setState(() {
          _currentIndex=index;
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      //appBar: AppBar(
        ///title: Text("QR Scanner"),
      //),
      /*body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
         currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.bookmark_border),
            title: new Text("New Issue")
          
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.book),
            title: new Text("Pending to return"),
            
          ),
        ],
      ),
      body:_currentIndex==0? Column(children: <Widget>[ 
        new Padding(
          padding: EdgeInsets.only(top: 20.0,left: 30.0,right: 20.0,bottom: 15.0 ),
          child: new Text(result,textScaleFactor: 1.3 ,style: TextStyle(fontSize: 20.0, ),)), 
        new Padding(
          padding: EdgeInsets.all(26.0),
          child: new Stack(
                  alignment: const Alignment(1.0, -10.5),
                  children:<Widget>[               
                        new TextField(
                          controller: _bookidController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration( 
                        prefixIcon: Icon(Icons.chrome_reader_mode),
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: "Barcode Number",),
                         ),
                         new FloatingActionButton(
                        onPressed:()=> submitBook(_bookidController.text,context),
                        child: Icon(Icons.send),
                        elevation: 7.0,
                        ),                           
                      ],
                    )
                  ),
                ],
              ):ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context,int index)=>_books[index],
              ),

      floatingActionButton:_currentIndex==0?  FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Fast Scan"),
        onPressed: _scanQR,
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

