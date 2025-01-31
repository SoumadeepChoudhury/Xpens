import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key, required this.onReceive});

  final Function onReceive;

  @override
  Widget build(BuildContext _context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: MobileScanner(
            controller:
                MobileScannerController(detectionSpeed: DetectionSpeed.normal),
            onDetect: (barcodes) {
              String? val = barcodes.barcodes.first.rawValue;
              if (val != null) {
                if (val.isNotEmpty) {
                  onReceive(val, _context);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
