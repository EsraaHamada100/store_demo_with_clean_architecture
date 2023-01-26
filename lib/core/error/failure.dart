import 'package:equatable/equatable.dart';

import '../strings/failure_strings.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure() : super(SERVER_FAILURE_MESSAGE);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure() : super(EMPTY_CACHE_FAILURE_MESSAGE);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super(NO_INTERNET_MESSAGE);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(UNKNOWN_FAILURE_MESSAGE);
}
