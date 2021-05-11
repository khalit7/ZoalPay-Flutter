import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Scan_&_Pay_Page.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferCardToCardPage extends StatelessWidget {
  static final pageName = "TransferCardToCardPage";
  CardModel selectedCard;
  var _senderCardNameController = TextEditingController();
  var _reciverCardNumberController = TextEditingController();
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
                  controller: _senderCardNameController,
                  onChanged: (value) {
                    _senderCardNameController.text =
                        selectedCard.cardUserName ?? "";
                  },
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
                            _senderCardNameController.text =
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
                  controller: _reciverCardNumberController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getTranslatedValue("To Card"),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PopupMenuButton<CardModel>(
                            itemBuilder: (BuildContext context) =>
                                CardModel.allCards
                                    .map((card) => PopupMenuItem(
                                          child: Text(card.cardUserName),
                                          value: card,
                                        ))
                                    .toList(),
                            onSelected: (value) {
                              _reciverCardNumberController.text =
                                  value.cardNumber;

                              print("${value.cardNumber}");
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        IconButton(
                          // icon: Icon(
                          //   Icons.qr_code_scanner_sharp,
                          //   color: Colors.red,
                          // ),
                          icon: Icon(Icons
                              .ac_unit), // replace this with the above comment
                          onPressed: () {
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
            // validate everything
            if (selectedCard == null) {
              // TODO:notify user to select a card
              print("please select a card");
            } else if (!isCardNumberValid(
                _reciverCardNumberController.text.trim())) {
              //TODO: notify user to enter a valid 16 number card number
              print("please enter a valid 16 number card number");
              print(_reciverCardNumberController.text.trim());
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

                await context.read<ApiService>().cardTransfer(
                    selectedCard,
                    _reciverCardNumberController.text.trim(),
                    _ipinController.text.trim(),
                    int.parse(_amountController.text.trim()),
                    _commentController.text.trim());

                String date = DateFormat.yMd().format(DateTime.now());
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "Transfer Card To Card",
                              transactionValue: _amountController.text.trim(),
                              pageDetails: {
                                "Card Number":
                                    concealCardNumber(selectedCard.cardNumber),
                                "Amount": _amountController.text.trim(),
                                "To Card": concealCardNumber(
                                    _reciverCardNumberController.text.trim()),
                                "Date": date,
                                "Comment": _commentController.text.trim()
                              },
                            )));
              } catch (e) {
                //remove loading screen
                Navigator.pop(context);
                //TODO:notify user that somthing went wrong
                print(e);
                print("somthing went wrong");
              }
            }
          })
        ],
      ),
    );
  }
}
