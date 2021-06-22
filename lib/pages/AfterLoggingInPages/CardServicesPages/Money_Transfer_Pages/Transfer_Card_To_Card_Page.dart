import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Confirm_transfer_page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Scan_&_Pay_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferCardToCardPage extends StatefulWidget {
  static final pageName = "TransferCardToCardPage";
  String reciverPan = "";
  TransferCardToCardPage({this.reciverPan});

  @override
  _TransferCardToCardPageState createState() => _TransferCardToCardPageState();
}

class _TransferCardToCardPageState extends State<TransferCardToCardPage> {
  CardModel selectedCard;

  var _reciverCardNumberController = TextEditingController();

  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    _reciverCardNumberController.text = widget.reciverPan;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Transfer Card to Card"),
        ),
      ),
      body: ListView(
        children: [
          //first field text
          SizedBox(
            height: height / 40,
          ),
          Row(
            children: [
              SizedBox(
                width: width / 15,
              ),
              SizedBox(
                width: width - (width / 15),
                child: TextField(
                  controller: _reciverCardNumberController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getTranslatedValue("To Card"),
                    errorText: _validate
                        ? cardNumberValidError(
                            _reciverCardNumberController.text.trim())
                        : null,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.qr_code_scanner_sharp,
                            color: Colors.red,
                          ),
                          // scan barcode Icon
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, ScanAndPayPage.pageName);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 40,
          ),
          SubmitButton(() async {
            setState(() {
              _validate = true;
            });
            if (isCardNumberValid(_reciverCardNumberController.text.trim()))
              // attempt transaction
              try {
                showLoadingDialog(context);
                Map<String, String> receiver_card_details = {
                  "Account No": "1234",
                  "Name": "khalid adil",
                  "Bank": "Bank of Khartoum",
                };

                // make the call
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmTransferPage(
                            cardDetails: receiver_card_details)));
              } catch (e) {
                //remove loading screen
                Navigator.pop(context);
                //TODO:notify user that somthing went wrong
                print(e);
                print("somthing went wrong");
              }
          })
        ],
      ),
    );
  }
}
