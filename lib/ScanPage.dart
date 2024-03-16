import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart.';
import 'package:barcode_scan2/gen/protos/protos.pb.dart';
import 'package:barcode_scan2/gen/protos/protos.pbserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String result = "None";

  late CameraController _controller;
  late bool _isCameraInitialized = false;
  late Future<void> _initializeControllerFuture;

  @override
  void initState()
  {
    super.initState();
    _initializeCamera();
    startScanning();
  }

  Future<void> _initializeCamera() async
  {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.high, enableAudio: false);

    try {
      await _controller.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {}
    if (!mounted) return;
    setState(() {});
  }

  Future<void> startScanning() async{
    const Duration scanInterval = Duration(seconds: 5);
    BuildContext dialogContext;
    BarcodeScanner scanner;

    /*Timer.periodic(scanInterval, (Timer timer) async {
      if(!_isCameraInitialized) return;

      try {
        final barcode = await BarcodeScanner.scan();
        setState(() => result = barcode.format.toString());
      }
      catch (e)
      {
        setState(() {
          result = "UnkownError: $e";
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 400,
          height: 200,
          child: Stack(
            children: [
              _isCameraInitialized
                  ? ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: MobileScanner(
                    fit: BoxFit.contain,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      final Uint8List? image = capture.image;
                      for (final barcode in barcodes) {
                        debugPrint('Barcode found! ${barcode.rawValue}');
                          }
                        },
                      )
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse('0xFF161a1f')),
                        borderRadius: BorderRadius.circular(20), // Adjust the radius here
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(int.parse('0xFF3dfbbd')),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }
}