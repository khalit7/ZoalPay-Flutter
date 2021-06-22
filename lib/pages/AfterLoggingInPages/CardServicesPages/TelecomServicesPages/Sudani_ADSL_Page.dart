import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:ZoalPay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class SudaniAdSlPage extends StatefulWidget {
  static final pageName = "SudaniAdSlPage";

  @override
  _SudaniAdSlPageState createState() => _SudaniAdSlPageState();
}

class _SudaniAdSlPageState extends State<SudaniAdSlPage> {
  CardModel selectedCardTab1;

  CardModel selectedCardTab2;

  var _cardNameControllerTab2 = TextEditingController();

  var _phoneNumberControllerTab2 = TextEditingController();

  var _amountController = TextEditingController();

  var _ipinControllerTab1 = TextEditingController();

  var _cardNameControllerTab1 = TextEditingController();

  var _phoneNumberControllerTab1 = TextEditingController();

  var _ipinControllerTab2 = TextEditingController();

  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            Localization.of(context).getTranslatedValue("Sudani ADSL"),
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
                              .getTranslatedValue("BILL INQUIRY"),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Tab(
                          child: Text(
                              Localization.of(context)
                                  .getTranslatedValue("Sudani ADSL"),
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
                                                      child: Text(
                                                          card.cardUserName),
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
                                controller: _phoneNumberControllerTab1,
                                onChanged: (string) {},
                                onSubmitted: (string) {},
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: _validate
                                      ? phoneNumbervalidError(
                                          _phoneNumberControllerTab1.text
                                              .trim())
                                      : null,
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Phone Number"),
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
                          // validate everything
                          if (selectedCardTab1 != null ||
                              isPhoneNumbervalid(
                                  _phoneNumberControllerTab1.text.trim()) ||
                              isIpinValid(_ipinControllerTab1.text.trim())) {
                            // attempt bill inquiry
                            try {
                              showLoadingDialog(context);
                              await context.read<ApiService>().getBill(
                                  selectedCardTab1,
                                  _phoneNumberControllerTab1.text.trim(),
                                  _ipinControllerTab1.text.trim(),
                                  sudaniBillPaymentPayeeModel);
                              // pop loading page
                              // go to recipt page
                              Navigator.pop(context);
                            } on ApiExceptions.InvalidIpin catch (e) {
                              Navigator.pop(context);
                              showErrorWidget(
                                  context, "Wrong IPIN, please try again");
                            } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                              Navigator.pop(context);
                              showErrorWidget(context,
                                  "PIN tries limit exceeded, please try again later");
                            } catch (e) {
                              // remmber to handle the case where a wrong IPIN is entered
                              //remove loading screen
                              Navigator.pop(context);
                              showErrorWidget(
                                  context, "Please try again later");
                              print(e);
                              print("somthing went wrong");
                            }
                          }
                        })
                      ],
                    ),

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
                                        ? "Please select a card"
                                        : null,
                                    labelText: Localization.of(context)
                                        .getTranslatedValue("Card Number"),
                                    suffixIcon: PopupMenuButton<CardModel>(
                                        itemBuilder: (BuildContext context) =>
                                            CardModel.allCards
                                                .map((card) => PopupMenuItem(
                                                      child: Text(
                                                          card.cardUserName),
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
                                controller: _phoneNumberControllerTab2,
                                onSubmitted: (string) {},
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText: _validate
                                      ? phoneNumbervalidError(
                                          _phoneNumberControllerTab2.text
                                              .trim())
                                      : null,
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("Phone Number"),
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
                                keyboardType: TextInputType.number,
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
                                keyboardType: TextInputType.number,
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
                          // validate everything
                          setState(() {
                            _validate = true;
                          });
                          if (selectedCardTab2 != null ||
                              isPhoneNumbervalid(
                                  _phoneNumberControllerTab2.text.trim()) ||
                              isAmountValid(_amountController.text.trim()) ||
                              isIpinValid(_ipinControllerTab2.text.trim())) {
                            try {
                              showLoadingDialog(context);
                              await context.read<ApiService>().payBill(
                                  selectedCardTab2,
                                  _ipinControllerTab2.text.trim(),
                                  int.parse(_amountController.text.trim()),
                                  sudaniBillPaymentPayeeModel,
                                  _phoneNumberControllerTab2.text.trim(),
                                  "",
                                  paymentType
                                      .phoneBill); // make sure that there is no comment interface in this page
                              String date =
                                  DateFormat.yMd().format(DateTime.now());
                              // pop loading screen
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransactionReceipt(
                                            subTitle:
                                                "Sudani ADSL bill Payment",
                                            transactionValue:
                                                _amountController.text.trim(),
                                            pageDetails: {
                                              "Card Number": concealCardNumber(
                                                  selectedCardTab2.cardNumber),
                                              "Amount":
                                                  _amountController.text.trim(),
                                              "Phone Number":
                                                  _phoneNumberControllerTab2
                                                      .text
                                                      .trim(),
                                              "Date": date,
                                            },
                                          )));
                            } on ApiExceptions.InvalidIpin catch (e) {
                              Navigator.pop(context);
                              showErrorWidget(
                                  context, "Wrong IPIN, please try again");
                            } on ApiExceptions.PinTriesLimitExceeded catch (e) {
                              Navigator.pop(context);
                              showErrorWidget(context,
                                  "PIN tries limit exceeded, please try again later");
                            } catch (e) {
                              // remmber to handle the case where a wrong IPIN is entered
                              //remove loading screen
                              Navigator.pop(context);
                              showErrorWidget(
                                  context, "Please try again later");
                              print(e);
                              print("somthing went wrong");
                            }
                          }
                        })
                      ],
                    ),
                  ]),
                )
              ],
            )));
  }
}
