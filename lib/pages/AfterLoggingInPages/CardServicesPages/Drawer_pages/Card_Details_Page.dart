import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Drawer_pages/card_info_page.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:dio/dio.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

var _cardNameController = TextEditingController();
var _panController = TextEditingController();
var _expiryDateController = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool _validate = false;

class CardDetailsPage extends StatefulWidget {
  static final pageName = "CardDetailsPage";

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(Localization.of(context).getTranslatedValue("Card Details")),
      ),
      body: Stack(
        //availble cards
        children: [
          ListView(
            children: CardModel.allCards
                .map((card) => ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardInfoPage(
                                      card: card,
                                    )));
                      },
                      title: Text(card.cardUserName),
                      subtitle: Text(card.cardNumber),
                    ))
                .toList(),
          ),
          //plus button
          Positioned(
              left: width / 1.3,
              right: width / 20,
              top: height / 1.3,
              bottom: height / 40,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.red,
                  size: width * height / 5000,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddCardDialog();
                      });
                },
              ))
        ],
      ),
    );
  }
}

class AddCardDialog extends StatefulWidget {
  @override
  _AddCardDialogState createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
        content: Stack(overflow: Overflow.visible, children: <Widget>[
      Positioned(
        right: -40.0,
        top: -40.0,
        child: InkResponse(
          onTap: () {
            _validate = false;
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      //card details
      Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //first form field
            TextFormField(
              controller: _cardNameController,
              decoration: InputDecoration(
                  labelText:
                      Localization.of(context).getTranslatedValue("Card Name"),
                  labelStyle: TextStyle(fontWeight: FontWeight.w300)),
              validator: (value) {
                if (value == "") {
                  return "Enter Card Name";
                }
                return null;
              },
            ),
            //second form field
            TextFormField(
              controller: _panController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _validate
                      ? cardNumberValidError(_panController.text.trim())
                      : null,
                  labelText: Localization.of(context)
                      .getTranslatedValue("Card Number"),
                  labelStyle: TextStyle(fontWeight: FontWeight.w300)),
              validator: (value) {
                if (value == "") {
                  return "Enter Card Number";
                }
                return null;
              },
            ),
            //third form field
            TextFormField(
              controller: _expiryDateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _validate
                      ? expiryDateValidError(_expiryDateController.text.trim())
                      : null,
                  labelText: Localization.of(context)
                      .getTranslatedValue("Card Expiry Date"),
                  labelStyle: TextStyle(fontWeight: FontWeight.w300)),
              validator: (value) {
                if (value == "") {
                  return "Enter Card Expiry Date";
                }
                return null;
              },
            ),
            SizedBox(
              height: height / 40,
            ),
            // submit button
            SubmitButton(() async {
              //TODO:validate first
              setState(() {
                _validate = true;
              });
              if (isCardNumberValid(_panController.text.trim()) &&
                  isExpiryDateValid(_expiryDateController.text.trim()))
                try {
                  _validate = false;
                  showLoadingDialog(context);
                  CardModel newCard = await context.read<ApiService>().addCard(
                      _cardNameController.text.trim(),
                      _expiryDateController.text.trim(),
                      _panController.text.trim());
                  Navigator.pop(context);
                  //add to cards list
                  setState(() {
                    CardModel.allCards.add(newCard);
                    Navigator.pop(context);
                    _cardNameController.text = "";
                    _panController.text = "";
                    _expiryDateController.text = "";
                  });
                } catch (e) {
                  //TODO:show user that somthing went wrong
                  print(e.response.data);
                  print("tdaa");
                  _validate = false;
                }
            })
          ],
        ),
      )
    ]));
  }
}
