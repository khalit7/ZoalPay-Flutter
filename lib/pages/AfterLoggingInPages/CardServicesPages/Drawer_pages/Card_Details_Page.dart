import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/Data_Base_Modle.dart';
import 'package:ZoalPay/models/card_details_model.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatefulWidget {
  static final pageName = "CardDetailsPage";

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();
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
            children: DataBaseModle.definedCards
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
                                      var _controller1 = TextEditingController(
                                          text: card.cardUserName);
                                      var _controller2 = TextEditingController(
                                          text: card.cardNumber);
                                      var _controller3 = TextEditingController(
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
                                                    controller: _controller1,
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
                                                    controller: _controller2,
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
                                                    controller: _controller3,
                                                    decoration: InputDecoration(
                                                        labelText: Localization
                                                                .of(context)
                                                            .getTranslatedValue(
                                                                "Card Expiery Date"),
                                                        labelStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                    validator: (value) {
                                                      if (value == "") {
                                                        return "Enter Card Expiery Date";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: height / 40,
                                                  ),
                                                  SubmitButton(() {
                                                    //TODO:validate first
                                                    setState(() {
                                                      card.cardUserName =
                                                          _controller1.text;
                                                      card.cardNumber =
                                                          _controller2.text;
                                                      card.expiryDate =
                                                          _controller3.text;

                                                      Navigator.pop(context);
                                                      _controller1.text = "";
                                                      _controller2.text = "";
                                                      _controller3.text = "";
                                                    });
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
                                      controller: _controller1,
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
                                      controller: _controller2,
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
                                      controller: _controller3,
                                      decoration: InputDecoration(
                                          labelText: Localization.of(context)
                                              .getTranslatedValue(
                                                  "Card Expiery Date"),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w300)),
                                      validator: (value) {
                                        if (value == "") {
                                          return "Enter Card Expiery Date";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: height / 40,
                                    ),
                                    SubmitButton(() {
                                      //TODO:validate first
                                      setState(() {
                                        DataBaseModle.definedCards.add(
                                            CardDetailsModel(
                                                cardUserName: _controller1.text,
                                                cardNumber: _controller2.text,
                                                expiryDate: _controller3.text));
                                        Navigator.pop(context);
                                        _controller1.text = "";
                                        _controller2.text = "";
                                        _controller3.text = "";
                                      });
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
