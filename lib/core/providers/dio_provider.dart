import 'dart:collection';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = AppDio.getInstance(ref);
  ref.onDispose(() {
    dio.close();
  });
  return dio;
});

class AppDio with DioMixin implements Dio {
  final ProviderReference ref;

  AppDio._(this.ref, [BaseOptions? options]) {
    options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;
    this.interceptors.add(InterceptorsWrapper(
      onRequest: (requestOptions, handler){
        var token = 'adjhsakdjhaskdjhasjd';
        Map tokenHeader = new Map<String, String>();
        if (token != null) {
          tokenHeader['Authorization'] = 'Bearer ' + token.toString();
          requestOptions.headers.addAll(tokenHeader as Map<String, dynamic>);
        }

        return handler.next(requestOptions);
      },
      onError: (requestOptions, handler){
        print('error woy');
        return handler.next(requestOptions);
      },
      onResponse: (requestOptions, handler){
        var temp = requestOptions.data;
        requestOptions.data = temp;

        return handler.next(requestOptions);
      }
    ));


    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }

    // if(!kIsWeb) {
    //   // Use flutter_secure_storage
    //   // Create storage
    //   final storage = new FlutterSecureStorage();
    // }

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance(ProviderReference ref) => AppDio._(ref);
}
