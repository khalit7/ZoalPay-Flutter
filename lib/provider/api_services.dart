import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

import 'package:ZoalPay/utils/constants.dart';
import 'package:ZoalPay/models/api_exception_model.dart' as ApiExceptions;

class NoIdTokenException implements Exception {}

class ApiService {
  String _idToken;
  String _jwt;
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

  void setIdToken(String idToken) {
    _idToken = idToken;
  }

  Future<String> fetchJwt() async {
    if (_idToken == null) {
      throw NoIdTokenException;
    }
    final endpoint = "api/authenticate";
    final response = await dio.post(
      endpoint,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: "Bearer $_idToken"},
        extra: {"jwtAuth": false},
      ),
    );
    return response.data['id_token'];
  }

  Future<String> _updateJwt() async {
    _jwt = await fetchJwt();
    return _jwt;
  }

  //
  //
  //
  Future<void> signUpWithPhoneNumber() {}

  Future<void> sendSignUpOtp(String phoneNumber) async {
    String endPoint;
    endPoint = "/api/send-otp/signup";
    String phoneNumberWithoutZero = phoneNumber.substring(1);
    Response response;
    try {
      response = await dio.post(endPoint, data: {
        "username": "$phoneNumberWithoutZero",
        "login": "$phoneNumberWithoutZero",
        "password": "$phoneNumberWithoutZero"
      });
      print("this is the response object " + response.toString());
      print("testing .... " + response.data);
    } on DioError catch (e) {
      throw ApiExceptions.parseJson(jsonDecode(e.response.data));
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
    } on DioError catch (e) {
      throw ApiExceptions.parseJson(jsonDecode(e.response.data));
    }
    // do some processing. you may need to seve some stuff to local memory (e.g: id_token , cosumer_key)
  }
}

class _JwtInterceptor extends Interceptor {
  Dio dio;
  String jwt;
  final Future<String> Function() fetchJwt;

  _JwtInterceptor({@required this.dio, this.jwt, @required this.fetchJwt});

  Future<RequestOptions> onRequest(options) async {
    bool jwtAuth = options.extra['jwtAuth'] ?? true;
    // Add Bearer Authorization HTTP header if needed
    if (jwtAuth) {
      if (jwt == null) {
        jwt = await fetchJwt();
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
