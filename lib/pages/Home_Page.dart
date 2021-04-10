import 'package:ZoalPay/main.dart';
import 'package:ZoalPay/Widgets/Custom_Flat_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/HomePagePages/LoginPage.dart';
import 'package:ZoalPay/pages/HomePagePages/NewAccountPage.dart';
import 'package:flutter/material.dart';

import '../zoalPayApp.dart';

class HomePage extends StatelessWidget {
  static final pageName = "HomePage";
  build(context) {
    var appBar = AppBar();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    height -= appBar.preferredSize.height;
    return Scaffold(
        // appBar: appBar,
        body: Stack(
      children: [
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: height / 1.65,
            child: Image.asset(
              "assets/ZoalPayImage.png",
            )),
        Positioned(
          left: (width / 2) - ((width * height / 6000)),
          right: (width / 2) - ((width * height / 6000)),
          top: (height / 2) - (width * height / 2000),
          bottom: (height / 2),
          child: Column(
            children: [
              Card(
                child: Image.asset("assets/zoalPayLogo.png"),
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              Text("ZoalPay",
                  textScaleFactor: 1.12,
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Positioned(
          left: (width / 2) - ((width * height / 1500) / 2),
          right: (width / 2) - ((width * height / 1500) / 2),
          top: (height / 2),
          bottom: (height / 2) - (width * height / 2000),
          child: Container(
            child: Column(
              children: [
                CustomFlatButton1(width, height,
                    Localization.of(context).getTranslatedValue("Login"), () {
                  Navigator.pushNamed(context, LoginPage.pageName);
                }, 1000, 18.0),
                CustomFlatButton2(
                    width,
                    height,
                    Localization.of(context)
                        .getTranslatedValue("CREATE NEW ACCOUNT"), () {
                  Navigator.pushNamed(context, NewAccountPage.pageName);
                }, 1000, 15.0),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: height,
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB((width * height / 15000), 0,
                        (width * height / 15000), 0),
                    child: CustomFlatButton1(width, height, "ع", () {
                      MyApp.setLocale(context, Locale('ar', 'SA'));
                    }, 5000, 15.0)),
                CustomFlatButton1(width, height, "EN", () {
                  MyApp.setLocale(context, Locale('en', 'US'));
                }, 5000, 15.0),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
