import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:testsweets/src/models/outgoing_event.dart';

const _baseUrl = String.fromEnvironment(
  'TESTSWEETS_BASE_URL',
  defaultValue: _useFirebaseEmulator
      ? 'http://10.0.2.2:5001/sessionmate-93c0e/us-central1'
      : 'https://us-central1-sessionmate-93c0e.cloudfunctions.net',
);
const _useFirebaseEmulator =
    bool.fromEnvironment('TESTSWEETS_USE_FIREBASE_EMULATOR');
const _idToken = String.fromEnvironment('TESTSWEETS_ID_TOKEN');

enum _HttpMethod {
  get,
  post,
  put,
  delete,
}

class HttpService {
  late final Dio _httpClient;

  HttpService() {
    _httpClient = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: _baseUrl,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $_idToken',
        },
      ),
    );

    _httpClient.interceptors.add(TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        printRequestData: true,
        printResponseData: false,
      ),
    ));
  }

  Future<void> captureEvents({
    required String projectId,
    required List<OutgoingEvent> events,
  }) async {
    await _makeHttpRequest(
      method: _HttpMethod.get,
      path: '/events-api/submitEvents',
      body: {
        'projectId': projectId,
        'events': events,
      },
    );
  }

  Future<Response?> _makeHttpRequest({
    required _HttpMethod method,
    required String path,
    Map<String, dynamic> queryParameteres = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Response? response;
    final requestOptions = Options(
      // headers: await _getHeaders(),
      // We don't throw exceptions for anything under 500
      // we need to handle it
      validateStatus: (status) =>
          (status ?? 500) < 500 || (status ?? 500) == 505,
    );
    try {
      switch (method) {
        case _HttpMethod.post:
          response = await _httpClient.post(
            path,
            queryParameters: queryParameteres,
            data: body,
            options: requestOptions,
          );
          break;
        case _HttpMethod.put:
          response = await _httpClient.put(
            path,
            queryParameters: queryParameteres,
            data: body,
            options: requestOptions,
          );
          break;
        case _HttpMethod.delete:
          response = await _httpClient.delete(
            path,
            queryParameters: queryParameteres,
            options: requestOptions,
          );
          break;
        case _HttpMethod.get:
        default:
          response = await _httpClient.get(
            path,
            queryParameters: queryParameteres,
            options: requestOptions,
          );
      }
    } on DioException catch (e) {
      print('🔴 DioError: $e');
    } catch (e) {
      print('🔴 HttpService exception: $e');
    }

    return response;
  }
}
