import 'package:ZoalPay/Widgets/Cusom_Typical_Page.dart';
import 'package:ZoalPay/lang/Localization.dart';

import 'package:flutter/cupertino.dart';

class NewAccountPage extends StatelessWidget {
  static final pageName = "NewAccountPage";
  build(context) {
    return BasicPage(
        Localization.of(context).getTranslatedValue("Signup"),
        Localization.of(context).getTranslatedValue(
            "An SMS will be sent to verify your phone number"),
        Localization.of(context).getTranslatedValue("Phone Number"),
        Localization.of(context).getTranslatedValue("SIGNUP"),
        () {},
        false);
  }
}
