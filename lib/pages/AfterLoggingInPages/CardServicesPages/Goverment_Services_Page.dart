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
                  ServiceWidget(
                    imageName: "biller.png",
                    text: "customsServices",
                    onpressed: () {
                      Navigator.pushNamed(context, Customs.pageName);
                    },
                  ),
                  ServiceWidget(
                    imageName: "e15.png",
                    text: "E15",
                    onpressed: () {
                      Navigator.pushNamed(context, E15.pageName);
                    },
                  ),
                ],
              ),

              //second row
              Row(
                mainAxisAlignment: rowAllignment,
                children: [
                  ServiceWidget(
                    imageName: "education.png",
                    text: "Higher Education",
                    onpressed: () {
                      Navigator.pushNamed(context, HigherEducation.pageName);
                    },
                  ),
                  ServiceWidget(
                    imageName: "e invoice.png",
                    text: "E-Invoice",
                    onpressed: () {
                      Navigator.pushNamed(context, EInvoicePage.pageName);
                    },
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
