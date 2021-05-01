import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_details.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class CardBalancePage extends StatelessWidget {
  static final pageName = "CardBalancePage";
  CardModel selectedCard;
  var _cardNameController = TextEditingController();
  var _IPINController = TextEditingController();

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
          //submit button
          SubmitButton(() async {
            if (selectedCard == null) {
              // TODO:notify user to select a card
              print("please select a card");
            } else if (!isIpinValid(_IPINController.text.trim())) {
              //TODO: notify user to enter a valid IPIN
              print("please enter a valid IPIN");
            } else {
              // card number selected + valid Ipin .. attempt the transaction
              try {
                showLoadingDialog(context);
                //TODO:pass the card number
                List balanceAndPan = await context
                    .read<ApiService>()
                    .getBalance(selectedCard, _IPINController.text.trim());
                Navigator.pop(context);
                print("going to the balance page");
                // navigate to the recipt page.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionDetails(
                          balance: balanceAndPan[0],
                          cardNumber: balanceAndPan[1]),
                    ));
              } catch (e) {
                // remmber to handle the case where a wrong IPIN is entered
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
