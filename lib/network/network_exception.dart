/// An exception that represents network-related errors.
///
/// This class extends the built-in [Exception] class and is used to handle
/// errors that occur during network operations. It includes an optional
/// message and a prefix to provide more context about the error.
class NetworkException implements Exception {
  /// Creates a [NetworkException] with an optional message and prefix.
  ///
  /// - [message]: An optional error message describing the network issue.
  /// - [prefix]: An optional prefix for categorizing the type of error.
  NetworkException([this._message, this._prefix]);

  /// The error message associated with the exception.
  final String? _message;

  /// An optional prefix that can provide additional context for the error.
  final String? _prefix;

  @override
  String toString() {
    if (_prefix != null) {
      return '$_prefix $_message';
    }

    return _message ?? '';
  }
}

/// An exception that indicates no internet connectivity.
///
/// This class extends [NetworkException] and is used specifically
/// to represent scenarios where the device is not connected to the internet.
class NoInternetException extends NetworkException {
  /// Creates a [NoInternetException] with a specified message.
  ///
  /// - [message]: A message describing the reason for the exception.
  NoInternetException(final String message) : super(message);
}