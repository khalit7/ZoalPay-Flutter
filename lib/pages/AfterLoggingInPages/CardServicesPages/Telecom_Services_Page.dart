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
            // Container(color: Colors.grey[200]),
            ListView(
              children: [
                //     //first row
                Row(
                  mainAxisAlignment: rowAllignment,
                  children: [
                    ServiceWidget(
                      imageName: "Mobile bill.png",
                      text: "Mobile TOPUP",
                      onpressed: () {
                        Navigator.pushNamed(context, MobileTopUpPage.pageName);
                      },
                    ),
                    ServiceWidget(
                      imageName: "e invoice.png",
                      text: "Bill Payment",
                      onpressed: () {
                        Navigator.pushNamed(context, BillPaymentPage.pageName);
                      },
                    ),
                  ],
                ),

                //     //second row
                Row(
                  mainAxisAlignment: rowAllignment,
                  children: [
                    ServiceWidget(
                      imageName: "adsl.png",
                      text: "Sudani ADSL",
                      onpressed: () {
                        Navigator.pushNamed(context, SudaniAdSlPage.pageName);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
