import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
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

class ConfirmTransferPage extends StatefulWidget {
  static final pageName = "ConfirmTransferPage";
  Map<String, String> cardDetails;

  ConfirmTransferPage({this.cardDetails});

  @override
  _ConfirmTransferPageState createState() => _ConfirmTransferPageState();
}

class _ConfirmTransferPageState extends State<ConfirmTransferPage> {
  CardModel selectedCard;

  var _senderCardNameController = TextEditingController();

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
          Localization.of(context).getTranslatedValue("Transfer Card to Card"),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height / 40,
          ),
          Divider(
            color: Colors.black,
            indent: 10,
            endIndent: 20,
            height: width * height / 5000,
          ),
          // card details

          ...widget.cardDetails.entries
              .map(
                (iteam) => Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * height / 7000, 0, width * height / 7000, 0),
                  child: Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(Localization.of(context)
                          .getTranslatedValue(iteam.key)),
                      trailing: Text("${iteam.value}"),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black26))),
                  ),
                ),
              )
              .toList(),
          //
          Divider(
            color: Colors.black,
            indent: 10,
            endIndent: 20,
            height: width * height / 5000,
          ),
          SizedBox(
            height: height / 40,
          ),
          //first field text
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
                      errorText:
                          selectedCard == null ? "Please select a card" : null,
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
          SubmitButton(() async {
            // validate everything
            setState(() {
              _validate = true;
            });
            if (selectedCard != null &&
                isAmountValid(_amountController.text.trim()) &&
                isIpinValid(_ipinController.text.trim())) {
              // attempt transaction
              try {
                showLoadingDialog(context);

                await context.read<ApiService>().cardTransfer(
                    selectedCard,
                    widget.cardDetails["Account No"],
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
                                    widget.cardDetails["Account No"]),
                                "Date": date,
                                "Comment": _commentController.text.trim()
                              },
                            )));
              } catch (e) {
                //remove loading screen
                Navigator.pop(context);
                showErrorWidget(
                    context, "Somthing went wrong, please try again later");
              }
            }
          })
        ],
      ),
    );
  }
}
