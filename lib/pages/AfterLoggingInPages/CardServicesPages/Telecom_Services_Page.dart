import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';
import 'TelecomServicesPages/Bill_Payment_Page.dart';
import 'TelecomServicesPages/Mobile_TOPUP_Page.dart';
import 'TelecomServicesPages/Sudani_ADSL_Page.dart';

class TelecomSevicesPage extends StatelessWidget {
  static final pageName = "TelecomSevicesPage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            title: Text(Localization.of(context)
                .getTranslatedValue("Telecom Services"))),
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
                              Navigator.pushNamed(
                                  context, MobileTopUpPage.pageName);
                            },
                            icon: Icon(Icons.phone_android_rounded,
                                color: Colors.red),
                            iconSize: width / 3),
                        Text(
                            Localization.of(context)
                                .getTranslatedValue("Mobile TOPUP"),
                            style: TextStyle(color: Colors.red),
                            textScaleFactor: 1.2)),
                    SizedBox(
                      width: width - (2 * width / 2.01),
                    ),
                    CardWithImageAndText(
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, BillPaymentPage.pageName);
                          },
                          icon: Icon(Icons.payments_sharp, color: Colors.red),
                          iconSize: width / 3,
                        ),
                        Text(
                          Localization.of(context)
                              .getTranslatedValue("Bill Payment"),
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
                                  context, SudaniAdSlPage.pageName);
                            },
                            icon:
                                Icon(Icons.monetization_on, color: Colors.red),
                            iconSize: width / 3),
                        Text(
                            Localization.of(context)
                                .getTranslatedValue("Sudani ADSL"),
                            style: TextStyle(color: Colors.red),
                            textScaleFactor: 1.2)),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
