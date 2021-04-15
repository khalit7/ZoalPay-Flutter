import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/provider/api_services.dart';
//import 'package:ZoalPay/lang/Localization.dart';
//
import 'package:ZoalPay/utils/constants.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ZoalPay/pages/AfterLoggingInPages/Card_Services_Page.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class ValidateOtpPage extends StatefulWidget {
  static final pageName = "ValidateOtpPage";
  //final otpType currentOtpType;
  final String phoneNumber;

  ValidateOtpPage({this.phoneNumber});

  @override
  _ValidateOtpPageState createState() => _ValidateOtpPageState();
}

class _ValidateOtpPageState extends State<ValidateOtpPage> with CodeAutoFill {
  final _otpController = TextEditingController();
  String appSignature;

  String otpCode;

  @override
  void codeUpdated() {
    otpCode = code;
    print("this is the otp code " + otpCode);
    print(appSignature);
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Validate OTP"),
      ),
      body: Container(
          width: width,
          height: height / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  child: Text(
                    "Please enter the verfication code sent in SMS ",
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
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    enableActiveFill: false,
                    controller: _otpController,
                    onCompleted: (code) async {
                      // validate otp
                      try {
                        await Provider.of<ApiService>(context, listen: false)
                            .validateOtp(
                                widget.phoneNumber, _otpController.text);
                        // if isverfied ... redirect to card services page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardServicesPage(),
                            ));
                      } on ApiExceptions.WrongOtp catch (e) {
                        //TODO:Notify user that the otp code entered is wrong
                        print(e.toString());
                      }
                    },
                    onChanged: (code) {},
                  ),
                ),
              ]),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 4.2, height / 40, width / 4.2, 0),
                  child: SubmitButton(() {}))
            ],
          )),
    );
  }
}
