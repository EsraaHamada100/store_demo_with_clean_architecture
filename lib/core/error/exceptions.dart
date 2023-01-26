class ServerException implements Exception {}

class NotFoundException implements Exception {
  String message;
  NotFoundException(this.message);
}

class EmptyCacheException implements Exception {}

class NoInternetException implements Exception {}

class UnknownException implements Exception {}
