import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  static final pageName = "AboutUsPage";

  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).getTranslatedValue("About Us")),
      ),
    );
  }
}
