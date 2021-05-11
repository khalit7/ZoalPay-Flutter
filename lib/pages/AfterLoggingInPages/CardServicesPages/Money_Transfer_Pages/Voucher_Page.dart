import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoucherPage extends StatelessWidget {
  static final pageName = "VoucherPage";
  CardModel selectedCard;
  var _cardNameController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _amountController = TextEditingController();
  var _ipinController = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Voucher"),
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
                  controller: _cardNameController,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: Localization.of(context)
                          .getTranslatedValue("Card Number"),
                      suffixIcon: PopupMenuButton<CardModel>(
                          itemBuilder: (BuildContext context) =>
                              CardModel.allCards
                                  .map((card) => PopupMenuItem(
                                        child: Text(card.cardUserName),
                                        value: card,
                                      ))
                                  .toList(),
                          onSelected: (value) {
                            selectedCard = value;
                            _cardNameController.text =
                                selectedCard.cardUserName;
                            print("${value.cardNumber}");
                          },
                          icon: Icon(Icons.arrow_drop_down))),
                ),
              ),
            ],
          ),
          //second field text
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
                  controller: _phoneNumberController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText: Localization.of(context)
                        .getTranslatedValue("Phone Number"),
                  ),
                ),
              ),
            ],
          ),
          //third field text
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
                  controller: _amountController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getTranslatedValue("Amount"),
                  ),
                ),
              ),
            ],
          ),
          //fourth field text
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
                  controller: _ipinController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getTranslatedValue("IPIN"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 40,
          ),
          SubmitButton(() async {
            if (selectedCard == null) {
              // TODO:notify user to select a card
              print("please select a card");
            } else if (!isPhoneNumbervalid(
                _phoneNumberController.text.trim())) {
              //TODO: notify user to select a valid phone number
              print("please enter a valid phone number");
            } else if (!isAmountValid(_amountController.text.trim())) {
              print(_amountController.text.trim());
              //TODO: notify user to enter valid amount
              print("Please enter a valid amount ");
            } else if (!isIpinValid(_ipinController.text.trim())) {
              //TODO: notify user to enter a valid IPIN
              print("please enter a valid IPIN");
            } else {
              // attempt transaction
              try {
                showLoadingDialog(context);

                String voucherCode = await context
                    .read<ApiService>()
                    .generateVoucher(
                        selectedCard,
                        _ipinController.text.trim(),
                        int.parse(_amountController.text.trim()),
                        _phoneNumberController.text.trim());

                String date = DateFormat.yMd().format(DateTime.now());
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "Voucher",
                              transactionValue: _amountController.text.trim(),
                              pageDetails: {
                                "Voucher Code": "$voucherCode",
                                "Card Number":
                                    concealCardNumber(selectedCard.cardNumber),
                                "Amount": _amountController.text.trim(),
                                "Date": date,
                              },
                            )));
              } catch (e) {
                // pop loading screen
                Navigator.pop(context);
                //TODO : handle error
                print("somthing went wrong");
                print(e);
              }
            }
          })
        ],
      ),
    );
  }
}
