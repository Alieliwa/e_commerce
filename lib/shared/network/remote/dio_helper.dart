import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;

  static int() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://medicazone.online/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {String? authToken,
      @required String? url,
      Map<String, dynamic>? query}) async {
    dio!.options.headers = {
      "Authorization": authToken,
      "Content-Type": "application/json",
    };
    return await dio!.get(url!, queryParameters: query);
  }

  static Future<Response> postData({
    String? authToken,
    @required String? url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "Authorization": authToken,
      "Content-Type": "application/json",
    };
    return await dio!.post(url!, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    String? authToken,
    @required String? url,
    @required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "Authorization": authToken,
      "Content-Type": "application/json",
    };
    return await dio!.put(url!, queryParameters: query, data: data);
  }
}
