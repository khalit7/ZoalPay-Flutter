import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Balance_Receipt_Page.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:flutter/material.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class CardBalancePage extends StatelessWidget {
  static final pageName = "CardBalancePage";
  CardModel selectedCard;
  var _cardNameController = TextEditingController();
  var _IPINController = TextEditingController();

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    String pattern = r'(^[0-9]{4}$)';
    RegExp regExp = RegExp(pattern);
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
                                  .toList()
                          //  [
                          //       PopupMenuItem(
                          //         child: Text("choice 1"),
                          //         value: "choice 1",
                          //       ),
                          //       PopupMenuItem(
                          //         child: Text("choice 2"),
                          //         value: "choice 2",
                          //       )
                          //     ]
                          ,
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
          SubmitButton(() async {
            if (selectedCard == null) {
              // TODO:notify user to select a card
              print("please select a card");
            } else if (!regExp.hasMatch(_IPINController.text.trim())) {
              //TODO: notify user to enter a valid IPIN
              print("please enter a valid IPIN");
            } else {
              // card number selected + valid Ipin .. attempt the transaction
              try {
                print("submit attempt");
                double balance = await context
                    .read<ApiService>()
                    .getBalance(selectedCard, _IPINController.text.trim());
                print("going to the balance page");
                // navigate to the recipt page.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BalanceReceipt(balance: balance),
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
