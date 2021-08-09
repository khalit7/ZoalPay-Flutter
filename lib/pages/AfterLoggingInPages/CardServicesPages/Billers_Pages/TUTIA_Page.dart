import 'package:ZoalPay/Widgets/Custom_Drawer.dart';
import 'package:ZoalPay/Widgets/Loading_widget.dart';
import 'package:ZoalPay/Widgets/Submit_Button.dart';
import 'package:ZoalPay/Widgets/error_widgets.dart';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/provider/api_services.dart';
import 'package:ZoalPay/utils/validators.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ZoalPay/utils/constants.dart';

class TUTIAPage extends StatefulWidget {
  static final pageName = "TUTIAPage";

  @override
  _TUTIAPageState createState() => _TUTIAPageState();
}

class _TUTIAPageState extends State<TUTIAPage> {
  var _cardNameController = TextEditingController();

  var _amountController = TextEditingController();

  var _commentController = TextEditingController();

  var _ipinController = TextEditingController();

  bool _validate = false;
  CardModel selectedCard;
  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          Localization.of(context).getTranslatedValue("TUTIA"),
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
                    _cardNameController.text = selectedCard?.cardUserName ?? "";
                  },
                  onSubmitted: (string) {},
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
                  controller: _amountController,
                  onChanged: (string) {},
                  onSubmitted: (string) {},
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
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
                isAmountValid(_amountController.text.trim()) &&
                isIpinValid(_ipinController.text.trim())) {
              try {
                // attempt transaction
                showLoadingDialog(context);
                Map<dynamic, dynamic> returnValue = await context
                    .read<ApiService>()
                    .payBill(
                        selectedCard,
                        _ipinController.text.trim(),
                        int.parse(_amountController.text.trim()),
                        tutiaPayeeModel,
                        "number",
                        _commentController.text.trim(),
                        paymentType.customPayment);
                String date = DateFormat.yMd().format(DateTime.now());
                Navigator.pop(context);
              } catch (e) {
                Navigator.pop(context);
                showErrorWidget(
                    context, "Somthing went wrong, please try again later");
              }
            }
          })
        ],
      ),
    );
  }
}
