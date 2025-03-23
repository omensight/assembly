import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assembly/core/app_environment.dart';
import 'package:assembly/features/auth/presentation/controllers/login_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/io.dart';
part 'client_providers.g.dart';

@riverpod
Dio authenticationDio(Ref ref) {
  final dio = Dio();
  if (AppEnvironment.debugModeEnabled && !kIsWeb) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () =>
            HttpClient()
              ..badCertificateCallback =
                  (X509Certificate cert, String host, int port) => true;
  }
  return dio;
}

@riverpod
String baseUrl(Ref ref) {
  return AppEnvironment.serverBaseUrl;
}

@riverpod
String baseWebsocketsUrl(Ref ref) {
  return AppEnvironment.serverWebsocketsBaseUrl;
}

@riverpod
Stream<dynamic> actionsChannel(Ref ref) {
  HttpClient client = HttpClient();

  if (AppEnvironment.debugModeEnabled && !kIsWeb) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  }
  final serverToken = ref
      .watch(serverTokenProvider)
      .when(
        data: (data) => data,
        error: (error, stackTrace) => null,
        loading: () => null,
      );

  if (serverToken != null) {
    return IOWebSocketChannel.connect(
      Uri.parse('${ref.watch(baseWebsocketsUrlProvider)}actions_notifier/'),
      headers: {'Authorization': 'Token ${serverToken.token}'},
      customClient: client,
    ).stream;
  }
  return Stream.error(LocaleKeys.failureCannotConnectToTheServer.tr());
}

@riverpod
Dio mainDio(Ref ref) {
  final serverToken = ref
      .watch(serverTokenProvider)
      .when(
        data: (data) => data,
        error: (error, stackTrace) => null,
        loading: () => null,
      );

  final dio = Dio(
    BaseOptions(headers: {'Authorization': 'Token ${serverToken?.token}'}),
  );
  if (AppEnvironment.debugModeEnabled && !kIsWeb) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () =>
            HttpClient()
              ..badCertificateCallback =
                  (X509Certificate cert, String host, int port) => true;
  }

  return dio;
}
