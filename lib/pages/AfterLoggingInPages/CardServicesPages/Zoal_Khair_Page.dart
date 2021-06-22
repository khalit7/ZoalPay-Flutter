import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class ZoalKhairPage extends StatefulWidget {
  static final pageName = "ZoalKhairPage";

  @override
  _ZoalKhairPageState createState() => _ZoalKhairPageState();
}

class _ZoalKhairPageState extends State<ZoalKhairPage> {
  CardModel selectedCard;

  PayeeModel selectedPayee;

  var _cardNameController = TextEditingController();

  var _controller2 = TextEditingController();

  var _amountController = TextEditingController();

  var _commentController = TextEditingController();

  var _ipinController = TextEditingController();
  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            Localization.of(context).getTranslatedValue("Zoal Khair"),
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
                    onChanged: (string) {},
                    onSubmitted: (string) {},
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                        errorText: selectedCard == null
                            ? "Please select a card"
                            : null,
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
                    controller: _controller2,
                    onChanged: (string) {},
                    onSubmitted: (string) {},
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                        labelText: Localization.of(context)
                            .getTranslatedValue("Reference"),
                        suffixIcon: PopupMenuButton<PayeeModel>(
                            itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                      child: Text(
                                          "1")), ///////// select the appropiate payee
                                  PopupMenuItem(child: Text("2")),
                                ],
                            onSelected: (value) {
                              selectedPayee = value;
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
                    controller: _amountController,
                    onChanged: (string) {},
                    onSubmitted: (string) {},
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _validate
                          ? amountValidError(_amountController.text.trim())
                          : null,
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
                      labelText: Localization.of(context)
                          .getTranslatedValue("Comment"),
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
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _validate
                          ? iPinValidError(_ipinController.text.trim())
                          : null,
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
              // validate everything
              setState(() {
                _validate = true;
              });

              if (selectedCard != null &&
                  isAmountValid(_amountController.text.trim()) &&
                  isIpinValid(_ipinController.text.trim())) {
                try {
                  showLoadingDialog(context);
                  //TODO: Make the API call here
                  Navigator.pop(context);
                  String date = DateFormat.yMd().format(DateTime.now());
                  //TODO: modify next line to put everything you need on the page.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionReceipt(
                                subTitle: "Zoal Khair",
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
        ));
  }
}
