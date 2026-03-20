import 'package:dartz/dartz.dart';
import '../../../../core/errors.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<Either<Failure, User>> call(String email) async {
    return await repository.signInWithEmail(email);
  }
}
