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

class MobileTopUpPage extends StatefulWidget {
  static final pageName = "MobileTopUpPage";

  @override
  _MobileTopUpPageState createState() => _MobileTopUpPageState();
}

class _MobileTopUpPageState extends State<MobileTopUpPage> {
  CardModel selectedCard;

  PayeeModel selectedOperator;

  var _cardNameController = TextEditingController();

  var _operatorController = TextEditingController();

  var _phoneNumberController = TextEditingController();

  var _amountController = TextEditingController();

  var _commentController = TextEditingController();

  var _IpinController = TextEditingController();

  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Mobile TOPUP"),
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
                      errorText:
                          selectedCard == null ? "Please select a card" : null,
                      labelText: Localization.of(context)
                          .getTranslatedValue("Card Number"),
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
                  controller: _operatorController,
                  onChanged: (string) {
                    _operatorController.text = selectedOperator.payeeName ?? "";
                  },
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                      labelText: Localization.of(context)
                          .getTranslatedValue("operator"),
                      errorText: selectedOperator == null
                          ? "Please select an operator"
                          : null,
                      suffixIcon: PopupMenuButton<PayeeModel>(
                          itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  child: Text(zainTopUpPayeeModel.payeeName),
                                  value: zainTopUpPayeeModel,
                                ),
                                PopupMenuItem(
                                  child: Text(mtnTopUpPayeeModel.payeeName),
                                  value: mtnTopUpPayeeModel,
                                ),
                                PopupMenuItem(
                                  child: Text(sudaniTopUpPayeeModel.payeeName),
                                  value: sudaniTopUpPayeeModel,
                                )
                              ],
                          onSelected: (value) {
                            selectedOperator = value;
                            _operatorController.text =
                                selectedOperator.payeeName;
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
                  controller: _phoneNumberController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: _validate
                        ? phoneNumbervalidError(
                            _phoneNumberController.text.trim())
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
                  controller: _amountController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText:
                          Localization.of(context).getTranslatedValue("Amount"),
                      errorText: _validate
                          ? amountValidError(_amountController.text.trim())
                          : null),
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
                  controller: _commentController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText:
                        Localization.of(context).getTranslatedValue("Comment"),
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
                  controller: _IpinController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  obscureText: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText:
                          Localization.of(context).getTranslatedValue("IPIN"),
                      errorText: _validate
                          ? iPinValidError(_IpinController.text.trim())
                          : null),
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
            if (selectedCard != null &&
                selectedOperator != null &&
                isPhoneNumbervalid(_phoneNumberController.text.trim()) &&
                isAmountValid(_amountController.text.trim()) &&
                isIpinValid(_IpinController.text.trim())) {
              // attempt the transaction
              try {
                showLoadingDialog(context);

                await context.read<ApiService>().payBill(
                    selectedCard,
                    _IpinController.text.trim(),
                    int.parse(_amountController.text.trim()),
                    selectedOperator,
                    _phoneNumberController.text.trim(),
                    _commentController.text.trim(),
                    paymentType.phoneBill);
                String date = DateFormat.yMd().format(DateTime
                    .now()); // this is to formate date time from UTZ to yy-mm-dd-hh-m-ss

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "Mobile TOPUP",
                              transactionValue: _amountController.text.trim(),
                              pageDetails: {
                                "Card Number":
                                    concealCardNumber(selectedCard.cardNumber),
                                "Amount": _amountController.text.trim(),
                                "Phone Number":
                                    _phoneNumberController.text.trim(),
                                "Date": date,
                                "Comment": _commentController.text.trim()
                              },
                            )));
              } on ApiExceptions.InvalidIpin catch (e) {
                Navigator.pop(context);
                showErrorWidget(context, "Wrong IPIN, please try again");
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
    );
  }
}
