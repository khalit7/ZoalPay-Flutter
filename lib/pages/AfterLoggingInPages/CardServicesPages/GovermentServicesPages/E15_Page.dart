import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class E15 extends StatelessWidget {
  static final pageName = "E15";
  CardModel selectedCard;
  var _cardNameController = TextEditingController();
  var _invoiceNumberController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _amountController = TextEditingController();
  var _commentController = TextEditingController();
  var _ipinController = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("E15"),
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
                  controller: _invoiceNumberController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText: Localization.of(context)
                        .getTranslatedValue("Invoice Number"),
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
          //fifth field text
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
                  controller: _commentController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getTranslatedValue("Comment"),
                  ),
                ),
              ),
            ],
          ),
          //sixth field text
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
          SubmitButton(() {
            if (selectedCard == null) {
              // TODO:notify user to select a card
              print("please select a card");
              // } else if (!isPhoneNumbervalid(
              //     _phoneNumberController.text.trim())) {
              //   //TODO: notify user to enter valid phone number
              //   print("Please enter a valid phone number ");
              // } else if (!isAmountValid(_amountController.text.trim())) {
              //   //TODO: notify user to enter a valid amount
              //   print("amount is not valid");
              // } else if (!isIpinValid(_ipinController.text.trim())) {
              //   //TODO: notify user to enter a valid IPIN
              //   print("please enter a valid IPIN");
              // } else {
              try {
                showLoadingDialog(context);
                // attempt the api call
                Navigator.pop(context);
                String date = DateFormat.yMd().format(DateTime.now());
                //TODO: modify next line to put everything you need on the page.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "E 15",
                              transactionValue: _amountController.text.trim(),
                              pageDetails: {
                                "Card Number": "123123123",
                                "Amount": _amountController.text.trim(),
                                "Date": date,
                                "Comment": _commentController.text.trim()
                              },
                            )));
              } catch (e) {}
            }
          })
        ],
      ),
    );
  }
}
