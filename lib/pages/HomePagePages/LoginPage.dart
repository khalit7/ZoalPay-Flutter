import 'package:ZoalPay/Widgets/Cusom_Typical_Page.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/Card_Services_Page.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  static final pageName = "LoginPage";
  build(context) {
    return BasicPage(
        Localization.of(context).getTranslatedValue("Login"),
        Localization.of(context).getTranslatedValue(
            "An SMS will be sent to verify your phone number"),
        Localization.of(context).getTranslatedValue("Phone Number"),
        Localization.of(context).getTranslatedValue("LOGIN"), () {
      Navigator.pushNamed(context, CardServicesPage.pageName);
    }, true);
  }
}
