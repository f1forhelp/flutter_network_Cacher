import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_network_cacher/src/constants/enums.dart';
import 'package:flutter_network_cacher/src/db/db.dart';
import 'package:flutter_network_cacher/src/helper/map_helper.dart';

class DioCacheInterceptor extends Interceptor {
  late Dio _dio;

  static const String kPost = "POST";
  static const String kGet = "GET";
  static const String kPatch = "PATCH";
  static const String kPut = "PUT";
  static const String kDelete = "DELETE";

  DioCacheInterceptor({required Dio dioInstance}) {
    _dio = Dio();
    _dio.transformer = dioInstance.transformer;
    _dio.httpClientAdapter = dioInstance.httpClientAdapter;
    _dio.options = dioInstance.options;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? data = await Db.getStringData(key: _getStorageUrl(options));
    var dioCacheOptions = MapHelper.getDioCacheOptionsFromExtras(options);
    if (data == null ||
        (dioCacheOptions?.dioCacheMethod == DioCacheMethod.noCache)) {
      super.onRequest(options, handler);
    } else {
      try {
        loadAsyncRequest(options, _dio);

        handler.resolve(
            Response(requestOptions: options, data: json.decode(data)), true);
      } catch (e) {
        print("ErrorIs:$e");
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    var dioCacheOptions =
        MapHelper.getDioCacheOptionsFromExtras(response.requestOptions);
    if (dioCacheOptions?.dioCacheMethod != DioCacheMethod.noCache) {
      await Db.putStringData(
          uId: _getStorageUrl(response.requestOptions),
          data: jsonEncode(response.data));
    }

    super.onResponse(response, handler);
  }

  Future loadAsyncRequest(RequestOptions requestOptions, Dio dio) async {
    Response response = Response(requestOptions: requestOptions);

    if (requestOptions.method == kGet) {
      response = await dio.get(
        requestOptions.path,
        queryParameters: requestOptions.queryParameters,
      );
    } else if (requestOptions.method == kPost) {
      response = await dio.post(
        requestOptions.path,
        cancelToken: requestOptions.cancelToken,
        data: requestOptions.data,
        onReceiveProgress: requestOptions.onReceiveProgress,
        queryParameters: requestOptions.queryParameters,
        onSendProgress: requestOptions.onSendProgress,
        options: Options(
          contentType: requestOptions.contentType,
          followRedirects: requestOptions.followRedirects,
          headers: requestOptions.headers,
          listFormat: requestOptions.listFormat,
          maxRedirects: requestOptions.maxRedirects,
          method: requestOptions.method,
          receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
          receiveTimeout: requestOptions.receiveTimeout,
          requestEncoder: requestOptions.requestEncoder,
          responseDecoder: requestOptions.responseDecoder,
          sendTimeout: requestOptions.sendTimeout,
          responseType: requestOptions.responseType,
          validateStatus: requestOptions.validateStatus,
        ),
      );
    }
    print(response);
    await Db.putStringData(
        uId: _getStorageUrl(requestOptions), data: jsonEncode(response.data));
  }

  _getStorageUrl(RequestOptions options) {
    return options.uri.toString() +
        options.data.toString() +
        options.headers.toString();
  }
}
