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

class ElectricityServicesPage extends StatefulWidget {
  static final pageName = "ElectricityServicesPage";

  @override
  _ElectricityServicesPageState createState() =>
      _ElectricityServicesPageState();
}

class _ElectricityServicesPageState extends State<ElectricityServicesPage> {
  CardModel selectedCard;

  TextEditingController _cardNameController = TextEditingController();

  TextEditingController _meterNumberController = TextEditingController();

  TextEditingController _amountController = TextEditingController();

  TextEditingController _ipinController = TextEditingController();

  bool _validate = false;

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("Electricity Services"),
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
                  controller: _meterNumberController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: _validate
                        ? meterNumberValidError(
                            _meterNumberController.text.trim())
                        : null,
                    labelText: Localization.of(context)
                        .getTranslatedValue("Meter Number"),
                    // suffixIcon: PopupMenuButton(
                    //     itemBuilder: (BuildContext context) => [
                    //           PopupMenuItem(
                    //             child: Text("choice 1"),
                    //             value: "choice 1",
                    //           ),
                    //           PopupMenuItem(
                    //             child: Text("choice 2"),
                    //             value: "choice 2",
                    //           )
                    //         ],
                    //     onSelected: (value) {
                    //       _meterNumberController.text = value;
                    //     },
                    //     icon: Icon(Icons.favorite_sharp, color: Colors.red))
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
                        ? amountValidError(_amountController.text.trim())
                        : null,
                    labelText:
                        Localization.of(context).getTranslatedValue("Amount"),
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
                  controller: _ipinController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: _validate
                        ? iPinValidError(_ipinController.text.trim())
                        : null,
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
            // validate everything
            setState(() {
              _validate = true;
            });

            if (selectedCard != null &&
                isMeterNumberValid(_meterNumberController.text.trim()) &&
                isAmountValid(_amountController.text.trim()) &&
                isIpinValid(_ipinController.text.trim())) {
              // attempt the transaction
              try {
                showLoadingDialog(context);
                Map<dynamic, dynamic> returnValue = await context
                    .read<ApiService>()
                    .payBill(
                        selectedCard,
                        _ipinController.text.trim(),
                        int.parse(_amountController.text.trim()),
                        electricityPayeeModel,
                        _meterNumberController.text.trim(),
                        "",
                        paymentType.electricityBill);
                String date = DateFormat.yMd().format(DateTime.now());
                // pop loading page
                Navigator.pop(context);
                // show recipt page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionReceipt(
                              subTitle: "Bill Payment",
                              transactionValue: _amountController.text.trim(),
                              pageDetails: {
                                "Card Number":
                                    concealCardNumber(selectedCard.cardNumber),
                                "Amount": _amountController.text.trim(),
                                "Meter Number":
                                    _meterNumberController.text.trim(),
                                "Date": date,
                                ...returnValue,
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
