import 'package:flutter/material.dart';
import 'package:grocery_app/ApiClient.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var api = new ApiClient();
  var name = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(int.parse('0xFF1b212f')),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.1, 0, screenSize.width * 0.1, 0,),
              child: Text('Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: Colors.white)
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.05, 10, screenSize.width * 0.05, 20,),
              child: Text('GroceryScan makes grocery shopping fun even with food allergies or specific dietary preferences!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color(0xFF39EBB1))
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.1, 10, screenSize.width * 0.1, 0,),
              child: Text('All you have to do is',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.05, 0, screenSize.width * 0.05, 0,),
              child: Text('1. Set your dietary preferences in your profile\n2. Scan barcode of items in grocery stores!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white)
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0,200,0,0),
              child: Image.asset('assets/images/grocery_logo.jpg', height: screenSize.height * 0.15),
            ),
          ],
          )
        )
    );
  }
}
