import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/custom_icon_button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Confirm_transfer_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Transfer_Card_To_Card_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Voucher_Page.dart';
import 'package:flutter/material.dart';

class MoneyTransferPage extends StatelessWidget {
  static final pageName = "MoneyTransferPage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(Localization.of(context).getTranslatedValue("Money Transfer")),
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
                    imageName: "card to card.png",
                    text: "Transfer Card to Card",
                    onpressed: () {
                      Navigator.pushNamed(
                          context, TransferCardToCardPage.pageName);
                    },
                  ),
                  ServiceWidget(
                    imageName: "voucher1.png",
                    text: "Voucher",
                    onpressed: () {
                      Navigator.pushNamed(context, VoucherPage.pageName);
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
