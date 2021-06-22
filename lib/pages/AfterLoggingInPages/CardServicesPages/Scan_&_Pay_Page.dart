import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Transfer_Card_To_Card_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanAndPayPage extends StatefulWidget {
  static final pageName = "ScanAndPayPage";
  @override
  _ScanAndPayPageState createState() => _ScanAndPayPageState();
}

class _ScanAndPayPageState extends State<ScanAndPayPage> {
  ScanResult scanResult;

  build(context) {
    scan();
    return Scaffold(body: SizedBox());
  }

  Future scan() async {
    scanResult = await BarcodeScanner.scan();
    if (scanResult.type.name ==
        "Cancelled") // nothing scanned ... just go back to the previous screen
    {
      Navigator.pop(context);
    } else {
      // push to card to card transfer page
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TransferCardToCardPage(reciverPan: scanResult.rawContent)));
    }
  }
}
