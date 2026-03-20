import 'package:dartz/dartz.dart';
import '../../../../core/errors.dart';
import '../repositories/auth_repository.dart';

class VerifyEmail {
  final AuthRepository repository;

  VerifyEmail(this.repository);

  Future<Either<Failure, bool>> call(String email, String code) async {
    return await repository.verifyEmail(email, code);
  }
}
