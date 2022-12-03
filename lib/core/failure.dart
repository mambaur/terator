// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class Failure implements Exception {
//   int? statusCode;
//   String? title, message;

//   Failure({this.statusCode, this.message, this.title});
// }

// class NotFoundException extends Failure {
//   NotFoundException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class UnAuthorizedException extends Failure {
//   UnAuthorizedException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class BadRequestException extends Failure {
//   BadRequestException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class AccessForbiddenException extends Failure {
//   AccessForbiddenException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class TimeOutException extends Failure {
//   TimeOutException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class ServerErrorException extends Failure {
//   ServerErrorException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class FetchErrorException extends Failure {
//   FetchErrorException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// class UnHandledException extends Failure {
//   UnHandledException({int? statusCode, String? title, String? message})
//       : super(statusCode: statusCode, title: title, message: message);
// }

// mixin HandleException {
//   dynamic handleHttpResponse(http.Response http) {
//     switch (http.statusCode) {
//       case 200:
//         return json.decode(http.body);
//       case 201:
//         return json.decode(http.body);
//       case 400:
//         throw BadRequestException(
//             statusCode: http.statusCode, message: 'Bad Request.');
//       case 401:
//         throw UnAuthorizedException(
//             statusCode: http.statusCode, message: 'Unauthorized.');
//       case 403:
//         throw AccessForbiddenException(
//             statusCode: http.statusCode, message: 'Forbidden.');
//       case 404:
//         throw NotFoundException(
//             statusCode: http.statusCode, message: 'Data tidak ditemukan.');
//       case 408:
//         throw TimeOutException(
//             statusCode: http.statusCode, message: 'Time Out.');
//       case 500:
//         throw ServerErrorException(
//             statusCode: http.statusCode,
//             message:
//                 'Terjadi kesalahan server, silahkan coba kembali beberapa saat nanti.');
//       case 503:
//         throw ServerErrorException(
//             statusCode: http.statusCode, message: 'Service Unavailable');
//       default:
//         throw FetchErrorException(
//             statusCode: http.statusCode,
//             message: 'Terjadi kesalahan. Status code : ${http.statusCode}');
//     }
//   }

//   Failure handleError(Object error, {StackTrace? stackTrace}) {
//     if (kDebugMode) print(error.toString());
//     if (error is Failure) {
//       return error;
//     } else {
//       log('Unhandled Exception!', stackTrace: stackTrace);
//       return UnHandledException(
//           message:
//               'Terjadi Kesalahan, silahkan coba kembali beberapa saat nanti.');
//     }
//   }
// }