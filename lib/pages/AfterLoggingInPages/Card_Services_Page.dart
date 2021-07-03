import 'package:ZoalPay/Widgets/Card_With_Image_And_Text.dart';
import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
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
              ListView(
                children: [
                  //first row
                  Row(
                    children: [
                      CardWithImageAndText(
                          IconButton(
                              highlightColor: Colors.red,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ScanAndPayPage.pageName);
                              },
                              icon: Icon(Icons.scanner, color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Scan & Pay"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                      SizedBox(
                        width: width - (2 * width / 2.01),
                      ),
                      CardWithImageAndText(
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, QRPage.pageName);
                            },
                            icon: Icon(Icons.crop_free_rounded,
                                color: Colors.red),
                            iconSize: width / 4,
                          ),
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
                    children: [
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, TelecomSevicesPage.pageName);
                              },
                              icon: Icon(Icons.phone, color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Telecom Services"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                      SizedBox(
                        width: width - (2 * width / 2.01),
                      ),
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ElectricityServicesPage.pageName);
                              },
                              icon: Icon(Icons.bolt, color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Electricity Services"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                    ],
                  ),

                  //third row
                  Row(
                    children: [
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, GovermentServices.pageName);
                              },
                              icon: Icon(Icons.work, color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Goverment Services"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                      SizedBox(
                        width: width - (2 * width / 2.01),
                      ),
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MoneyTransferPage.pageName);
                              },
                              icon: Icon(Icons.attach_money_sharp,
                                  color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Money Transfer"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                    ],
                  ),

                  //fourth row
                  Row(
                    children: [
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ZoalKhairPage.pageName);
                              },
                              icon: Icon(Icons.volunteer_activism,
                                  color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Zoal Khair"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                      SizedBox(
                        width: width - (2 * width / 2.01),
                      ),
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, DalPaymentPage.pageName);
                              },
                              icon: Icon(Icons.payment_outlined,
                                  color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Dal Payment"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                    ],
                  ),

                  //fifth row
                  Row(
                    children: [
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, BillerSPage.pageName);
                              },
                              icon: Icon(Icons.storefront_rounded,
                                  color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Billers"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                      SizedBox(
                        width: width - (2 * width / 2.01),
                      ),
                      CardWithImageAndText(
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, EntertainmentPage.pageName);
                              },
                              icon: Icon(Icons.tag_faces_sharp,
                                  color: Colors.red),
                              iconSize: width / 4),
                          Text(
                              Localization.of(context)
                                  .getTranslatedValue("Entertainment"),
                              style: TextStyle(color: Colors.red),
                              textScaleFactor: 1.2)),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
