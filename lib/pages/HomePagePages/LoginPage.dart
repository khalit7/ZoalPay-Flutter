import 'package:ZoalPay/Widgets/Custom_Flat_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/constants.dart';
import 'package:ZoalPay/pages/HomePagePages/validate_otp_page.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final pageName = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final _phoneNumberController = TextEditingController();

    var appBar = AppBar(
        title: Text(Localization.of(context).getTranslatedValue("LOGIN")));
    height -= appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: Container(
          width: width,
          height: height / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  child: Text(
                    Localization.of(context).getTranslatedValue(
                        "An SMS will be sent to verify your phone number"),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                  ),
                  padding: EdgeInsets.fromLTRB(
                      width / 9, height / 30, width / 9, 0)),
              SizedBox(
                height: height / 12,
              ),
              Row(children: [
                SizedBox(
                  width: width / 15,
                ),
                SizedBox(
                  width: width - (width / 15),
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: Localization.of(context)
                          .getTranslatedValue("Phone Number"),
                    ),
                  ),
                ),
              ]),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 4.2, height / 40, width / 4.2, 0),
                  child: CustomFlatButton1(width, height,
                      Localization.of(context).getTranslatedValue("Login"),
                      () async {
                    // check if the phone number is valid
                    if (isPhoneNumbervalid(
                        _phoneNumberController.text.trim())) {
                      //valid phone number
                      //send otp message and go to validate otp page.
                      try {
                        // await context.read<ApiService>().sendOtp(
                        //     _phoneNumberController.text.trim(), otpType.login);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ValidateOtpPage(
                                  phoneNumber:
                                      _phoneNumberController.text.trim()),
                            ));
                      } on ApiExceptions.UserDosNotExists catch (e) {
                        //TODO:notify user that user dosn't exist .. try signing up
                        print(e.toString());
                      }
                      // Navigator.pushNamed(context, ValidateOtpPage.pageName);
                    } else {
                      //invalid phone number
                      //TODO:notify user that the phone number is invalid
                      print("invalid phone number !!");
                    }
                  }, 1500, 18.0))
            ],
          )),
    );
  }
}
