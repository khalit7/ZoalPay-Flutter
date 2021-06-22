import 'package:dio/dio.dart';

class BaseException implements Exception {}

class InvalidToken extends BaseException {
  final String message;

  InvalidToken({this.message});
}

class Forbidden extends BaseException {
  final String message;

  Forbidden({this.message});
}

class UserExists extends BaseException {}

class UserDosNotExists extends BaseException {}

class WrongOtp extends BaseException {}

class UserNotFound extends BaseException {}

class ConsumerTransactionFailed extends BaseException {}

class NoResponseFromEbs extends BaseException {}

class FavouriteLocationNotFound extends BaseException {}

class RideNotFound extends BaseException {}

class PathNotFound extends BaseException {}

class NoAvailableDriver extends BaseException {}

class AlreadyConfirmed extends BaseException {}

class ServiceUnavailable extends BaseException {}

class responseStatusFailed extends BaseException {}

class InvalidIpin extends BaseException {}

class PinTriesLimitExceeded extends BaseException {}

class InvalidCard extends BaseException {}

class Unknown extends BaseException {
  final String message;
  final int statusCode;
  final String errorKey;
  final String title;

  Unknown({this.message, this.statusCode, this.errorKey, this.title});
}

BaseException parseResponse(Response response) {
  final data = response.data;
  if (data is Map<String, dynamic>) {
    return parseAPIResponseJson(data);
  }
  switch (response.statusCode) {
    case 503:
      return ServiceUnavailable();
    default:
      return Unknown(message: data, statusCode: response.statusCode);
  }
}

BaseException parseAPIResponseJson(json) {
  switch (json["errorKey"]) {
    case "idexists":
      return UserExists();
    case "noid":
      return UserDosNotExists();
    case "otpnotvalid":
      return WrongOtp();
    case "INVALIDIPIN":
      return InvalidIpin();
    default:
      return Unknown(
        message: json["message"],
        statusCode: json["status"],
        errorKey: json["errorKey"],
        title: json["title"],
      );
  }
}

BaseException parseAPIResponseToException(json) {
  switch (json["responseMessage"]) {
    case "Invalid PIN":
      return InvalidIpin();
    case "PIN tries limit was exceeded":
      return PinTriesLimitExceeded();
    default:
      return Unknown(
        message: json["message"],
        statusCode: json["status"],
        errorKey: json["errorKey"],
        title: json["title"],
      );
  }
}

BaseException parseEBSResponseJson(Map<String, dynamic> json) {
  switch (json["responseMessage"]) {
    case "Invalid card":
      return InvalidCard();
    default:
      return Unknown(
        message: "unknown error from EBS",
      );
  }
}

// class ErrorModel {
//   final String entityName;
//   final String errorKey;
//   final int statusCode;
//   final String type;
//   final String message;
//   final String params;

//   ErrorModel(
//       {this.entityName,
//       this.errorKey,
//       this.statusCode,
//       this.type,
//       this.message,
//       this.params});

//   ErrorModel.fromJson(Map<String, dynamic> json)
//       : this.entityName = json['entityName'],
//         this.errorKey = json['errorKey'],
//         this.statusCode = json['status'],
//         this.type = json['type'],
//         this.message = json['message'],
//         this.params = json['params'];
// }
