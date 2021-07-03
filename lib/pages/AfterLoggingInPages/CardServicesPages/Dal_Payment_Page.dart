import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/constants.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class DalPaymentPage extends StatefulWidget {
  static final pageName = "DalPaymentPage";

  @override
  _DalPaymentPageState createState() => _DalPaymentPageState();
}

class _DalPaymentPageState extends State<DalPaymentPage> {
  var _cardNameControllerTab1 = TextEditingController();

  var _referenceNumberControllerTab1 = TextEditingController();

  var _ipinControllerTab1 = TextEditingController();

  var _cardNameControllerTab2 = TextEditingController();

  var _referenceControllerTab2 = TextEditingController();

  var _amountController = TextEditingController();

  var _ipinControllerTab2 = TextEditingController();

  bool _validate = false;
  CardModel selectedCardTab1;
  CardModel selectedCardTab2;
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Dal Payment"),
        ),
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height / 15,
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        Localization.of(context)
                            .getTranslatedValue("E-INVOICE INQUIRY"),
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Tab(
                        child: Text(
                            Localization.of(context)
                                .getTranslatedValue("E-INVOICE"),
                            style: TextStyle(color: Colors.red)))
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  //first tab
                  ListView(
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
                              controller: _cardNameControllerTab1,
                              onChanged: (value) {
                                _cardNameControllerTab1.text =
                                    selectedCardTab1.cardUserName ?? "";
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  errorText: selectedCardTab1 == null
                                      ? "Please select a card"
                                      : null,
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Card Number"),
                                  suffixIcon: PopupMenuButton<CardModel>(
                                      itemBuilder: (BuildContext context) =>
                                          CardModel.allCards
                                              .map((card) => PopupMenuItem(
                                                    child:
                                                        Text(card.cardUserName),
                                                    value: card,
                                                  ))
                                              .toList(),
                                      onSelected: (value) {
                                        selectedCardTab1 = value;
                                        _cardNameControllerTab1.text =
                                            selectedCardTab1.cardUserName;
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
                              controller: _referenceNumberControllerTab1,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Reference Number"),
                              ),
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
                              controller: _ipinControllerTab1,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? iPinValidError(
                                        _ipinControllerTab1.text.trim())
                                    : null,
                                labelText: Localization.of(context)
                                    .getTranslatedValue("IPIN"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      SubmitButton(() async {
                        setState(() {
                          _validate = true;
                        });
                        if (isIpinValid(_ipinControllerTab1.text.trim()) &&
                            selectedCardTab1 != null) {
                          // perform the api call
                          try {
                            showLoadingDialog(context);
                            await context.read<ApiService>().getBill(
                                selectedCardTab1,
                                _referenceNumberControllerTab1.text.trim(),
                                _ipinControllerTab1.text.trim(),
                                dalPayeeModel,
                                paymentType.dalBill);
                            Navigator.pop(context);
                          } on ApiExceptions.InvalidIpin catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(
                                context, "Wrong IPIN, please try again");
                          } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(context,
                                "PIN tries limit exceeded, please try again later");
                          } on ApiExceptions.InvalidCard catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(context, "Invalid Card");
                          } catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(context,
                                "Somthing went wrong, try again later");
                          }
                        }
                      })
                    ],
                  ),
                  //second tab
                  ListView(
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
                              controller: _cardNameControllerTab2,
                              onChanged: (value) {
                                _cardNameControllerTab2.text =
                                    selectedCardTab2.cardUserName ?? "";
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  errorText: selectedCardTab2 == null
                                      ? "Please select a valid card"
                                      : null,
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Card Number"),
                                  suffixIcon: PopupMenuButton<CardModel>(
                                      itemBuilder: (BuildContext context) =>
                                          CardModel.allCards
                                              .map((card) => PopupMenuItem(
                                                    child:
                                                        Text(card.cardUserName),
                                                    value: card,
                                                  ))
                                              .toList(),
                                      onSelected: (value) {
                                        selectedCardTab2 = value;
                                        _cardNameControllerTab2.text =
                                            selectedCardTab2.cardUserName;
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
                              controller: _referenceControllerTab2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Reference Number"),
                              ),
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
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? amountValidError(
                                        _amountController.text.trim())
                                    : null,
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Amount"),
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
                              controller: _ipinControllerTab2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? iPinValidError(
                                        _ipinControllerTab2.text.trim())
                                    : null,
                                labelText: Localization.of(context)
                                    .getTranslatedValue("IPIN"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      SubmitButton(() async {
                        setState(() {
                          _validate = true;
                        });
                        if (isIpinValid(_ipinControllerTab2.text.trim()) &&
                            selectedCardTab2 != null &&
                            isAmountValid(_amountController.text.trim())) {
                          // perform the api call
                          try {
                            showLoadingDialog(context);
                            await context.read<ApiService>().payBill(
                                selectedCardTab1,
                                _ipinControllerTab1.text.trim(),
                                int.parse(_amountController.text.trim()),
                                dalPayeeModel,
                                _referenceNumberControllerTab1.text.trim(),
                                "",
                                paymentType.dalBill);
                            Navigator.pop(context);
                          } on ApiExceptions.InvalidIpin catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(
                                context, "Wrong IPIN, please try again");
                          } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(context,
                                "PIN tries limit exceeded, please try again later");
                          } on ApiExceptions.InvalidCard catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(context, "Invalid Card");
                          } catch (e) {
                            Navigator.pop(context);
                            showErrorWidget(context,
                                "Somthing went wrong, try again later");
                          }
                        }
                      })
                    ],
                  )
                ]),
              )
            ],
          )),
    );
  }
}
