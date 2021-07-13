import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/custom_icon_button.dart';
import 'package:ZoalPay/lang/Localization.dart';
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
                  CardWithImageAndText(
                      CustomIconButton(() {
                        Navigator.pushNamed(
                            context, TransferCardToCardPage.pageName);
                      }, Icons.person_add),
                      Text(
                          Localization.of(context)
                              .getTranslatedValue("Transfer Card to Card"),
                          style: TextStyle(color: Colors.red),
                          textScaleFactor: 1.2)),
                  SizedBox(
                    width: width - (2 * width / 2.01),
                  ),
                  CardWithImageAndText(
                      CustomIconButton(() {
                        Navigator.pushNamed(context, VoucherPage.pageName);
                      }, Icons.card_giftcard_rounded),
                      Text(
                        Localization.of(context).getTranslatedValue("Voucher"),
                        style: TextStyle(color: Colors.red),
                        textScaleFactor: 1.2,
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
