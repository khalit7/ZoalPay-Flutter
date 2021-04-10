import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  static final pageName = "TransactionHistoryPage";

  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Localization.of(context).getTranslatedValue("Transaction History")),
      ),
    );
  }
}
