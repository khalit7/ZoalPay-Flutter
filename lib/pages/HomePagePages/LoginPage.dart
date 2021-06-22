import 'package:ZoalPay/Widgets/Custom_Flat_Button.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
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
  final _phoneNumberController = TextEditingController();
  bool _validate = false;
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _validate
                          ? phoneNumbervalidError(
                              _phoneNumberController.text.trim())
                          : null,
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
                    setState(() {
                      _validate = true;
                    });
                    // check if the phone number is valid
                    if (isPhoneNumbervalid(
                        _phoneNumberController.text.trim())) {
                      //valid phone number
                      //send otp message and go to validate otp page.
                      try {
                        showLoadingDialog(context);
                        await context.read<ApiService>().sendOtp(
                            _phoneNumberController.text.trim(), otpType.login);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ValidateOtpPage(
                                  phoneNumber:
                                      _phoneNumberController.text.trim()),
                            ));
                      } on ApiExceptions.UserDosNotExists catch (e) {
                        Navigator.pop(context);
                        showErrorWidget(
                            context, "User dosn't exist, try signing up");
                      } catch (e) {
                        Navigator.pop(context);
                        showErrorWidget(context,
                            "Somthing went wrong, please try againg later");
                      }
                    }
                  }, 1500, 18.0))
            ],
          )),
    );
  }
}
