import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/screens/response_screen.dart';
import 'package:sizer/sizer.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedCode = '';
  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        final resultFromFile = await FlutterQrReader.imgScan(pickedFile.path);
        setState(() {
          scannedCode = resultFromFile;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponseScreen(
                codeText: scannedCode,
                closeScreen: closeScreen,
              ),
            ),
          );
          isScanCompleted = true;
          //dispose();
        });
      } on FormatException catch (_) {
        print('Failed to decode QR code from image.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Place your QR code below!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0.sp,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Gap(10.h),
              Container(
                width: 40.0.h,
                height: 40.0.h,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _pickImageFromGallery();
                },
                child: const Text('Pick Image from Gallery'),
              ),
              Gap(5.h),
              Text(
                'The QR Code will be automatically detected when you position it between the guide lines.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0.sp,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewController(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      if (!isScanCompleted) {
        setState(() {
          scannedCode = event.code;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponseScreen(
                codeText: scannedCode,
                closeScreen: closeScreen,
              ),
            ),
          );
          isScanCompleted = true;
          dispose();
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
