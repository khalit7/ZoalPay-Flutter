import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:ZoalPay/lang/Localization.dart';


class TransactionReceipt extends StatelessWidget {
  static final pageName="TransactionReceipt";
  String subTitle;
  String transactionValue;
  Map pageDetails;
  TransactionReceipt({this.subTitle,this.transactionValue,this.pageDetails});
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
                  Localization.of(context).getTranslatedValue(subTitle)?? subTitle,
                  style: TextStyle(fontSize: width * height / 15000),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  "$transactionValue",
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
              //divder line
              Divider(
                color: Colors.black,
                indent: 10,
                endIndent: 20,
                height: width * height / 5000,
              ),
              Column(children:pageDetails.entries.map((iteam)=>Padding(
                padding: EdgeInsets.fromLTRB(
                    width * height / 7000, 0, width * height / 7000, 0),
                child: Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(Localization.of(context).getTranslatedValue(iteam.key)),
                    trailing: Text("${iteam.value}"),
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black26))),
                ),
              ), ).toList())
              
            ],
          ),
        ],
      ),
    );
  }
}

