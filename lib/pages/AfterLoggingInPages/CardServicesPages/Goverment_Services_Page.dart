import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
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
                children: [
                  CardWithImageAndText(
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Customs.pageName);
                          },
                          icon: Icon(Icons.supervisor_account_outlined,
                              color: Colors.red),
                          iconSize: width / 3),
                      Text(
                          Localization.of(context)
                              .getTranslatedValue("customsServices"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                  CardWithImageAndText(
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, E15.pageName);
                        },
                        icon: Icon(Icons.card_membership_sharp,
                            color: Colors.red),
                        iconSize: width / 3,
                      ),
                      Text(
                        Localization.of(context).getTranslatedValue("E15"),
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
                                context, HigherEducation.pageName);
                          },
                          icon:
                              Icon(Icons.cast_for_education, color: Colors.red),
                          iconSize: width / 3),
                      Text(
                          Localization.of(context)
                              .getTranslatedValue("Higher Education"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                  CardWithImageAndText(
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, EInvoicePage.pageName);
                        },
                        icon:
                            Icon(Icons.euro_symbol_rounded, color: Colors.red),
                        iconSize: width / 3,
                      ),
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
