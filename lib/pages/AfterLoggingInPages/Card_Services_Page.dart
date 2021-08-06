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
                        ServiceWidget(
                          imageName: 'scan.png',
                          text: "Scan & Pay",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, ScanAndPayPage.pageName);
                          },
                        ),
                        ServiceWidget(
                          imageName: 'qr.png',
                          text: "My QR",
                          onpressed: () {
                            Navigator.pushNamed(context, QRPage.pageName);
                          },
                        ),
                      ],
                    ),

                    // //second row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        ServiceWidget(
                          imageName: "telecom.png",
                          text: "Telecom Services",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, TelecomSevicesPage.pageName);
                          },
                        ),
                        ServiceWidget(
                          imageName: "elec.png",
                          text: "Electricity Services",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, ElectricityServicesPage.pageName);
                          },
                        )
                      ],
                    ),

                    // //third row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        ServiceWidget(
                          imageName: "gov.png",
                          text: "Goverment Services",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, GovermentServices.pageName);
                          },
                        ),
                        ServiceWidget(
                          imageName: "money-transfer.png",
                          text: "Money Transfer",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, MoneyTransferPage.pageName);
                          },
                        ),
                      ],
                    ),

                    // //fourth row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        ServiceWidget(
                          imageName: "charity.png",
                          text: "Zoal Khair",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, ZoalKhairPage.pageName);
                          },
                        ),
                        ServiceWidget(
                          imageName: "e15.png",
                          text: "Dal Payment",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, DalPaymentPage.pageName);
                          },
                        ),
                      ],
                    ),

                    // //fifth row
                    Row(
                      mainAxisAlignment: rowAllignment,
                      children: [
                        ServiceWidget(
                          imageName: "billers.png",
                          text: "Billers",
                          onpressed: () {
                            Navigator.pushNamed(context, BillerSPage.pageName);
                          },
                        ),
                        ServiceWidget(
                          imageName: "Entertainment.png",
                          text: "Entertainment",
                          onpressed: () {
                            Navigator.pushNamed(
                                context, EntertainmentPage.pageName);
                          },
                        ),
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
