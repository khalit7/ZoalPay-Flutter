import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class CardBalancePage extends StatefulWidget {
  static final pageName = "CardBalancePage";

  @override
  _CardBalancePageState createState() => _CardBalancePageState();
}

class _CardBalancePageState extends State<CardBalancePage> {
  CardModel selectedCard;

  var _cardNameController = TextEditingController();

  var _IPINController = TextEditingController();

  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu_outlined),
            ),
            SizedBox(width: width / 15),
            Text(
              Localization.of(context).getTranslatedValue("Card Balance"),
            ),
          ],
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
                      errorText:
                          selectedCard == null ? "Please select a card" : null,
                      labelText: Localization.of(context)
                          .getTranslatedValue("Card Name"),
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
                  controller: _IPINController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: _validate
                        ? iPinValidError(_IPINController.text.trim())
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
          //submit button
          SubmitButton(() async {
            setState(() {
              _validate = true;
            });
            if (selectedCard != null &&
                isIpinValid(_IPINController.text.trim())) {
              // card number selected + valid Ipin .. attempt the transaction
              try {
                showLoadingDialog(context);
                //TODO:pass the card number
                String balance = await context
                    .read<ApiService>()
                    .getBalance(selectedCard, _IPINController.text.trim());
                Navigator.pop(context);
                String date = DateTime.now().toString().substring(0,
                    19); // this is to formate date time from UTZ to yy-mm-dd-hh-m-ss
                print("going to the balance page");
                // navigate to the recipt page.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "Balance",
                              transactionValue: balance,
                              pageDetails: {
                                "Card Number":
                                    concealCardNumber(selectedCard.cardNumber),
                                "Date": date
                              },
                            )));
              } on ApiExceptions.InvalidIpin catch (e) {
                Navigator.pop(context);
                showErrorWidget(context, "Wrong IPIN, please try again");
              } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                Navigator.pop(context);
                showErrorWidget(context,
                    "PIN tries limit exceeded, please try again later");
              } on ApiExceptions.InvalidCard catch (e) {
                Navigator.pop(context);
                showErrorWidget(context, "Invalid Card");
              } catch (e) {
                //remove loading screen
                Navigator.pop(context);
                showErrorWidget(context, "Please try again later");
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
