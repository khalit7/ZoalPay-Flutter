import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/constants.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class BillPaymentPage extends StatefulWidget {
  static final pageName = "BillPaymentPage";

  @override
  _BillPaymentPageState createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  CardModel selectedCardTab1;

  CardModel selectedCardTab2;

  PayeeModel selectedOperatorTab1;

  PayeeModel selectedOperatorTab2;

  var _cardNameControllerTab1 = TextEditingController();

  var _operatorControllerTab1 = TextEditingController();

  var _phoneNumberControllertab1 = TextEditingController();

  var _commentControllerTab1 = TextEditingController();

  var _ipinControllerTab1 = TextEditingController();

  var _cardNameControllerTab2 = TextEditingController();

  var _operatorControllerTab2 = TextEditingController();

  var _phoneNumberControllertab2 = TextEditingController();

  var _amountControllerTab2 = TextEditingController();

  var _commentControllerTab2 = TextEditingController();

  var _ipinControllerTab2 = TextEditingController();

  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Bill Payment"),
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
                            .getTranslatedValue("Bill Payment INQUIRY"),
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Tab(
                        child: Text(
                            Localization.of(context)
                                .getTranslatedValue("Bill Payment"),
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
                              keyboardType: TextInputType.number,
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
                              controller: _operatorControllerTab1,
                              onChanged: (value) {
                                _operatorControllerTab1.text =
                                    selectedOperatorTab1.payeeName ?? "";
                              },
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  errorText: selectedOperatorTab1 == null
                                      ? "Please choose an operator"
                                      : null,
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("operator"),
                                  suffixIcon: PopupMenuButton<PayeeModel>(
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              child: Text(
                                                  zainBillPaymentPayeeModel
                                                      .payeeName),
                                              value: zainBillPaymentPayeeModel,
                                            ),
                                            PopupMenuItem(
                                              child: Text(
                                                  mtnBillPaymentPayeeModel
                                                      .payeeName),
                                              value: mtnBillPaymentPayeeModel,
                                            ),
                                            PopupMenuItem(
                                              child: Text(
                                                  sudaniBillPaymentPayeeModel
                                                      .payeeName),
                                              value:
                                                  sudaniBillPaymentPayeeModel,
                                            )
                                          ],
                                      onSelected: (value) {
                                        selectedOperatorTab1 = value;
                                        _operatorControllerTab1.text =
                                            selectedOperatorTab1.payeeName;
                                      },
                                      icon: Icon(Icons.arrow_drop_down))),
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
                              controller: _phoneNumberControllertab1,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? phoneNumbervalidError(
                                        _phoneNumberControllertab1.text.trim())
                                    : null,
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Phone Number"),
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
                              controller: _commentControllerTab1,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Comment"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //fifth field text
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
                              keyboardType: TextInputType.number,
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
                            selectedOperatorTab1 != null ||
                            isPhoneNumbervalid(
                                _phoneNumberControllertab1.text.trim()) ||
                            isIpinValid(_ipinControllerTab1.text.trim())) {
                          // attempt bill inquiry
                          try {
                            await context.read<ApiService>().getBill(
                                selectedCardTab1,
                                _phoneNumberControllertab1.text.trim(),
                                _ipinControllerTab1.text.trim(),
                                selectedOperatorTab1,
                                paymentType.phoneBill);
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
                            showErrorWidget(context, "Please try again later");
                            print(e);
                            print("somthing went wrong");
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
                              controller: _operatorControllerTab2,
                              onChanged: (value) {
                                _operatorControllerTab2.text =
                                    selectedOperatorTab2.payeeName ?? "";
                              },
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  errorText: selectedOperatorTab2 == null
                                      ? "Please choose an operator"
                                      : null,
                                  labelText: Localization.of(context)
                                      .getTranslatedValue("operator"),
                                  suffixIcon: PopupMenuButton<PayeeModel>(
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                              child: Text(
                                                  zainBillPaymentPayeeModel
                                                      .payeeName),
                                              value: zainBillPaymentPayeeModel,
                                            ),
                                            PopupMenuItem(
                                              child: Text(
                                                  mtnBillPaymentPayeeModel
                                                      .payeeName),
                                              value: mtnBillPaymentPayeeModel,
                                            ),
                                            PopupMenuItem(
                                              child: Text(
                                                  sudaniBillPaymentPayeeModel
                                                      .payeeName),
                                              value:
                                                  sudaniBillPaymentPayeeModel,
                                            )
                                          ],
                                      onSelected: (value) {
                                        selectedOperatorTab2 = value;
                                        _operatorControllerTab2.text =
                                            selectedOperatorTab2.payeeName;
                                      },
                                      icon: Icon(Icons.arrow_drop_down))),
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
                              controller: _phoneNumberControllertab2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? phoneNumbervalidError(
                                        _phoneNumberControllertab2.text.trim())
                                    : null,
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Phone Number"),
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
                              controller: _amountControllerTab2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorText: _validate
                                    ? amountValidError(
                                        _amountControllerTab2.text.trim())
                                    : null,
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Amount"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //fifth field text
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
                              controller: _commentControllerTab2,
                              onChanged: (string) {},
                              onSubmitted: (string) {},
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                labelText: Localization.of(context)
                                    .getTranslatedValue("Comment"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //sixth field text
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
                        // validate everything

                        if (selectedCardTab2 != null ||
                            selectedOperatorTab2 != null ||
                            isPhoneNumbervalid(
                                _phoneNumberControllertab2.text.trim()) ||
                            isAmountValid(_amountControllerTab2.text.trim()) ||
                            isIpinValid(_ipinControllerTab2.text.trim())) {
                          // attempt bill payment transaction:
                          try {
                            showLoadingDialog(context);
                            await context.read<ApiService>().payBill(
                                selectedCardTab2,
                                _ipinControllerTab2.text.trim(),
                                int.parse(_amountControllerTab2.text.trim()),
                                selectedOperatorTab2,
                                _phoneNumberControllertab2.text.trim(),
                                _commentControllerTab2.text.trim(),
                                paymentType.phoneBill);
                            String date =
                                DateFormat.yMd().format(DateTime.now());
                            // pop loading page
                            Navigator.pop(context);
                            // push recipt
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionReceipt(
                                          subTitle: "Bill Payment",
                                          transactionValue:
                                              _amountControllerTab2.text.trim(),
                                          pageDetails: {
                                            "Card Number": concealCardNumber(
                                                _cardNameControllerTab2.text
                                                    .trim()),
                                            "Amount": _amountControllerTab2.text
                                                .trim(),
                                            "Phone Number":
                                                _phoneNumberControllertab2.text
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
                            showErrorWidget(context, "Please try again later");
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
          )),
    );
  }
}
