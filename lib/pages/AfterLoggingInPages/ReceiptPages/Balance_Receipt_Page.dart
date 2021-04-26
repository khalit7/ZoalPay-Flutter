import 'package:ZoalPay/lang/Localization.dart';

import 'package:flutter/material.dart';

class BalanceReceipt extends StatelessWidget {
  static final pageName = "BalancReceiptPage";

  double balance;

  BalanceReceipt({this.balance});

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu_outlined),
              ),
              SizedBox(width: width / 15),
              Text(
                Localization.of(context).getTranslatedValue("Card Balance"),
              ),
            ],
          ),
        ),
        body: Text("${balance.toString()}"));
  }
}
