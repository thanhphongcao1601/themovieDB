import 'package:dio/dio.dart';
import 'package:ex6/api/api_response.dart';
import 'package:ex6/api/api_route.dart';
import 'package:ex6/api/decodable.dart';
import 'package:ex6/configs/constant.dart';

// ignore: one_member_abstracts
abstract class BaseAPIClient {
  Future<ResponseWrapper<T>> request<T extends Decodable>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
  });
}

class APIClient implements BaseAPIClient {
  BaseOptions? options;
  Dio? instance;

  APIClient({this.options}) {
    options ??= BaseOptions(
        baseUrl: AppConfig.baseUrl,
        queryParameters: {"api_key": AppConfig.apiKey});
    instance = Dio(options);
  }

  @override
  Future<ResponseWrapper<T>> request<T extends Decodable>(
      {required APIRouteConfigurable route,
      required Create<T> create,
      dynamic data,
      String? extraPath,
      Map<String, dynamic>? queryParam}) async {
    final config = route.getConfig();
    config?.baseUrl = options!.baseUrl;
    config?.data = data;

    if (config == null) {
      throw ErrorResponse(message: 'Failed to load request options.');
    }

    if (queryParam != null) {
      config.queryParameters = queryParam;
    } else {
      config.queryParameters = {
        'api_key': AppConfig.apiKey,
      };
    }

    if (extraPath != null) {
      config.path += extraPath;
    }

    final response = await instance?.fetch(config);
    final responseData = response?.data;

    if (response?.statusCode == 200) {
      return ResponseWrapper.init(create: create, json: responseData);
    }

    throw ErrorResponse.fromJson(data);
  }
}
