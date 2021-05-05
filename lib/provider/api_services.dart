import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ZoalPay/models/card_model.dart';
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
  final String _idToken =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5MjIyMjgxMzkiLCJhdXRoIjoiQXV0aG9yaXR5e25hbWU9J1JPTEVfVVNFUid9IiwiZXhwIjoxNjIxNTI1NzI2fQ.dGDkj8xcpKmodpFsO4cl0fuc1LsqH1dQXGQD9iili8nBLGLQN3ZrwH3aJWC7WuhrvzkDNl-kDP9FVuYujP2SEQ";
  final Map profile = {
    "id": 14,
    "login": "922228139",
    "firstName": null,
    "lastName": null,
    "email": null,
    "bio": null,
    "createdDate": "2021-04-16T14:33:44Z",
    "user": {
      "id": 27,
      "login": "922228139",
      "firstName": null,
      "lastName": null,
      "email": null,
      "activated": true,
      "langKey": "en",
      "imageUrl": null,
      "resetDate": "2021-04-16T14:33:44Z"
    },
    "image": null,
    "userMessages": null,
    "comments": null,
    "likes": null,
    "posts": null,
    "contacts": null,
    "transactions": null,
    "favorites": null,
    "cards": null,
    "internetCards": null
  };
  final String consumerKey =
      "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANx4gKYSMv3CrWWsxdPfxDxFvl+Is/0kc1dvMI1yNWDXI3AgdI4127KMUOv7gmwZ6SnRsHX/KAM0IPRe0+Sa0vMCAwEAAQ==";
  String _jwt;
  var uuid = Uuid();
  final dio = Dio(BaseOptions(
    baseUrl: Constants.API_BASE_URL,
    contentType: Headers.jsonContentType,
    headers: {HttpHeaders.acceptHeader: Headers.jsonContentType},
  ));
  // ApiService({String token, String jwt})
  //     : _idToken = token,
  //       _jwt = jwt {
  //   dio.transformer = FlutterTransformer();
  //   //dio.interceptors.add(_ErrorInterceptor());
  //   // dio.interceptors.add(_JwtInterceptor(
  //   //   dio: dio,
  //   //   jwt: _jwt,
  //   //   fetchJwt: _updateJwt,
  //   // ));
  // }

  // void setIdToken(String idToken) {
  //   _idToken = idToken;
  // }

  // Future<String> fetchJwt() async {
  //   if (_idToken == null) {
  //     throw NoIdTokenException;
  //   }
  //   final endpoint = "api/authenticate";
  //   final response = await dio.post(
  //     endpoint,
  //     options: Options(
  //       headers: {HttpHeaders.authorizationHeader: "Bearer $_idToken"},
  //       extra: {"jwtAuth": false},
  //     ),
  //   );
  //   return response.data['id_token'];
  // }

  // Future<String> _updateJwt() async {
  //   _jwt = await fetchJwt();
  //   return _jwt;
  // }

  // Future<void> signUpWithPhoneNumber() {}

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

      // profile = jsonResponse["profile"];
      // consumerKey = jsonResponse["consumerKey"];
      // _idToken = jsonResponse["id_token"];

      dio.interceptors.add(_JwtInterceptor(
        dio: dio,
        jwt: _idToken,
      ));
    } on DioError catch (e) {
      throw ApiExceptions.parseAPIResponseJson(jsonDecode(e.response.data));
    }
    // do some processing. you may need to seve some stuff to local memory (e.g: id_token , cosumer_key)
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
    dio.interceptors.add(_JwtInterceptor(
      dio: dio,
      jwt: _idToken,
    )); // TODO: delete this line when you finish testing
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

  Future<List> getBalance(CardModel card, String Ipin) async {
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
    return [response.data["balance"]["available"], response.data["PAN"]];
  }

  Future<List<PayeeModel>> getPayeeList() async {
    String endpoint = "/api/consumer/load-payees";

    Response response = await dio.get(endpoint);
    List<PayeeModel> allPayees = response.data
        .map<PayeeModel>((payeeJson) => PayeeModel.fromJson(payeeJson))
        .toList();

    return allPayees;
  }

  // Future<List> mobileTopUp(CardModel card, String Ipin, int amount,
  //     PayeeModel payee, String phoneNumber, String comment) async {
  //   String phoneNumberWithoutZero = phoneNumber.substring(1);
  //   String endpoint = "/api/consumer/payment";
  //   String transactionUUID = uuid.v1();
  //   String encryptedIPIN =
  //       EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");

  //   Map data = {
  //     "UUID": "$transactionUUID",
  //     "IPIN": "$encryptedIPIN",
  //     "tranAmount": amount,
  //     "tranCurrency": "SDG",
  //     "PAN": "${card.cardNumber}",
  //     "expDate": "${card.expiryDate}",
  //     "authenticationType": "00",
  //     "entityType": null,
  //     "entityId": null,
  //     "fromAccountType": "00",
  //     "toAccountType": "00",
  //     "paymentInfo": "MPHONE=" + "$phoneNumberWithoutZero",
  //     "payeeId": "$payee.payeeName",
  //     "comment": "$comment"
  //   };

  //   Response response = await dio.post(endpoint, data: data);

  //   return [response.data["PAN"], response.data["billInfo"]["subNewBalance"]];
  // }

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

  Future<String> payBill(CardModel card, String Ipin, int amount,
      PayeeModel payee, String phoneNumber, String comment) async {
    String endpoint = "/api/consumer/payment";
    String phoneNumberWithoutZero = phoneNumber.substring(1);
    String transactionUUID = uuid.v1();
    String encryptedIPIN =
        EncrypterUtil.encrypt("$transactionUUID" + "$Ipin", "$consumerKey");

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
      "paymentInfo": "MPHONE=" + "$phoneNumberWithoutZero",
      "payeeId": "${payee.payeeName}",
      "comment": "$comment"
    };

    Response response = await dio.post(endpoint, data: data);
    return response.data["PAN"];
  }

  Future<List<TransactionModel>> getTransactionHistory() async {
    String endpoint = "/api/profile-transactions";

    Response response = await dio.get(endpoint);
    List<TransactionModel> allTransactions = [];
    // loop throw all transactions
    response.data["content"].forEach((transactionJson) {
      if (transactionJson["type"].startsWith("Consumer"))
        allTransactions.add(TransactionModel.fromJson(transactionJson));
      //TODO:implement other cases here
    });
    //filter unwanted transactions
    allTransactions.where((transaction) {
      if (transaction.type.split(" ").last == "getPayeesList")
        return false;
      else
        return true;
    }).toList();
    return allTransactions;
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
