import 'package:dio/dio.dart';
import 'package:gapopa_assignment/log_helper.dart';
import 'package:gapopa_assignment/network/network_exception.dart';
import 'package:gapopa_assignment/resources/app_utils.dart';

const Duration _apiTimeout = Duration(seconds: 120);
const String _baseUrl = 'https://pixabay.com/';

class NetworkService {
  NetworkService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _apiTimeout,
        receiveTimeout: _apiTimeout,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (final options, final handler) {
          logBlueText('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (final response, final handler) {
          logGreenText('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (final DioException e, final handler) {
          logRedText('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  late Dio _dio;

  Future<dynamic> get(final String endpoint) async {
    try {
      final internetConnected = await isInternetConnected();
      if (!internetConnected) {
        throw NoInternetException('Internet connection not available');
      }
      final Response response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
