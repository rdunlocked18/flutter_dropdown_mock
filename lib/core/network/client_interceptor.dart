import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';

class ClientInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      Constants.headerContentTypeKey: Constants.contentType,
      Constants.headerXAPIKey: dotenv.env[Constants.dotEnvKeyAPI],
      Constants.headerUserAgentKey: Constants.userAgent,
    });
    super.onRequest(options, handler);
  }
}
