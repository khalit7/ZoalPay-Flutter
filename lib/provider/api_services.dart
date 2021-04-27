import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ZoalPay/models/card_model.dart';
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
  Map profile;
  String consumerKey;
  String _jwt;
  var uuid = Uuid();
  final dio = Dio(BaseOptions(
    baseUrl: Constants.API_BASE_URL,
    contentType: Headers.jsonContentType,
    headers: {HttpHeaders.acceptHeader: Headers.jsonContentType},
  ));
  ApiService({String token, String jwt})
      : _idToken = token,
        _jwt = jwt {
    dio.transformer = FlutterTransformer();
    //dio.interceptors.add(_ErrorInterceptor());
    // dio.interceptors.add(_JwtInterceptor(
    //   dio: dio,
    //   jwt: _jwt,
    //   fetchJwt: _updateJwt,
    // ));
  }

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
      //jsonResponse = jsonDecode(response.data);
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
    return [response.data["balance"]["available"] , response.data["PAN"] ];
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
