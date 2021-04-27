import 'package:ZoalPay/lang/Localization.dart';

import 'package:flutter/material.dart';

class TransactionDetails extends StatelessWidget {
  static final pageName = "BalancReceiptPage";

  double balance;
  String cardNumber;
  String date = DateTime.now().toString().substring(0,19); // this is to formate date time from UTZ to yy-mm-dd-hh-m-ss
  TransactionDetails({this.balance, this.cardNumber});

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          title: Text(
            Localization.of(context).getTranslatedValue("Transaction Details"),
          ),
          actions: [GestureDetector(onTap: (){
            Navigator.pop(context);
          },child: Icon(Icons.close),)],
        ),
        body: Stack(
        children: [
          Center(
              child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              "assets/zoalPayLogo.png",
              scale: width * height / 40000,
            ),
          )),
          Column(
            children: [
              SizedBox(
                height: width * height / 7000,
              ),
              Center(
                child: Text(
                  Localization.of(context).getTranslatedValue("Successful Transaction"),
                  style: TextStyle(fontSize: width * height / 15000),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  Localization.of(context).getTranslatedValue("Balance"),
                  style: TextStyle(fontSize: width * height / 15000),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  "${balance.toString()}",
                  style: TextStyle(
                      fontSize: width * height / 5000, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  "SDG",
                  style: TextStyle(
                      fontSize: width * height / 12000,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                color: Colors.black,
                indent: 10,
                endIndent: 20,
                height: width * height / 5000,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    width * height / 7000, 0, width * height / 7000, 0),
                child: Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(Localization.of(context).getTranslatedValue("Card Number")),
                    trailing: Text("$cardNumber"),
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black26))),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    width * height / 7000, 0, width * height / 7000, 0),
                child: Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(Localization.of(context).getTranslatedValue("Date")),
                    trailing: Text("$date"),
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black26))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
