import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  String errorDescription = "";

  switch (error.type) {
    case DioExceptionType.cancel:
      errorDescription = "Request to API server was cancelled";
      break;
    case DioExceptionType.connectionTimeout:
      errorDescription = "Connection timeout with API server";
      break;
    case DioExceptionType.receiveTimeout:
      errorDescription = "Receive timeout in connection with API server";
      break;
    case DioExceptionType.badResponse:
      {
        if (error.response?.data['code'] != null &&
            (error.response?.data['code'] ?? "0") != "0") {
          errorDescription = error.response?.data['msg'];
        } else {
          if (error.response?.statusCode == 200 &&
              ("${(error.response?.data["statusCode"] ?? "0")}" != "0")) {
            if ((error.response?.data['fault']['faultstring'] ?? "") != "") {
              errorDescription =
                  (error.response?.data['fault']['faultstring'] ?? "");
            } else {
              errorDescription = "Unknown Error";
            }
          } else if (error.response?.statusCode == 422) {
            errorDescription =
                (error.response?.data["data"] != null &&
                        error.response?.data["data"]["validations"] != null)
                    ? error
                        .response
                        ?.data["data"]["validations"]
                        .values
                        .first[0]
                    : error.response?.data["errors"] == null
                    ? error.response?.data['fault']['faultstring'] ??
                        "Unknown Error"
                    : error.response?.data["errors"].values.first[0] ??
                        error.response?.data['fault']['faultstring'] ??
                        "Unknown Error";
          } else if (error.response?.statusCode == 413) {
            errorDescription = error.response!.statusMessage ?? "";
          } else if (error.response?.statusCode == 400) {
            errorDescription =
                error.response?.data['fault']['faultstring'] ?? "Unknown Error";
          } else if (error.response?.statusCode == 401) {
            errorDescription =
                error.response?.data['fault']['faultstring'] ?? "Unknown Error";
          } else if (error.response?.statusCode == 403) {
            errorDescription =
                error.response?.data is String
                    ? "403 Forbidden"
                    : error.response?.data['fault']['faultstring'] ??
                        "Unknown Error";
          } else if (error.response?.statusCode == 404) {
            errorDescription =
                error.response?.data is String
                    ? "404 Unknown Error"
                    : error.response?.data['fault']['faultstring'] ??
                        "Unknown Error";
          } else if (error.response?.statusCode == 409) {
            errorDescription =
                error.response?.data['fault']['faultstring'] +
                    ",\n Minutes left to join: " +
                    error.response?.data["data"]["mins_to_join"].toString() ??
                "Unknown Error";
          } else if (error.response?.statusCode == 429) {
            errorDescription = error.response?.data['fault']['faultstring'];
          } else {
            errorDescription =
                "Received invalid status code: ${error.response?.statusCode}";
          }
        }

        break;
      }

    case DioExceptionType.sendTimeout:
      errorDescription = "Send timeout in connection with API server";
      break;
    case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      break;
    case DioExceptionType.connectionError:
      // TODO: Handle this case.
      break;
    case DioExceptionType.unknown:
      // TODO: Handle this case.
      break;
  }

  return errorDescription;
}
