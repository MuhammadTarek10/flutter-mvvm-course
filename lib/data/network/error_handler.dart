import 'package:dio/dio.dart';
import 'package:stores/data/network/failure.dart';
import 'package:stores/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.recieveTimeout.getFailure();
    case DioErrorType.response:
      if (error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
          error.response?.statusCode ?? 0,
          error.response?.statusMessage ?? "",
        );
      } else {
        return DataSource.unknown.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();
    case DioErrorType.other:
      return DataSource.unknown.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  notFound,
  unAuthorized,
  internalServerError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  cacheError,
  noIntentConnection,
  unknown
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
          ResponseCode.success,
          ResponseMessage.success,
        );
      case DataSource.noContent:
        return Failure(
          ResponseCode.noContent,
          ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return Failure(
          ResponseCode.badRequest,
          ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return Failure(
          ResponseCode.forbidden,
          ResponseMessage.forbidden,
        );
      case DataSource.unAuthorized:
        return Failure(
          ResponseCode.unAuthorized,
          ResponseMessage.unAuthorized,
        );
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          ResponseCode.cancel,
          ResponseMessage.cancel,
        );
      case DataSource.recieveTimeout:
        return Failure(
          ResponseCode.recieveTimeout,
          ResponseMessage.recieveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          ResponseCode.sendTimeout,
          ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          ResponseCode.cacheError,
          ResponseMessage.cacheError,
        );
      case DataSource.noIntentConnection:
        return Failure(
          ResponseCode.noIntentConnection,
          ResponseMessage.noIntentConnection,
        );
      case DataSource.notFound:
        return Failure(
          ResponseCode.notFound,
          ResponseMessage.notFound,
        );
      case DataSource.unknown:
        return Failure(
          ResponseCode.unknown,
          ResponseMessage.unknown,
        );
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int unAuthorized = 401;
  static const int internalServerError = 500;

  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int recieveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noIntentConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String success = AppStrings.success;
  static const String noContent = AppStrings.noContent;
  static const String notFound = AppStrings.notFoundError;
  static const String badRequest = AppStrings.badRequestError;
  static const String forbidden = AppStrings.forbiddenError;
  static const String unAuthorized = AppStrings.unauthorizedError;
  static const String internalServerError = AppStrings.internalServerError;
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.conflictError;
  static const String recieveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String cacheError = AppStrings.cacheError;
  static const String noIntentConnection = AppStrings.noInternetError;
  static const String unknown = AppStrings.unknownError;
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
