import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/material.dart';

class MobileTopUpPage extends StatelessWidget {
  static final pageName = "MobileTopUpPage";
  CardModel selectedCard;
  PayeeModel selectedOperator;
  var _cardNameController = TextEditingController();
  var _operatorController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _amountController = TextEditingController();
  var _commentController = TextEditingController();
  var _IpinController = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Mobile TOPUP"),
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
                  onChanged: (value) {
                    _cardNameController.text = selectedCard.cardUserName ?? "";
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
                  controller: _operatorController,
                  onChanged: (string) {
                    _operatorController.text = selectedOperator.payeeName ?? "";
                  },
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: Localization.of(context)
                          .getTranslatedValue("operator"),
                      suffixIcon: PopupMenuButton<PayeeModel>(
                          itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  child: Text(zainTopUpPayeeModel.payeeName),
                                  value: zainTopUpPayeeModel,
                                ),
                                PopupMenuItem(
                                  child: Text(mtnTopUpPayeeModel.payeeName),
                                  value: mtnTopUpPayeeModel,
                                ),
                                PopupMenuItem(
                                  child: Text(sudaniTopUpPayeeModel.payeeName),
                                  value: sudaniTopUpPayeeModel,
                                )
                              ],
                          onSelected: (value) {
                            selectedOperator = value;
                            _operatorController.text =
                                selectedOperator.payeeName;
                          },
                          icon: Icon(Icons.arrow_drop_down))),
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
                  controller: _IpinController,
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
            } else if (selectedOperator == null) {
              //TODO: notify user to selec operator
              print("please select an operator");
            } else if (!isPhoneNumbervalid(
                _phoneNumberController.text.trim())) {
              //TODO: notify user to enter valid phone number
              print("Please enter a valid phone number ");
            } else if (!isAmountValid(_amountController.text.trim())) {
              print(_amountController.text.trim());
              //TODO: notify user to enter valid amount
              print("Please enter a valid amount ");
              print(isAmountValid(_amountController.text.trim()));
            } else if (!isIpinValid(_IpinController.text.trim())) {
              //TODO: notify user to enter a valid IPIN
              print("please enter a valid IPIN");
            } else {
              // attempt the transaction
              try {
                showLoadingDialog(context);

                String cardNumber = await context.read<ApiService>().payBill(
                    selectedCard,
                    _IpinController.text.trim(),
                    int.parse(_amountController.text.trim()),
                    selectedOperator,
                    _phoneNumberController.text.trim(),
                    _commentController.text.trim());
                String date = DateTime.now().toString().substring(0,
                    19); // this is to formate date time from UTZ to yy-mm-dd-hh-m-ss

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "Mobile TOPUP",
                              transactionValue: _amountController.text.trim(),
                              pageDetails: {
                                "Card Number": cardNumber,
                                "Amount": _amountController.text.trim(),
                                "Phone Number":
                                    _phoneNumberController.text.trim(),
                                "Date": date,
                                "Comment": _commentController.text.trim()
                              },
                            )));

                // parameters to pass already ready : _amountController.text.trim() , _phoneNumberController.text.trim() ,  _commentController.text.trim()
                // parameters to pass comming from api request : card number , current balance
                // navigate to the recipt page.
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => TransactionDetails(
                //           balance: balanceAndPan[0],
                //           cardNumber: balanceAndPan[1]),
                //     ));
              } catch (e) {
                // remmber to handle the case where a wrong IPIN is entered
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
