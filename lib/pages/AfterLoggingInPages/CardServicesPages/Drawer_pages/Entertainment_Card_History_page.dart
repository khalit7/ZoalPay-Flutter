import 'package:ZoalPay/lang/Localization.dart';
import 'package:flutter/material.dart';

class EntertainmentCardHistoryPage extends StatelessWidget {
  static final pageName = "EntertainmentCardHistoryPage";

  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context)
            .getTranslatedValue("Entertainment Card History")),
      ),
    );
  }
}
