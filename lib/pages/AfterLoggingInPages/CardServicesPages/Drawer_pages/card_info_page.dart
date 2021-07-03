import 'dart:ui';

import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

TextEditingController _editCardUserNameController;

TextEditingController _editCardNumberController;

TextEditingController _editExpiryDateController;

final _formKey = GlobalKey<FormState>();

bool _validate = false;

class CardInfoPage extends StatefulWidget {
  CardModel card;

  CardInfoPage({this.card});

  @override
  _CardInfoPageState createState() => _CardInfoPageState();
}

class _CardInfoPageState extends State<CardInfoPage> {
  bool _isSwiped = false;
  String _balance = "";

  // swipable credit card
  Widget swipeableCreditCard(CardModel card, var width, var height) {
    return Positioned(
        left: width / 40,
        right: width / 40,
        top: height / 40,
        height: height / 3.5,
        child: Dismissible(
            onDismissed: (_) {
              print("dismissed");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ipinAlertDialog(widget, height);
                  });
              setState(() {
                _isSwiped = true;
              });
              //TODO: perform balance inquiry
            },
            direction: DismissDirection.startToEnd,
            key: ValueKey("1"),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 7,
                  ),
                  // card number
                  Padding(
                    padding: EdgeInsets.fromLTRB(width / 8, 0, width / 8, 0),
                    child: Text(
                      addSpacesToCardNumber(card.cardNumber),
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.yellow[400],
                          fontSize: height * width / 22000),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  // card holder name and expiry date list tile
                  ListTile(
                    isThreeLine: true,
                    title: Text(
                      "CARD HOLDER NAME",
                      style: TextStyle(
                        color: Colors.yellow[400],
                      ),
                    ),
                    subtitle: Text(
                      card.cardUserName.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.yellow[400],
                          fontSize: height * width / 40000),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          "EXP DATE:",
                          style: TextStyle(
                            color: Colors.yellow[400],
                          ),
                        ),
                        Text(
                          beautifyExpiryDate(card.expiryDate),
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.yellow[400],
                              fontSize: height * width / 40000),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                  borderRadius:
                      BorderRadius.all(Radius.circular(width * height / 40000)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/credit_card_image.PNG"),
                      fit: BoxFit.cover)),
            )));
  }

  //card balance widget
  Widget cardBalance(var width, var height) {
    return Positioned(
      left: width / 40,
      right: width / 40,
      top: height / 40,
      height: height / 4,
      child: _balance == "" ? CircularProgressIndicator() : _balance,
    );
  }

  AlertDialog ipinAlertDialog(var width, var height) {
    TextEditingController _ipinController = TextEditingController();
    return AlertDialog(
        content: Stack(overflow: Overflow.visible, children: <Widget>[
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
            //IPIN form field
            TextFormField(
              controller: _ipinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: "IPIN should consist of 4 numbers",
                  labelText:
                      Localization.of(context).getTranslatedValue("IPIN"),
                  labelStyle: TextStyle(fontWeight: FontWeight.w300)),
              validator: (value) {
                if (value == "") {
                  return "Enter IPIN";
                }
                return null;
              },
            ),
            SizedBox(
              height: height / 40,
            ),
            SubmitButton(() async {
              //TODO:validate first
              if (isIpinValid(_ipinController.text.trim())) {
                try {
                  // pop alert dialog
                  Navigator.pop(context);

                  // perform balance inquiry
                  _balance = await context
                      .read<ApiService>()
                      .getBalance(widget.card, _ipinController.text.trim());
                } on ApiExceptions.InvalidIpin catch (e) {
                  setState(() {
                    _isSwiped = false;
                  });

                  showErrorWidget(context, "Wrong IPIN, please try again");
                } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                  setState(() {
                    _isSwiped = false;
                  });

                  showErrorWidget(context,
                      "PIN tries limit exceeded, please try again later");
                } on ApiExceptions.InvalidCard catch (e) {
                  setState(() {
                    _isSwiped = false;
                  });

                  showErrorWidget(context, "Invalid Card");
                } catch (e) {
                  //remove loading screen
                  Navigator.pop(context);
                  setState(() {
                    _isSwiped = false;
                  });
                  // pop alert dialog
                  Navigator.pop(context);
                  showErrorWidget(context, "Please try again later");
                }
              }

              //
            })
          ],
        ),
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).getTranslatedValue("Card Info")),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: Colors.grey[300],
            ),
            // the credit card image
            _isSwiped
                ? cardBalance(width, height)
                : swipeableCreditCard(widget.card, width, height),
            // the divider
            Positioned(
              top: height / 4,
              right: 0,
              left: 0,
              child: Divider(
                color: Colors.grey,
                indent: 10,
                endIndent: 20,
                height: width * height / 5000,
              ),
            ),
            // card mangment functionality
            Positioned(
                top: height / 3,
                right: 0,
                left: 0,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <ListTile>[
                    // edit card tile
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              _editCardUserNameController =
                                  TextEditingController(
                                      text: widget.card.cardUserName);
                              _editCardNumberController = TextEditingController(
                                  text: widget.card.cardNumber);
                              _editExpiryDateController = TextEditingController(
                                  text: widget.card.expiryDate);
                              return UpdateCardDialog(card: widget.card);
                            });
                      },
                      leading: Icon(Icons.ac_unit),
                      title: Text(
                        Localization.of(context)
                            .getTranslatedValue("Edit Card"),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      subtitle: Text(Localization.of(context)
                          .getTranslatedValue("Change card details")),
                    ),
                    // change pin tile
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.ac_unit),
                      title: Text(
                        Localization.of(context).getTranslatedValue("PIN code"),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      subtitle: Text(Localization.of(context)
                          .getTranslatedValue("Change IPIN")),
                    ),
                    // delete card
                    ListTile(
                      onTap: () {
                        //TODO:Perform delete
                      },
                      leading: Icon(Icons.ac_unit),
                      title: Text(
                        Localization.of(context)
                            .getTranslatedValue("Delete card"),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      subtitle: Text(Localization.of(context)
                          .getTranslatedValue("Delete card from your cards")),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class UpdateCardDialog extends StatefulWidget {
  @override
  _UpdateCardDialogState createState() => _UpdateCardDialogState();
  CardModel card;
  UpdateCardDialog({this.card});
}

class _UpdateCardDialogState extends State<UpdateCardDialog> {
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
              controller: _editCardUserNameController,
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
              controller: _editCardNumberController,
              decoration: InputDecoration(
                  errorText: _validate
                      ? cardNumberValidError(
                          _editCardNumberController.text.trim())
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
              controller: _editExpiryDateController,
              decoration: InputDecoration(
                  errorText: _validate
                      ? expiryDateValidError(
                          _editExpiryDateController.text.trim())
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
            SubmitButton(() async {
              setState(() {
                _validate = true;
              });
              //TODO:validate first
              if (isCardNumberValid(_editCardNumberController.text.trim()) &&
                  isExpiryDateValid(_editExpiryDateController.text.trim())) {
                CardModel editedCard = CardModel(
                    cardUserName: _editCardUserNameController.text.trim(),
                    cardNumber: _editCardNumberController.text.trim(),
                    expiryDate: _editExpiryDateController.text.trim(),
                    id: widget.card.id);

                try {
                  // show loading
                  showLoadingDialog(context);
                  // widget.card =
                  await context.read<ApiService>().updateCard(editedCard);
                  // pop loading
                  Navigator.pop(context);

                  setState(() {
                    widget.card.cardUserName = _editCardUserNameController.text;
                    widget.card.cardNumber = _editCardNumberController.text;
                    widget.card.expiryDate = _editExpiryDateController.text;

                    // _editCardUserNameController.text = "";
                    // _editCardNumberController.text = "";
                    // _editExpiryDateController.text = "";
                  });
                } catch (e) {
                  //remove loading screen
                  Navigator.pop(context);
                  showErrorWidget(context, "Please try again later");
                }
              }

              //
            })
          ],
        ),
      )
    ]));
  }
}
