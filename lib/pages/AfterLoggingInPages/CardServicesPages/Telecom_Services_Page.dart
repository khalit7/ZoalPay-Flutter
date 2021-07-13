import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/custom_icon_button.dart';
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
                  mainAxisAlignment: rowAllignment,
                  children: [
                    CardWithImageAndText(
                        CustomIconButton(() {
                          Navigator.pushNamed(
                              context, MobileTopUpPage.pageName);
                        }, Icons.phone_android_rounded),
                        Text(
                            Localization.of(context)
                                .getTranslatedValue("Mobile TOPUP"),
                            style: TextStyle(color: Colors.red),
                            textScaleFactor: 1.2)),
                    SizedBox(
                      width: width - (2 * width / 2.01),
                    ),
                    CardWithImageAndText(
                        CustomIconButton(() {
                          Navigator.pushNamed(
                              context, BillPaymentPage.pageName);
                        }, Icons.payments_sharp),
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
                  mainAxisAlignment: rowAllignment,
                  children: [
                    CardWithImageAndText(
                        CustomIconButton(() {
                          Navigator.pushNamed(context, SudaniAdSlPage.pageName);
                        }, Icons.monetization_on),
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
