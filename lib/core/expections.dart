class NoLocationException implements Exception {
  final String message;

  NoLocationException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
