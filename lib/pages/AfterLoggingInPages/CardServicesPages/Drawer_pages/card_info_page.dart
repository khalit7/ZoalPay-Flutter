import 'dart:ui';

import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  String _balance = "";
  bool _isBalanceAvailable = false;
  bool isCurrentlyAttemptingBalanceEnquiry = false;
  Color cardDetailsColor = Colors.grey;

  // swipable credit card
  Widget swipeableCreditCard(CardModel card, var width, var height) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * width / 2300,
          ),
          // card number
          Padding(
            padding: EdgeInsets.fromLTRB(width * height / 7000, 0, 0, 0),
            child: Text(
              addSpacesToCardNumber(card.cardNumber),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: cardDetailsColor,
                  fontSize: height * width / 12000),
            ),
          ),
          SizedBox(
            height: width * height / 40000,
          ),

          // card holder name and expiry date titles
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * height / 14000, 0, width * height / 14000, 0),
            child: Row(
              children: [
                Text("CARD HOLDER NAME",
                    style: TextStyle(
                        color: cardDetailsColor,
                        fontSize: height * width / 40000)),
                Expanded(
                  child: Text(
                    "EXP DATE",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: cardDetailsColor,
                        fontSize: height * width / 40000),
                  ),
                )
              ],
            ),
          ),

          // actual card holer name and expiry dates

          SizedBox(
            height: width * height / 40000,
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
                width * height / 14000, 0, width * height / 14000, 0),
            child: Row(
              children: [
                Text("${card.cardUserName.toUpperCase()}",
                    style: TextStyle(
                        color: cardDetailsColor,
                        fontSize: height * width / 20000)),
                Expanded(
                  child: Text(
                    "${beautifyExpiryDate(card.expiryDate)}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: cardDetailsColor,
                        fontSize: height * width / 20000),
                  ),
                )
              ],
            ),
          )
          // // card holder name and expiry date list tile
          // ListTile(
          //   isThreeLine: true,
          //   title: Text(
          //     "CARD HOLDER NAME",
          //     style: TextStyle(
          //         color: Colors.yellow[400],
          //         fontSize: height * width / 80000),
          //   ),
          //   subtitle: Text(
          //     card.cardUserName.toUpperCase(),
          //     style: TextStyle(
          //         fontWeight: FontWeight.w900,
          //         color: Colors.yellow[400],
          //         fontSize: height * width / 40000),
          //   ),
          //   trailing: Column(
          //     children: [
          //       Text(
          //         "EXP DATE:",
          //         style: TextStyle(
          //             color: Colors.yellow[400],
          //             fontSize: height * width / 80000),
          //       ),
          //       Text(
          //         beautifyExpiryDate(card.expiryDate),
          //         style: TextStyle(
          //             fontWeight: FontWeight.w900,
          //             color: Colors.yellow[400],
          //             fontSize: height * width / 40000),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
          borderRadius:
              BorderRadius.all(Radius.circular(width * height / 40000)),
          image: DecorationImage(
              image: AssetImage("assets/images/credit_card.png"),
              fit: BoxFit.fill)),
    );
  }

  //card balance widget
  Widget cardBalance(var width, var height) {
    return Container(
      child: _isBalanceAvailable
          ? //balanceWidget
          balanceWidget(width, height)
          : // loading widget
          Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget balanceWidget(var width, var height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //account balance
        SizedBox(
          height: width * height / (1300 * 6),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(width / 4, 0, 0, 0),
          child: ListTile(
            title: Text("Account Balance",
                style: TextStyle(
                    color: cardDetailsColor, fontSize: height * width / 40000)),
            subtitle: Text("${beautifyTransactionAmount(_balance)}",
                style: TextStyle(
                    color: Colors.black, fontSize: height * width / 20000)),
          ),
        ),
        SizedBox(
          height: width * height / (1300 * 12),
        ),
        //divider
        Divider(
          indent: width / 50,
          endIndent: width / 50,
          color: Colors.grey,
        ),
        SizedBox(
          height: width * height / (1300 * 12),
        ),
        // date
        Padding(
          padding: EdgeInsets.fromLTRB(width / 4, 0, 0, 0),
          child: ListTile(
            title: Text("Date",
                style: TextStyle(
                    color: cardDetailsColor, fontSize: height * width / 40000)),
            subtitle: Text(DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: TextStyle(
                    color: Colors.black, fontSize: height * width / 35000)),
          ),
        ),
      ],
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
                // pop alert dialog
                Navigator.pop(context);
                try {
                  isCurrentlyAttemptingBalanceEnquiry = true;
                  // perform balance inquiry
                  _balance = await context
                      .read<ApiService>()
                      .getBalance(widget.card, _ipinController.text.trim());
                  setState(() {
                    _isBalanceAvailable = true;
                  });
                } on ApiExceptions.InvalidIpin catch (e) {
                  showErrorWidget(context, "Wrong IPIN, please try again");
                } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                  showErrorWidget(context,
                      "PIN tries limit exceeded, please try again later");
                } on ApiExceptions.InvalidCard catch (e) {
                  showErrorWidget(context, "Invalid Card");
                } catch (e) {
                  showErrorWidget(context, "Please try again later");
                } finally {
                  isCurrentlyAttemptingBalanceEnquiry = false;
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
    PageController _pageController = PageController(initialPage: 1);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.grey[300],
          ),
          // the background fading image
          Positioned(
              top: -10,
              right: 0,
              left: 0,
              height: width * height / 1800,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/background2.png"),
                        fit: BoxFit.fitHeight)),
              )),
          // the credit card image
          Positioned(
            left: width * height / 40000,
            right: width * height / 40000,
            top: width * height / 10000,
            height: width * height / 1300,
            child: PageView(
              controller: _pageController,
              pageSnapping: false,
              onPageChanged: (int pageNumber) {
                // check page number and if the balance is already available and if curently trying to get the balance
                if (pageNumber == 0 &&
                    _isBalanceAvailable == false &&
                    isCurrentlyAttemptingBalanceEnquiry == false)
                  showDialog(
                      context: context,
                      useRootNavigator: true,
                      builder: (BuildContext context) {
                        return ipinAlertDialog(widget, height);
                      });
              },
              children: [
                cardBalance(width, height),
                swipeableCreditCard(widget.card, width, height),
              ],
            ),
          ),
          Positioned(
              top: height * width / 1150,
              right: 0,
              left: 0,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  // page indicator
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 2,
                      effect: WormEffect(
                          paintStyle: PaintingStyle.stroke,
                          dotHeight: 16,
                          dotWidth: 16,
                          radius: 100,
                          activeDotColor: Colors.grey,
                          dotColor: Colors.black),
                      onDotClicked: (index) => _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceOut),
                    ),
                  ),
                  // the divider
                  Divider(
                    color: Colors.grey,
                  ),
                  // edit card tile
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            _editCardUserNameController = TextEditingController(
                                text: widget.card.cardUserName);
                            _editCardNumberController = TextEditingController(
                                text: widget.card.cardNumber);
                            _editExpiryDateController = TextEditingController(
                                text: widget.card.expiryDate);
                            return UpdateCardDialog(card: widget.card);
                          });
                    },
                    leading: Icon(Icons.edit),
                    title: Text(
                      Localization.of(context).getTranslatedValue("Edit Card"),
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    subtitle: Text(Localization.of(context)
                        .getTranslatedValue("Change card details")),
                  ),
                  // change pin tile
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.code),
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
                    leading: Icon(Icons.delete),
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
