import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ZoalPay/models/card_model.dart';
import 'package:ZoalPay/models/ebs_response_model.dart';
import 'package:ZoalPay/models/payee_model.dart';
import 'package:ZoalPay/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:uuid/uuid.dart';

import 'package:ZoalPay/utils/constants.dart';
import 'package:ZoalPay/utils/encrypt.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class NoIdTokenException implements Exception {}

class ApiService {
  String _idToken;
  // =
  //   "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5MjIyMjgxMzkiLCJhdXRoIjoiQXV0aG9yaXR5e25hbWU9J1JPTEVfVVNFUid9IiwiZXhwIjoxNjU0OTc2NjE2fQ.KQH9YlOhxOjmwJOGCvj_o-vsRWvFqMd3GUrrKG_hbRR43dfhHSM5jlW9GRKsykPhbdsQmkE4ydXIVyQPJ1n1Ig";
  Map profile;
  //  = {
  //   "id": 14,
  //   "login": "922228139",
  //   "firstName": null,
  //   "lastName": null,
  //   "email": null,
  //   "bio": null,
  //   "createdDate": "2021-04-16T14:33:44Z",
  //   "user": {
  //     "id": 27,
  //     "login": "922228139",
  //     "firstName": null,
  //     "lastName": null,
  //     "email": null,
  //     "activated": true,
  //     "langKey": "en",
  //     "imageUrl": null,
  //     "resetDate": "2021-04-16T14:33:44Z"
  //   },
  //   "image": null,
  //   "userMessages": null,
  //   "comments": null,
  //   "likes": null,
  //   "posts": null,
  //   "contacts": null,
  //   "transactions": null,
  //   "favorites": null,
  //   "cards": null,
  //   "internetCards": null
  // };
  String consumerKey;
  // =
  //     "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANx4gKYSMv3CrWWsxdPfxDxFvl+Is/0kc1dvMI1yNWDXI3AgdI4127KMUOv7gmwZ6SnRsHX/KAM0IPRe0+Sa0vMCAwEAAQ==";
  String _jwt;
  var uuid = Uuid();
  final dio = Dio(BaseOptions(
      baseUrl: Constants.API_BASE_URL,
      contentType: Headers.jsonContentType,
      headers: {HttpHeaders.acceptHeader: Headers.jsonContentType},
      connectTimeout: 90 * 1000, // 90 seconds
      receiveTimeout: 90 * 1000));

  Future<void> sendOtp(String phoneNumber, otpType currentOtpType) async {
    String endPoint;
    if (currentOtpType == otpType.signUp)
      endPoint = "/api/send-otp/signup";
    else
      endPoint = "/api/send-otp/login";
    String phoneNumberWithoutZero = phoneNumber.substring(1);
    Response response;
    try {
      response = await dio.post(endPoint, data: {
        "username": "$phoneNumberWithoutZero",
        "login": "$phoneNumberWithoutZero",
        "password": "$phoneNumberWithoutZero"
      });
      print("this is the response object " + response.toString());
    } on DioError catch (e) {
      throw ApiExceptions.parseAPIResponseJson(jsonDecode(e.response.data));
    }
  }

  Future<void> validateOtp(String phoneNumber, String otp) async {
    String endpoint;
    endpoint = "/api/validate-otp";
    String phoneNumberWithoutZero = phoneNumber.substring(1);

    Response response;
    try {
      response = await dio.post(endpoint, data: {
        "login": "$phoneNumberWithoutZero",
        "otp": "$otp",
      });
      // set the tokens and other variables
      var jsonResponse = response.data;

      profile = jsonResponse["profile"];
      consumerKey = jsonResponse["consumerKey"];
      _idToken = jsonResponse["id_token"];

      dio.interceptors.add(_JwtInterceptor(
        dio: dio,
        jwt: _idToken,
      ));
    } on DioError catch (e) {
      throw ApiExceptions.parseAPIResponseJson(jsonDecode(e.response.data));
    }
  }

  Future<CardModel> addCard(String name, String expDate, String pan) async {
    String endpoint = "/api/cards";
    Map data = {
      "profile": profile,
      "name": "$name",
      "expDate": "$expDate",
      "pan": "$pan"
    };

    Response response = await dio.post(endpoint, data: data);
    return CardModel.fromJson(response.data);
  }

  Future<List<CardModel>> getAllCards() async {
    String endpoint = "/api/card-profile";
    Response response = await dio.get(endpoint);

    List<CardModel> allCards = response.data
        .map<CardModel>((cardJson) => CardModel.fromJson(cardJson))
        .toList();
    return allCards;
  }

