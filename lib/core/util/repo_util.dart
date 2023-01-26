import 'package:dartz/dartz.dart';
import '../network/network_info.dart';

import '../error/exceptions.dart';
import '../error/failure.dart';

class RepositoriesUtil {
  static Future<Either<Failure, Unit>> getMessage({
    required Future<Unit> Function() deleteOrUpdateOrAddFunction,
    required NetworkInfo networkInfo,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        deleteOrUpdateOrAddFunction();
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure());
      } on NoInternetException {
        return const Left(NoInternetFailure());
      } on UnknownException {
        return const Left(UnknownFailure());
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
