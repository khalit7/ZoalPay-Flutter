import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/custom_icon_button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/GovermentServicesPages/E-Invoice_page.dart';
import 'package:flutter/material.dart';

import 'GovermentServicesPages/Customs_Page.dart';
import 'GovermentServicesPages/E15_Page.dart';
import 'GovermentServicesPages/Higher_Eduction_Page.dart';

class GovermentServices extends StatelessWidget {
  static final pageName = "GovermentServices";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            Localization.of(context).getTranslatedValue("Goverment Services")),
      ),
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
                        Navigator.pushNamed(context, Customs.pageName);
                      }, Icons.supervisor_account_outlined),
                      Text(
                          Localization.of(context)
                              .getTranslatedValue("customsServices"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                  CardWithImageAndText(
                      CustomIconButton(() {
                        Navigator.pushNamed(context, E15.pageName);
                      }, Icons.card_membership_sharp),
                      Text(
                        Localization.of(context).getTranslatedValue("E15"),
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
                        Navigator.pushNamed(context, HigherEducation.pageName);
                      }, Icons.cast_for_education),
                      Text(
                          Localization.of(context)
                              .getTranslatedValue("Higher Education"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                  CardWithImageAndText(
                      CustomIconButton(() {
                        Navigator.pushNamed(context, EInvoicePage.pageName);
                      }, Icons.euro_symbol_rounded),
                      Text(
                        Localization.of(context)
                            .getTranslatedValue("E-Invoice"),
                        style: TextStyle(color: Colors.red),
                        textScaleFactor: 1.2,
                      ))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
