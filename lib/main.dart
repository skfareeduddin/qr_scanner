import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/qr_scanner_screen.dart';
import 'package:qr_scanner/screens/response_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const QRScanner());
}

class QRScanner extends StatelessWidget {
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              primary: Colors.yellow,
              secondary: Colors.orange,
              tertiary: Colors.white,
              seedColor: Colors.transparent),
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontFamily: 'Sen',
                color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/QR-Scan',
        routes: {
          '/QR-Scan': (context) => QRScannerScreen(),
          '/response': (context) =>
              const ResponseScreen(codeText: '', closeScreen: null)
        },
      ),
    );
  }
}
