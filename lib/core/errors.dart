abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkExceptions {
  static String getErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString();
    }
    return 'An unexpected error occurred.';
  }
}
