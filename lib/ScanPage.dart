import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accordion/accordion.dart';

import 'ApiClient.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String result = "None";
  MobileScannerController cameraController = new MobileScannerController();
  bool _screenOpened = false;
  var api = new ApiClient();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: screenSize.width * 0.95,
            height: screenSize.height * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: MobileScanner(
                fit: BoxFit.cover,
                controller: cameraController,
                onDetect: _foundBarcode,
            ))),
            Positioned(
              top: screenSize.height * 0.25 / 2 - 10,
              left: 0,
              right: 0,
              child: Divider(
                color: Color(0xFF39EBB1).withOpacity(0.5),
                thickness: 10,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 4.0, color: Colors.white),
                    left: BorderSide(width: 4.0, color: Colors.white),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20)),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 4.0, color: Colors.white),
                    right: BorderSide(width: 4.0, color: Colors.white),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20)),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4.0, color: Colors.white),
                    left: BorderSide(width: 4.0, color: Colors.white),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20)),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4.0, color: Colors.white),
                    right: BorderSide(width: 4.0, color: Colors.white),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20)),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  void _foundBarcode(BarcodeCapture barcode) async {
    if (!_screenOpened) {
      final String code = barcode.barcodes[0].rawValue ?? "---";
      debugPrint("Barcode found: $code");
      _screenOpened = true;

      var scanned_product = null;
      try {
        var response = await api.getRequest('product/$code');
        if (response.statusCode == 200) {
          var product = json.decode(response.body);
          setState(() {
            scanned_product = product;
          });
          debugPrint(product["image_url"]);
        } else {
          debugPrint('Failed to fetch product: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Exception while fetching users: $e');
      }

      if( scanned_product != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool userVegan = prefs.getBool('userVegan') ?? false;
        bool userVegetarian = prefs.getBool('userVegetarian') ?? false;
        bool userGlutenFree = prefs.getBool('userGlutenFree') ?? false;
        bool userDairyFree = prefs.getBool('userDairyFree') ?? false;
        bool userFishFree = prefs.getBool('userFishFree') ?? false;
        bool userCrustaceansFree = prefs.getBool('userCrustaceansFree') ?? false;
        bool userEggFree = prefs.getBool('userEggFree') ?? false;
        bool userPaleo = prefs.getBool('userPaleo') ?? false;
        bool userAddedSugarFree = prefs.getBool('userAddedSugarFree') ?? false;

        bool isSafe = true;
        isSafe &= !userVegan || (scanned_product["isVegan"] == 1);
        isSafe &= !userVegetarian || (scanned_product["isVegetarian"] == 1);
        isSafe &= !userGlutenFree || (scanned_product["isGlutenFree"] == 1);
        isSafe &= !userDairyFree || (scanned_product["isDiaryFree"] == 1);
        isSafe &= !userFishFree || (scanned_product["isFishFree"] == 1);
        isSafe &= !userCrustaceansFree || (scanned_product["isCrustaceansFree"] == 1);
        isSafe &= !userEggFree || (scanned_product["isEggFree"] == 1);
        isSafe &= !userPaleo || (scanned_product["isPaleo"] == 1);
        isSafe &= !userAddedSugarFree || (scanned_product["isAddedSugarFree"] == 1);
        
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FoundCodeScreen(screenClosed: _screenWasClosed, product: scanned_product, isSafe: isSafe,),
            ));
      } else {
        _screenOpened = false;
        debugPrint("No id found!");
      }
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function() screenClosed;
  final bool isSafe;

  const FoundCodeScreen({
    Key? key,
    required this.product,
    required this.screenClosed,
    required this.isSafe,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen>{
  String getIngredients()
  {
    String ingredients = "";

    for(String ingredient in widget.product["ingredients"]){
      ingredients += ingredient;
      ingredients += ", ";
    }

    ingredients = ingredients.substring(0, ingredients.length - 2);

    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      appBar: AppBar(
        backgroundColor: Color(int.parse('0xFF1b212f')),
        title: Text("Found Item", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white, // Set the color to white
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  widget.product["image_url"], height: 200,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.product["name"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("The product is ", style: TextStyle(color: Colors.white)),
                  Text(widget.isSafe == true ? "safe" : "unsafe", style: TextStyle(color: widget.isSafe == true ? Colors.green : Colors.red)),
                  Text(" to consume", style: TextStyle(color: Colors.white)),
                  ],
              ),
              SizedBox(
                height: 20,
              ),
              Accordion(
                children: [
                  AccordionSection(
                    headerBorderWidth: 2,
                    headerBorderColor: Color(0xFF39EBB1),
                    headerBackgroundColor: Color(0xFF1b212f),
                    headerBackgroundColorOpened: Color(0xFF39EBB1),
                    contentBackgroundColor: Color(0xFF1b212f),
                    contentBorderColor: Color(0xFF39EBB1),
                    contentBorderWidth: 2,
                    headerPadding: EdgeInsets.all(8),
                    header:  Text("Ingredients", style: TextStyle(color: Colors.white)),
                    content: Text(getIngredients(), style: TextStyle(color: Colors.white))
                  ),
                  AccordionSection(
                    headerBorderWidth: 2,
                    headerBorderColor: Color(0xFF39EBB1),
                    headerBackgroundColor: Color(0xFF1b212f),
                    headerBackgroundColorOpened: Color(0xFF39EBB1),
                    contentBackgroundColor: Color(0xFF1b212f),
                    contentBorderColor: Color(0xFF39EBB1),
                    contentBorderWidth: 2,
                    headerPadding: EdgeInsets.all(8),
                    header:  Text("Nutritional Information", style: TextStyle(color: Colors.white)),
                    content:
                    Table(
                      children: [
                        TableRow(
                            children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Vegan", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isVegan"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Gluten", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isGlutenFree"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Dairy", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isDiaryFree"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Fish", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isFishFree"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Vegetarian", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isVegetarian"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Crustaceans", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isCrustaceansFree"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Egg", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isEggFree"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Paleo", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isPaleo"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Added Sugar Free", style: TextStyle(color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.product["isAddedSugarFree"] == 1 ? Colors.green : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container()
                                  ],
                                ),
                              ),
                            ]
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