  Future<CardModel> updateCard(CardModel card) async {
    String endpoint = "/api/cards";

    Map data = {
      "profile": profile,
      "name": "${card.cardUserName}",
      "expDate": "${card.expiryDate}",
      "pan": "${card.cardNumber}",
      "id": "${card.id}"
    };

    Response response = await dio.put(endpoint, data: data);

    return CardModel.fromJson(response.data);
  }

  Future<void> generateIpin(CardModel card) {
    String endpoint = "";
    String transactionUUID = uuid.v1();
    Map data = {
      "UUID": "$transactionUUID",
      "phoneNumber": "249 + something",
      "pan": "${card.cardNumber}",
      "expDate": "${card.expiryDate}",
    };
  }

  Future<void> generateIpinCompletion(CardModel card) {
    String endpoint = "";
    String transactionUUID = uuid.v1();

    Map data = {
      "UUID": "$transactionUUID",
      "pan": "${card.cardNumber}",
      "expDate": "${card.expiryDate}",
      "ipin": "",
      "otp": ""
    };
  }

  Future<String> getBalance(CardModel card, String Ipin) async {
    String endpoint = "/api/consumer/getBalance";

    String transactionUUID = uuid.v1();
    String encryptedIPIN =
        EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");

    Map data = {
      "UUID": "$transactionUUID",
      "IPIN": "$encryptedIPIN",
      "tranCurrency": "SDG",
      "authenticationType": "00",
      "fromAccountType": "00",
      "pan": "${card.cardNumber}",
      "expDate": "${card.expiryDate}"
    };
    Response response = await dio.post(endpoint, data: data);
    if (response.data.isEmpty) throw ApiExceptions.NoResponseFromEbs();
    print(response?.data["responseStatus"]);
    if (response?.data["responseStatus"] == "Failed")
      throw ApiExceptions.parseEBSResponseJson(response.data);
    return response.data["balance"]["available"];
  }

  Future<List<PayeeModel>> getPayeeList() async {
    String endpoint = "/api/consumer/load-payees";

    Response response = await dio.get(endpoint);
    List<PayeeModel> allPayees = response.data
        .map<PayeeModel>((payeeJson) => PayeeModel.fromJson(payeeJson))
        .toList();

    return allPayees;
  }

  Future<void> getBill(
      CardModel card, String phoneNumber, String Ipin, PayeeModel payee) async {
    String endpoint = "/api/consumer/getBill";
    String phoneNumberWithoutZero = phoneNumber.substring(1);
    String transactionUUID = uuid.v1();
    String encryptedIPIN =
        EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");

    Map data = {
      "UUID": "$transactionUUID",
      "IPIN": "$encryptedIPIN",
      "tranCurrency": "SDG",
      "PAN": "${card.cardNumber}",
      "expDate": "${card.expiryDate}",
      "authenticationType": "00",
      "entityType": null,
      "entityId": null,
      "fromAccountType": "00",
      "toAccountType": "00",
      "paymentInfo": "MPHONE=" + "$phoneNumberWithoutZero",
      "payeeId": "$payee.payeeName",
    };

    Response response = await dio.post(endpoint, data: data);
  }

  Future<Map> payBill(
      CardModel card,
      String Ipin,
      int amount,
      PayeeModel payee,
      String number, // this could be phone number or meter number
      String comment,
      paymentType paymenttype) async {
    String endpoint = "/api/consumer/payment";
    String transactionUUID = uuid.v1();
    String encryptedIPIN =
        EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");
    String paymentInfo;

    switch (paymenttype) {
      case paymentType.phoneBill:
        String phoneNumberWithoutZero = number.substring(1);
        paymentInfo = "MPHONE=" + "$phoneNumberWithoutZero";
        break;
      case paymentType.electricityBill:
        paymentInfo = "METER=" + "$number";
        break;
    }

    Map data = {
      "UUID": "$transactionUUID",
      "IPIN": "$encryptedIPIN",
      "tranAmount": amount,
      "tranCurrency": "SDG",
      "PAN": "${card.cardNumber}",
      "expDate": "${card.expiryDate}",
      "authenticationType": "00",
      "entityType": null,
      "entityId": null,
      "fromAccountType": "00",
      "toAccountType": "00",
      "paymentInfo": "$paymentInfo",
      "payeeId": "${payee.payeeName}",
      "comment": "$comment"
    };

    Response response = await dio.post(endpoint, data: data);

    if (response.data["responseStatus"] == "Failed")
      throw ApiExceptions.parseAPIResponseToException(response.data);
    else {
      // successfull transaction
      Map returnvalue = Map();
      switch (paymenttype) {
        case paymentType.phoneBill:
          break;
        case paymentType.electricityBill:
          returnvalue['token'] = response.data["billInfo"]["token"];
          returnvalue['customer Name'] =
              response.data["billInfo"]['customerName'];
          returnvalue['unitsInKWh'] = response.data["billInfo"]["unitsInKWh"];
          returnvalue['water Fees'] = response.data["billInfo"]["waterFees"];
          break;
      }
      return returnvalue;
    }
  }

