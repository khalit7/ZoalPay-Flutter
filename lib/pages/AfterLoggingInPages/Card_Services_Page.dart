import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/custom_icon_button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Billers_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Entertainment_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Page.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'CardServicesPages/Dal_Payment_Page.dart';
import 'CardServicesPages/Electrictiy_Services_Page.dart';
import 'CardServicesPages/Goverment_Services_Page.dart';
import 'CardServicesPages/QR_Page.dart';
import 'CardServicesPages/Scan_&_Pay_Page.dart';
import 'CardServicesPages/Telecom_Services_Page.dart';
import 'CardServicesPages/Zoal_Khair_Page.dart';

//color the text
class CardServicesPage extends StatelessWidget {
  static final pageName = "CardServicesPage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MainAxisAlignment rowAllignment = MainAxisAlignment.spaceEvenly;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text(
              Localization.of(context).getTranslatedValue("Card Services"),
            ),
          ),
          body: Stack(
            children: [
              Container(color: Colors.grey[200]),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: rowAllignment,
                  children: [
                    //first row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, ScanAndPayPage.pageName);
                            }, Icons.scanner),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Scan & Pay"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(context, QRPage.pageName);
                            }, Icons.crop_free_rounded),
                            Text(
                              Localization.of(context)
                                  .getTranslatedValue("My QR"),
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
                              Navigator.pushNamed(
                                  context, TelecomSevicesPage.pageName);
                            }, Icons.phone),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Telecom Services"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, ElectricityServicesPage.pageName);
                            }, Icons.bolt),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Electricity Services"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                      ],
                    ),

                    //third row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, GovermentServices.pageName);
                            }, Icons.work),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Goverment Services"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, MoneyTransferPage.pageName);
                            }, Icons.attach_money),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Money Transfer"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                      ],
                    ),

                    //fourth row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, ZoalKhairPage.pageName);
                            }, Icons.volunteer_activism),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Zoal Khair"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, DalPaymentPage.pageName);
                            }, Icons.payment_outlined),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Dal Payment"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                      ],
                    ),

                    //fifth row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, BillerSPage.pageName);
                            }, Icons.storefront_rounded),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Billers"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                        CardWithImageAndText(
                            CustomIconButton(() {
                              Navigator.pushNamed(
                                  context, EntertainmentPage.pageName);
                            }, Icons.tag_faces_sharp),
                            Text(
                                Localization.of(context)
                                    .getTranslatedValue("Entertainment"),
                                style: TextStyle(color: Colors.red),
                                textScaleFactor: 1.2)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
