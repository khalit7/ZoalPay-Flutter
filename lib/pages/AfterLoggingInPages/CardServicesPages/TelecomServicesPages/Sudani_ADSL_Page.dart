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

class SudaniAdSlPage extends StatelessWidget {
  static final pageName = "SudaniAdSlPage";
  CardModel selectedCardTab1;
  CardModel selectedCardTab2;
  var _cardNameControllerTab2 = TextEditingController();
  var _phoneNumberControllerTab2 = TextEditingController();
  var _amountController = TextEditingController();
  var _ipinControllerTab1 = TextEditingController();
  var _cardNameControllerTab1 = TextEditingController();
  var _phoneNumberControllerTab1 = TextEditingController();
  var _ipinControllerTab2 = TextEditingController();
//TODO:second tab
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            Localization.of(context).getTranslatedValue("Sudani ADSL"),
          ),
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: height / 15,
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          Localization.of(context)
                              .getTranslatedValue("BILL INQUIRY"),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Tab(
                          child: Text(
                              Localization.of(context)
                                  .getTranslatedValue("Sudani ADSL"),
                              style: TextStyle(color: Colors.red)))
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    //first tab
                    ListView(
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
                                controller: _cardNameControllerTab1,
                                onChanged: (value) {
                                  _cardNameControllerTab1.text =
                                      selectedCardTab1.cardUserName ?? "";
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
                                                      child: Text(
                                                          card.cardUserName),
                                                      value: card,
                                                    ))
                                                .toList(),
                                        onSelected: (value) {
                                          selectedCardTab1 = value;
                                          _cardNameControllerTab1.text =
                                              selectedCardTab1.cardUserName;
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
                                controller: _phoneNumberControllerTab1,
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
                                controller: _ipinControllerTab1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("IPIN"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        SubmitButton(() async {
                          if (selectedCardTab1 == null) {
                            // TODO:notify user to select a card
                            print("please select a card");
                          } else if (!isPhoneNumbervalid(
                              _phoneNumberControllerTab1.text.trim())) {
                            //TODO: notify user to enter valid phone number
                            print("Please enter a valid phone number ");
                          } else if (!isIpinValid(
                              _ipinControllerTab1.text.trim())) {
                            //TODO: notify user to enter a valid IPIN
                            print("please enter a valid IPIN");
                          } else {
                            // attempt bill inquiry
                            try {
                              await context.read<ApiService>().getBill(
                                  selectedCardTab1,
                                  _phoneNumberControllerTab1.text.trim(),
                                  _ipinControllerTab1.text.trim(),
                                  sudaniBillPaymentPayeeModel);
                            } catch (e) {
                              // handle error
                            }
                          }
                        })
                      ],
                    ),

                    ListView(
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
                                controller: _cardNameControllerTab2,
                                onChanged: (value) {
                                  _cardNameControllerTab2.text =
                                      selectedCardTab2.cardUserName ?? "";
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
                                                      child: Text(
                                                          card.cardUserName),
                                                      value: card,
                                                    ))
                                                .toList(),
                                        onSelected: (value) {
                                          selectedCardTab2 = value;
                                          _cardNameControllerTab2.text =
                                              selectedCardTab2.cardUserName;
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
                                controller: _phoneNumberControllerTab2,
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
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Amount"),
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
                                controller: _ipinControllerTab2,
                                onChanged: (string) {},
                                onSubmitted: (string) {},
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("IPIN"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        SubmitButton(() async {
                          if (selectedCardTab2 == null) {
                            // TODO:notify user to select a card
                            print("please select a card");
                          } else if (!isPhoneNumbervalid(
                              _phoneNumberControllerTab2.text.trim())) {
                            //TODO: notify user to enter valid phone number
                            print("Please enter a valid phone number ");
                          } else if (!isAmountValid(
                              _amountController.text.trim())) {
                            //TODO: notify user to enter a valid amount
                            print("Please enter a valid amount ");
                          } else if (!isIpinValid(
                              _ipinControllerTab2.text.trim())) {
                            //TODO: notify user to enter a valid IPIN
                            print("please enter a valid IPIN");
                          } else {
                            try {
                              showLoadingDialog(context);
                              String cardNum = await context
                                  .read<ApiService>()
                                  .payBill(
                                      selectedCardTab2,
                                      _ipinControllerTab2.text.trim(),
                                      int.parse(_amountController.text.trim()),
                                      sudaniBillPaymentPayeeModel,
                                      _phoneNumberControllerTab2.text.trim(),
                                      ""); // make sure that there is no comment interface in this page
                              String date = DateTime.now().toString().substring(
                                  0,
                                  19); // this is to formate date time from UTZ to yy-mm-dd-hh-m-ss
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionReceipt(
                                            subTitle:
                                                "Sudani ADSL bill Payment",
                                            transactionValue:
                                                _amountController.text.trim(),
                                            pageDetails: {
                                              "Card Number": cardNum,
                                              "Amount":
                                                  _amountController.text.trim(),
                                              "Phone Number":
                                                  _phoneNumberControllerTab2
                                                      .text
                                                      .trim(),
                                              "Date": date,
                                            },
                                          )));
                            } catch (e) {
                              Navigator.pop(context);
                              // handle error
                            }
                          }
                        })
                      ],
                    ),
                  ]),
                )
              ],
            )));
  }
}
