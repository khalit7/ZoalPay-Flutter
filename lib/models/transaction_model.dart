import 'dart:convert';

import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Voucher_Page.dart';

class TransactionModel {
  String pan;
  DateTime date;
  String responseMessage;
  num transactionAmount;
  String phoneNumber;
  String comment;
  bool isSuccessful;
  String type;
  String reciverCard;
  String voucherCode;

  static List<TransactionModel> allTransactions = [];

  TransactionModel.fromJson(Map<String, dynamic> json)
      : this.pan = json['pan'],
        this.date = _formatDate(json["tranDateTime"]),
        this.responseMessage = json["responseMessage"],
        this.isSuccessful = json["responseStatus"] == "Successful",
        this.transactionAmount = json["responseStatus"] == "Successful"
            ? json["tranAmount"] != null
                ? json["tranAmount"]
                : jsonDecode(json["ebsResponse"])["balance"]["available"]
            : null,
        this.comment = json["comment"],
        this.phoneNumber = json["ebsResponse"] == null
            ? null
            : jsonDecode(json["ebsResponse"])["paymentInfo"]
                ?.substring(7), // change this to the actual json location.
        this.type = json["type"],
        this.voucherCode = json["responseStatus"] == "Successful"
            ? jsonDecode(json["ebsResponse"])["voucherCode"]
            : null,
        this.reciverCard = json["responseStatus"] == "Successful"
            ? jsonDecode(json["ebsResponse"])["toCard"]
            : null;
}

// class ConsumerTransacionModel extends TransactionModel {
//   String type;
//   ConsumerTransacionModel(Map<String, dynamic> json) : super.fromJson(json) {
//     this.type = json["type"].substring(9);
//   }
// }

DateTime _formatDate(String dateString) {
  int year = int.parse(dateString.substring(4, 6));
  int month = int.parse(dateString.substring(2, 4));
  int day = int.parse(dateString.substring(0, 2));
  int hour = int.parse(dateString.substring(6, 8));
  int minute = int.parse(dateString.substring(8, 10));
  year = year + 2000;
  DateTime transactionDate = DateTime(year, month, day, hour, minute);

  return transactionDate;
}
