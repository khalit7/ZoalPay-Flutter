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

  build(context) {
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
                  .map((transaction) => Container(
                        child: ListTile(
                          title: Text(transaction.type),
                          subtitle: Text(
                            transaction.responseMessage +
                                "\n" +
                                DateFormat.yMd().format(transaction.date),
                          ),
                          isThreeLine: true,
                          trailing:
                              _transactionStatusIcon(transaction.isSuccessful),
                          onTap: () {
                            if (!transaction.isSuccessful) return;
                            Map _pageDetails = {};
                            if (transaction.pan != null)
                              _pageDetails["Card Number"] = transaction.pan;
                            if (transaction.date != null)
                              _pageDetails["Date"] =
                                  DateFormat.yMd().format(transaction.date);
                            if (transaction.phoneNumber != null)
                              _pageDetails["Phone Number"] =
                                  transaction.phoneNumber;
                            if (transaction.comment != null)
                              _pageDetails["Comment"] = transaction.comment;
                            if (transaction.voucherCode != null)
                              _pageDetails["Voucher Code"] =
                                  transaction.voucherCode;
                            if (transaction.reciverCard != null)
                              _pageDetails["To Card"] =
                                  concealCardNumber(transaction.reciverCard);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionReceipt(
                                          subTitle: transaction.type,
                                          transactionValue: transaction
                                              .transactionAmount
                                              .toString(),
                                          pageDetails: _pageDetails,
                                        )));
                            ;
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black26))),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _transactionStatusIcon(bool isSuccessful) {
    if (isSuccessful) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green)),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
        ],
      );
    }
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
