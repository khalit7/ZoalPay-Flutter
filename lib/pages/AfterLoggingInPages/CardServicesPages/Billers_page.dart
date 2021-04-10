import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_Pages/Mint_Payment_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_Pages/Safir_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_Pages/TUTIA_Page.dart';
import 'package:flutter/material.dart';

class BillerSPage extends StatelessWidget {
  static final pageName = "BillerSPage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).getTranslatedValue("Billers")),
      ),
      body: Stack(
        children: [
          Container(color: Colors.grey[200]),
          ListView(
            children: [
              //first row
              Row(
                children: [
                  CardWithImageAndText(
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SafirPage.pageName);
                          },
                          icon: Icon(Icons.star_half_sharp, color: Colors.red),
                          iconSize: width / 3),
                      Text(Localization.of(context).getTranslatedValue("Safir"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                  CardWithImageAndText(
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, TUTIAPage.pageName);
                        },
                        icon: Icon(Icons.turned_in, color: Colors.red),
                        iconSize: width / 3,
                      ),
                      Text(
                        Localization.of(context).getTranslatedValue("TUTIA"),
                        style: TextStyle(color: Colors.red),
                        textScaleFactor: 1.2,
                      )),
                ],
              ),

              //second row
              Row(
                children: [
                  CardWithImageAndText(
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MintPaymentPage.pageName);
                          },
                          icon: Icon(Icons.move_to_inbox_outlined,
                              color: Colors.red),
                          iconSize: width / 3),
                      Text(
                          Localization.of(context)
                              .getTranslatedValue("Mint Payment"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
