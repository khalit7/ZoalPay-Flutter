import 'package:ZoalPay/Widgets/Custom_Flat_Button.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/About_Us_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Card_Balance_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Card_Details_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Change_IPIN_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Entertainment_Card_History_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Favourites_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Generate_IPIN_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/Transaction_History_Page.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../zoalPayApp.dart';

class CustomDrawer extends StatelessWidget {
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        height: height,
        decoration: BoxDecoration(color: Colors.red),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //image
            SizedBox(
              height: height / 50,
            ),
            Container(
              child: IconButton(
                iconSize: width * height / 3000,
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {},
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            //number
            SizedBox(
              height: height / 50,
            ),
            Center(
              child: Text(
                "0922228139",
                style: TextStyle(color: Colors.white),
              ),
            ),
            //language buttons
            SizedBox(
              height: height / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFlatButton3(width, height, "ع", () {
                  MyApp.setLocale(context, Locale('ar', 'SA'));
                }, 5500, 30.0),
                SizedBox(
                  width: width / 50,
                ),
                CustomFlatButton3(width, height, "EN", () {
                  MyApp.setLocale(context, Locale('en', 'US'));
                }, 5500, 30.0),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            // Generate IPIN
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, GenerateIPINPage.pageName);
              },
              leading: Icon(Icons.handyman, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("Generate IPIN"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Card Deatails
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, CardDetailsPage.pageName);
              },
              leading:
                  Icon(Icons.add_to_home_screen_sharp, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("Card Details"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Card Balance
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, CardBalancePage.pageName);
              },
              leading: Icon(Icons.table_chart_outlined, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("Card Balance"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Change IPIN"
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, ChangeIPINPage.pageName);
              },
              leading: Icon(Icons.vpn_key_sharp, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("Change IPIN"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Favorites
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, FavouritesPage.pageName);
              },
              leading: Icon(Icons.favorite_sharp, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("Favourites"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Transaction History
            ListTile(
              onTap: () async {
                showLoadingDialog(context);
                List allTransactions =
                    await context.read<ApiService>().getTransactionHistory();
                Navigator.pop(context);
                // Navigator.popAndPushNamed(
                //     context, TransactionHistoryPage.pageName);
              },
              leading:
                  Icon(Icons.history_toggle_off_sharp, color: Colors.white),
              title: Text(
                Localization.of(context)
                    .getTranslatedValue("Transaction History"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Entertainment Card History
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(
                    context, EntertainmentCardHistoryPage.pageName);
              },
              leading:
                  Icon(Icons.history_toggle_off_sharp, color: Colors.white),
              title: Text(
                Localization.of(context)
                    .getTranslatedValue("Entertainment Card History"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // About Us
            ListTile(
              onTap: () {
                Navigator.popAndPushNamed(context, AboutUsPage.pageName);
              },
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("About Us"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
            // Log Out
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                Localization.of(context).getTranslatedValue("Log Out"),
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                height: height / 35,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
