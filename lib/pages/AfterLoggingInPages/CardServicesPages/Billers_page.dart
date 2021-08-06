import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/custom_icon_button.dart';
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
                mainAxisAlignment: rowAllignment,
                children: [
                  ServiceWidget(
                    imageName: "voucher1.png",
                    text: "Safir",
                    onpressed: () {
                      Navigator.pushNamed(context, SafirPage.pageName);
                    },
                  ),
                  ServiceWidget(
                    imageName: "e invoice.png",
                    text: "TUTIA",
                    onpressed: () {
                      Navigator.pushNamed(context, TUTIAPage.pageName);
                    },
                  ),
                ],
              ),

              //second row
              Row(
                mainAxisAlignment: rowAllignment,
                children: [
                  ServiceWidget(
                    imageName: "e15.png",
                    text: "Mint Payment",
                    onpressed: () {
                      Navigator.pushNamed(context, MintPaymentPage.pageName);
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
