import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:dio/dio.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatefulWidget {
  static final pageName = "CardDetailsPage";

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  var _cardNameController = TextEditingController();
  var _panController = TextEditingController();
  var _expiryDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                      title: Text(card.cardUserName),
                      subtitle: Text(card.cardNumber),
                      //edit button
                      trailing: Container(
                        height: width * height / 10000,
                        decoration: BoxDecoration(color: Colors.red),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: width * height / 20000,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              iconSize: width * height / 16000,
                              icon: Icon(
                                Icons.handyman,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      var _editCardUserNameController =
                                          TextEditingController(
                                              text: card.cardUserName);
                                      var _editCardNumberController =
                                          TextEditingController(
                                              text: card.cardNumber);
                                      var _editExpiryDateController =
                                          TextEditingController(
                                              text: card.expiryDate);
                                      return AlertDialog(
                                          content: Stack(
                                              overflow: Overflow.visible,
                                              children: <Widget>[
                                            Positioned(
                                              right: -40.0,
                                              top: -40.0,
                                              child: InkResponse(
                                                onTap: () {
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
                                                    controller:
                                                        _editCardUserNameController,
                                                    decoration: InputDecoration(
                                                        labelText: Localization
                                                                .of(context)
                                                            .getTranslatedValue(
                                                                "Card Name"),
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                    validator: (value) {
                                                      if (value == "") {
                                                        return "Enter Card Name";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  //second form field
                                                  TextFormField(
                                                    controller:
                                                        _editCardNumberController,
                                                    decoration: InputDecoration(
                                                        labelText: Localization
                                                                .of(context)
                                                            .getTranslatedValue(
                                                                "Card Number"),
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                    validator: (value) {
                                                      if (value == "") {
                                                        return "Enter Card Number";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  //third form field
                                                  TextFormField(
                                                    controller:
                                                        _editExpiryDateController,
                                                    decoration: InputDecoration(
                                                        labelText: Localization
                                                                .of(context)
                                                            .getTranslatedValue(
                                                                "Card Expiry Date"),
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
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
                                                  SubmitButton(() async {
                                                    //TODO:validate first
                                                    CardModel editedCard = CardModel(
                                                        cardUserName:
                                                            _editCardUserNameController
                                                                .text
                                                                .trim(),
                                                        cardNumber:
                                                            _editCardNumberController
                                                                .text
                                                                .trim(),
                                                        expiryDate:
                                                            _editExpiryDateController
                                                                .text
                                                                .trim(),
                                                        id: card.id);

                                                    try {
                                                      card = await context
                                                          .read<ApiService>()
                                                          .updateCard(
                                                              editedCard);

                                                      setState(() {
                                                        card.cardUserName =
                                                            _editCardUserNameController
                                                                .text;
                                                        card.cardNumber =
                                                            _editCardNumberController
                                                                .text;
                                                        card.expiryDate =
                                                            _editExpiryDateController
                                                                .text;

                                                        Navigator.pop(context);
                                                        _editCardUserNameController
                                                            .text = "";
                                                        _editCardNumberController
                                                            .text = "";
                                                        _editExpiryDateController
                                                            .text = "";
                                                      });
                                                    } catch (e) {
                                                      //TODO: notify user somthing went wrong

                                                    }

                                                    //
                                                  })
                                                ],
                                              ),
                                            )
                                          ]));
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
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
                        return AlertDialog(
                            content: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
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
                                          labelText: Localization.of(context)
                                              .getTranslatedValue("Card Name"),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w300)),
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
                                      decoration: InputDecoration(
                                          labelText: Localization.of(context)
                                              .getTranslatedValue(
                                                  "Card Number"),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w300)),
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
                                      decoration: InputDecoration(
                                          labelText: Localization.of(context)
                                              .getTranslatedValue(
                                                  "Card Expiry Date"),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w300)),
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
                                      //
                                      try {
                                        CardModel newCard = await context
                                            .read<ApiService>()
                                            .addCard(
                                                _cardNameController.text.trim(),
                                                _expiryDateController.text
                                                    .trim(),
                                                _panController.text.trim());
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
                                      }
                                    })
                                  ],
                                ),
                              )
                            ]));
                      });
                },
              ))
        ],
      ),
    );
  }
}
