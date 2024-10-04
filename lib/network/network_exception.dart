class NetworkException implements Exception {
  NetworkException([this._message, this._prefix]);

  final String? _message;
  final String? _prefix;

  @override
  String toString() {
    if (_prefix != null) {
      return '$_prefix $_message';
    }

    return _message ?? '';
  }
}

class NoInternetException extends NetworkException {
  NoInternetException(final String message) : super(message);
}