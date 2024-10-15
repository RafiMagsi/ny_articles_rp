import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ny_articles_rp/application_layer/services/app_exceptions.dart';

const Duration TIME_OUT_DURATION = Duration(minutes: 1);

// API Client to call any kind of API Url
class APIClient {
  final Dio _client = Dio();

  // Get Request
  Future<dynamic> get(String url, {file = false, Map<String, String>? headers}) async {
    var uri = url;
    debugPrint('===GET request===, url: $uri');

    var responseJson = {};
    try {
      final response = await _client.get(uri).timeout(TIME_OUT_DURATION);
      responseJson = _returnResponse(response);
    } on TimeoutException {
      debugPrint('Request timed out');
      throw ApiNotRespondingException('API not responding in time', uri);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection', uri);
    }

    debugPrint('---GET completed---, url: $url');
    return responseJson;
  }

  // Post request
  Future<dynamic> post(String baseUrl, String url, dynamic payloadObj) async {
    debugPrint('===POST request===, url: $url');
    var uri = baseUrl + url;
    var payload = json.encode(payloadObj);
    debugPrint(payload);
    dynamic responseJson;
    try {
      final response = await _client.post(uri, data: payload).timeout(TIME_OUT_DURATION);
      responseJson = _returnResponse(response);
    } on TimeoutException {
      debugPrint('Request timed out');
      throw ApiNotRespondingException('API not responding in time', uri);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection', uri);
    }
    return responseJson;
  }

  // Return response according to the Status code, or throw exception
  dynamic _returnResponse(Response response) {
    debugPrint("Response: ${response.data}");
    switch (response.statusCode) {
      case 200:
        dynamic responseJson;
        if (response.data.isEmpty) {
          responseJson = {};
        } else {
          responseJson = json.decode(utf8.decode(response.data));
        }
        return responseJson;
      case 204:
        return {};
      case 400:
        throw BadRequestException(utf8.decode(response.data), response.requestOptions.path.toString());
      case 401:
      case 403:
        throw UnauthorisedException(utf8.decode(response.data), response.requestOptions.path.toString());
      case 422:
        var responseJson = json.decode(utf8.decode(response.data));
        return responseJson;
      case 500:
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
            response.requestOptions.path.toString());
    }
  }

  void close() => _client.close();
}
