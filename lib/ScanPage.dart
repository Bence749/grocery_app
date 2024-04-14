import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      body: Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            width: 400,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: MobileScanner(
                fit: BoxFit.cover,
                controller: cameraController,
                onDetect: _foundBarcode,
            ))),
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FoundCodeScreen(screenClosed: _screenWasClosed, value: scanned_product),
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
  final Map<String, dynamic> value;
  final Function() screenClosed;

  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      appBar: AppBar(
        backgroundColor: Color(int.parse('0xFF1b212f')),
        title: Text("Found Item", style: TextStyle(color: Color(int.parse('0xFF39EBB1'))),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(int.parse('0xFF39EBB1'))
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
                  widget.value["image_url"],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.value["name"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                                 color: widget.value["isVegan"] == 1 ? Colors.green : Colors.red,
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
                              color: widget.value["isGlutenFree"] == 1 ? Colors.green : Colors.red,
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
                                  color: widget.value["isDiaryFree"] == 1 ? Colors.green : Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Nuts", style: TextStyle(color: Colors.white, fontSize: 14)),
                              SizedBox(width: 8),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.value["isNutFree"] == 1 ? Colors.green : Colors.red,
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
                                  color: widget.value["isVegetarian"] == 1 ? Colors.green : Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Halal", style: TextStyle(color: Colors.white, fontSize: 14)),
                              SizedBox(width: 8),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.value["isHalal"] == 1 ? Colors.green : Colors.red,
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
                              Text("Kosher", style: TextStyle(color: Colors.white, fontSize: 14)),
                              SizedBox(width: 8),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.value["isKosher"] == 1 ? Colors.green : Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        TableCell(
                          child: Container(
                            width: 0,
                          ),
                        ),
                      ]
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