  Future<List<TransactionModel>> getTransactionHistory() async {
    String endpoint = "/api/all-profile-transactions";

    Response response = await dio.get(endpoint);

    List<TransactionModel> allTransactions = [];
    // loop throw all transactions
    response.data.forEach((transactionJson) {
      EbsResponseModel ebsResbonse;
      if (transactionJson["ebsResponse"] != null)
        ebsResbonse = EbsResponseModel.fromJson(
            jsonDecode(transactionJson["ebsResponse"]));
      allTransactions
          .add(TransactionModel.fromJson(transactionJson, ebsResbonse));
    });
    //filter unwanted transactions
    allTransactions = allTransactions.where((transaction) {
      if (transaction.type.split(" ").last == "getPayeesList")
        return false;
      else if (transaction.type.split(" ").last == "getPublicKey")
        return false;
      else if (!transaction.isSuccessful)
        return false;
      else
        return true;
    }).toList();
    return allTransactions.reversed.toList();
  }

  Future<void> cardTransfer(CardModel senderCard, String reciverATMCardNmber,
      String Ipin, int amount, String comment) async {
    String endpoint = "/api/consumer/doCardTransfer";
    String transactionUUID = uuid.v1();
    String encryptedIPIN =
        EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");

    Map data = {
      "UUID": "$transactionUUID",
      "IPIN": "$encryptedIPIN",
      "tranCurrency": "SDG",
      "tranAmount": amount,
      "toCard": "$reciverATMCardNmber",
      "authenticationType": "00",
      "fromAccountType": "00",
      "toAccountType": "00",
      "PAN": "${senderCard.cardNumber}",
      "expDate": "${senderCard.expiryDate}",
      "comment": "$comment"
    };

    Response response = await dio.post(endpoint, data: data);
  }

  Future<String> generateVoucher(
      CardModel card, String Ipin, int amount, String phoneNumber) async {
    String endpoint = "/api/consumer/generateVoucher";
    String transactionUUID = uuid.v1();
    String encryptedIPIN =
        EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");
    String phoneNumberWithoutZero = phoneNumber.substring(1);

    Map data = {
      "UUID": "$transactionUUID",
      "IPIN": "$encryptedIPIN",
      "tranCurrency": "SDG",
      "tranAmount": amount,
      "voucherNumber": "$phoneNumber",
      "authenticationType": "00",
      "fromAccountType": "00",
      "toAccountType": "00",
      "PAN": "${card.cardNumber}",
      "expDate": "${card.expiryDate}"
    };

    Response response = await dio.post(endpoint, data: data);

    //TODO: do some error handeling ... to make faild transactions not lead us to recipt page.
    return response.data["voucherCode"];
  }

  void logOut() {
    dio.interceptors.removeLast();
  }
  //
}

class _JwtInterceptor extends Interceptor {
  Dio dio;
  String jwt;
  //final Future<String> Function() fetchJwt;

  _JwtInterceptor({@required this.dio, this.jwt});

  Future<RequestOptions> onRequest(options) async {
    bool jwtAuth = options.extra['jwtAuth'] ?? true;
    // Add Bearer Authorization HTTP header if needed
    if (jwtAuth) {
      if (jwt == null) {
        //jwt = await fetchJwt();
      }
      options.headers
          .putIfAbsent(HttpHeaders.authorizationHeader, () => "Bearer $jwt");
    }
    return options;
  }

  // Future onError(e) async {
  //   if (e.error is ApiExceptions.ExpiredToken) {
  //     // Renew the JWT if it expired and retry the original request
  //     jwt = await fetchJwt();
  //     return await dio.request(
  //       e.request.path,
  //       cancelToken: e.request.cancelToken,
  //       data: e.request.data,
  //       queryParameters: e.request.queryParameters,
  //       options: e.request,
  //     );
  //   }
  //   return e;
  // }
}
