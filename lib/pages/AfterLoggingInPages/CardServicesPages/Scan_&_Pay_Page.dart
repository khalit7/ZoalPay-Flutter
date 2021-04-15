import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanAndPayPage extends StatefulWidget {
  static final pageName = "ScanAndPayPage";
  @override
  _ScanAndPayPageState createState() => _ScanAndPayPageState();
}

class _ScanAndPayPageState extends State<ScanAndPayPage> {
  var _scanBarcode;
  Future scanBarcodeNormal() async {
    String barcodeScanRes;
      // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //     "#ff6666", "Cancel", true, ScanMode.QR);

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  build(context) {
    return Scaffold(
      body: Center(
        child: FlatButton(child: Text("dont touch me"),onPressed:scanBarcodeNormal
        ,),
      ),
    );
  }
}
