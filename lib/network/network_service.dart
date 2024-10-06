import 'package:dio/dio.dart';
import 'package:gapopa_assignment/log_helper.dart';
import 'package:gapopa_assignment/network/network_exception.dart';
import 'package:gapopa_assignment/resources/app_utils.dart';

/// A service class for handling network requests using the Dio package.
///
/// The [NetworkService] class is responsible for making API calls, managing
/// network configurations, and logging requests and responses. It includes
/// error handling for network issues and timeouts.
class NetworkService {
  /// Creates an instance of [NetworkService] with default configurations.
  ///
  /// The constructor initializes the Dio instance with base URL, timeout
  /// settings, and default headers.
  NetworkService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: _apiTimeout,
            receiveTimeout: _apiTimeout,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          ),
        ) {
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

  final Dio _dio;

  /// A constant defining the timeout duration for API requests.
  static const Duration _apiTimeout = Duration(seconds: 30);

  /// A constant defining the base URL for the API.
  static const String _baseUrl = 'https://pixabay.com/';

  /// Sends a GET request to the specified endpoint.
  ///
  /// This method checks for an active internet connection before making the request.
  /// If no internet connection is available, a [NoInternetException] is thrown.
  ///
  /// - [endpoint]: The API endpoint to send the GET request to.
  ///
  /// Returns:
  /// - The response data on success.
  ///
  /// Throws:
  /// - [NoInternetException] if there is no internet connection.
  Future<dynamic> get(final String endpoint) async {
    try {
      final internetConnected = await isInternetConnected();
      if (!internetConnected) {
        throw NoInternetException('Internet connection not available');
      }
      final Response response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      // Rethrow the error for further handling
      rethrow;
    }
  }
}
