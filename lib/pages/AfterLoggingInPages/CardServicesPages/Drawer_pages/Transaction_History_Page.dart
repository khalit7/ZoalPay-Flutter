import 'dart:core';
import 'package:ZoalPay/lang/Localization.dart';
import 'package:ZoalPay/models/transaction_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/ReceiptPages/Transaction_Receipt.dart';
import 'package:ZoalPay/utils/stringManipulation.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class TransactionHistoryPage extends StatefulWidget {
  static final pageName = "TransactionHistoryPage";
  final List<TransactionModel> transactionsList;
  TransactionHistoryPage({this.transactionsList});

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  TextEditingController dateController;
  String selectedDate = "";
  List<TransactionModel> displayedTransactions;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayedTransactions = widget.transactionsList;
  }

  void displayTransactionDetails(TransactionModel transaction) {
    if (!transaction.isSuccessful) return;
    Map _pageDetails = {};
    if (transaction.pan != null) _pageDetails["Card Number"] = transaction.pan;
    if (transaction.date != null)
      _pageDetails["Date"] = DateFormat.yMd().format(transaction.date);
    if (transaction.number != null) _pageDetails["number"] = transaction.number;
    if (transaction.comment != null)
      _pageDetails["Comment"] = transaction.comment;
    if (transaction.voucherCode != null)
      _pageDetails["Voucher Code"] = transaction.voucherCode;
    if (transaction.reciverCard != null)
      _pageDetails["To Card"] = concealCardNumber(transaction.reciverCard);
    if (transaction.customerName != null)
      _pageDetails["customer Name"] = transaction.customerName;
    if (transaction.token != null) _pageDetails["token"] = transaction.token;
    if (transaction.meterNumber != null)
      _pageDetails["Meter Number"] = transaction.meterNumber;
    if (transaction.waterFees != null)
      _pageDetails["water Fees"] = transaction.waterFees;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionReceipt(
                  subTitle: transaction.type,
                  transactionValue: beautifyTransactionAmount(
                      transaction.transactionAmount.toString()),
                  pageDetails: _pageDetails,
                )));
  }

  build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Localization.of(context).getTranslatedValue("Transaction History")),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("filter by date"),
            trailing: Text(selectedDate),
            onTap: () {
              _selectDate(context);
            },
          ),
          Expanded(
            child: ListView(
              children: displayedTransactions
                  .map((transaction) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          elevation: 2,
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                transaction.transactionIcon,
                              ],
                            ),
                            title: Text(transaction.type),
                            subtitle: Text(
                              transaction.responseMessage +
                                  "\n" +
                                  DateFormat.yMd().format(transaction.date),
                            ),
                            isThreeLine: true,
                            trailing: _transactionStatusIcon(
                                transaction, width, height),
                            onTap: () {
                              displayTransactionDetails(transaction);
                            },
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _transactionStatusIcon(
      TransactionModel transaction, var width, var height) {
    Icon tranStatusIcon;
    TextStyle customTextStyle;
    switch (transaction.cashStatus) {
      case cashStatusEnum.cashIn:
        tranStatusIcon = Icon(Icons.arrow_downward, color: Colors.green);
        customTextStyle =
            TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
        break;
      case cashStatusEnum.cashOut:
        tranStatusIcon = Icon(Icons.arrow_upward, color: Colors.red);
        customTextStyle =
            TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
        break;
      case cashStatusEnum.neutral:
        tranStatusIcon = Icon(
          Icons.circle,
          color: Colors.grey,
        );
        customTextStyle =
            TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);
        break;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "\SDG " +
              "${beautifyTransactionAmount(transaction.transactionAmount.toString())}",
          style: customTextStyle,
        ),
        SizedBox(
          width: 20,
        ),
        tranStatusIcon,
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if (pickedDate != null)
      setState(() {
        selectedDate = DateFormat.yMd().format(pickedDate);
        _filterarray(pickedDate);
      });
  }

  bool _isTheSameDate(DateTime date1, DateTime date2) {
    if ((date1.year == date2.year) &&
        (date1.month == date2.month) &&
        (date1.day == date2.day))
      return true;
    else
      return false;
  }

  _filterarray(DateTime date) {
    displayedTransactions = widget.transactionsList;
    displayedTransactions = displayedTransactions
        .where((transaction) => _isTheSameDate(transaction.date, date))
        .toList();
  }
}
