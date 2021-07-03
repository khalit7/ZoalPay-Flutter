import 'dart:convert';

import 'package:ZoalPay/models/ebs_response_model.dart';
import 'package:ZoalPay/pages/AfterLoggingInPages/CardServicesPages/Money_Transfer_Pages/Voucher_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum transactionTypeEnum {
  telecomService,
  electricityService,
  cardTransfer,
  generateVoucher,
  balanceInquiry,
  unKnown,
}
enum cashStatusEnum { cashIn, cashOut, neutral }

transactionTypeEnum determineTranTypeEnum(String type) {}

class TransactionModel {
  String pan;
  DateTime date;
  String responseMessage;
  num transactionAmount;
  String number; // phone number or meter number
  String comment;
  bool isSuccessful;
  String type;
  String reciverCard;
  String voucherCode;
  String customerName;
  String token;
  String unitsInKWh;
  String meterNumber;
  String waterFees;
  cashStatusEnum cashStatus;
  transactionTypeEnum tranTypeEnum;
  Icon transactionIcon;

  static List<TransactionModel> allTransactions = [];

  TransactionModel.fromJson(
      Map<String, dynamic> json, EbsResponseModel ebsResbonse) {
    this.pan = json['pan'];
    this.date = _formatDate(json["tranDateTime"]);
    this.responseMessage = json["responseMessage"];
    this.isSuccessful = json["responseStatus"] == "Successful";
    this.transactionAmount = json["responseStatus"] == "Successful"
        ? json["tranAmount"] != null
            ? json["tranAmount"]
            : ebsResbonse.balance
        : null;
    this.comment = json["comment"];
    this.number = ebsResbonse?.paymentInfo == null
        ? null
        : ebsResbonse.paymentInfo.toString().split("=")[1];
    this.type = json["type"].toString().split(" ").sublist(1).join();
    this.voucherCode = json["responseStatus"] == "Successful"
        ? ebsResbonse?.voucherCode
        : null;
    this.reciverCard = json["responseStatus"] == "Successful"
        ? ebsResbonse?.reciverCard
        : null;
    this.customerName = ebsResbonse?.customerName;
    this.token = ebsResbonse?.token;
    this.unitsInKWh = ebsResbonse?.unitsInKWh;
    this.meterNumber = ebsResbonse?.meterNumber;
    this.waterFees = ebsResbonse?.waterFees;
    this.tranTypeEnum = setTranTypeEnum(this.type);
    this.transactionIcon = setTranIcon(tranTypeEnum);
    this.cashStatus = setCashStatusEnum(tranTypeEnum);
  }
}

cashStatusEnum setCashStatusEnum(transactionTypeEnum tranTypeEnum) {
  cashStatusEnum cashStatus;
  switch (tranTypeEnum) {
    //todo:implement cases where cash in here
    case transactionTypeEnum.balanceInquiry:
    case transactionTypeEnum.unKnown:
      cashStatus = cashStatusEnum.neutral;
      break;
    default:
      cashStatus = cashStatusEnum.cashOut;
  }
  return cashStatus;
}

Icon setTranIcon(transactionTypeEnum tranTypeEnum) {
  Icon tranIcon;
  switch (tranTypeEnum) {
    case transactionTypeEnum.telecomService:
      tranIcon = Icon(Icons.phone);
      break;
    case transactionTypeEnum.electricityService:
      tranIcon = Icon(Icons.electrical_services_outlined);
      break;
    case transactionTypeEnum.cardTransfer:
      tranIcon = Icon(Icons.sd_card_sharp);
      break;
    case transactionTypeEnum.generateVoucher:
      tranIcon = Icon(Icons.receipt);
      break;
    case transactionTypeEnum.balanceInquiry:
      tranIcon = Icon(Icons.account_balance);
      break;
    case transactionTypeEnum.unKnown:
      tranIcon = Icon(Icons.device_unknown);
      break;

    default:
      break;
  }
  return tranIcon;
}

transactionTypeEnum setTranTypeEnum(String type) {
  transactionTypeEnum tranTypeEnum;
  switch (type) {
    case "payment-MTNTopUp":
    case "payment-ZainTopUp":
    case "payment-SudaniTopUp":
      tranTypeEnum = transactionTypeEnum.telecomService;
      break;
    case "payment-NationalElectricityCorp.":
      tranTypeEnum = transactionTypeEnum.electricityService;
      break;
    case "doCardTransfer":
      tranTypeEnum = transactionTypeEnum.cardTransfer;
      break;
    case "balanceInquiry":
      tranTypeEnum = transactionTypeEnum.balanceInquiry;
      break;
    case "generateVoucher":
      tranTypeEnum = transactionTypeEnum.generateVoucher;
      break;
    default:
      tranTypeEnum = transactionTypeEnum.unKnown;
      break;
  }
  return tranTypeEnum;
}

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
