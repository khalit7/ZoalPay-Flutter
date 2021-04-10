import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/lang/Localization.dart';
import "package:flutter/material.dart";

class EntertainmentPage extends StatelessWidget {
  static final pageName = "EntertainmentPage";
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Entertainment"),
        ),
      ),
      body: AlertDialog(
        content: Text("Comming Soon"),
      ),
    );
  }
}
