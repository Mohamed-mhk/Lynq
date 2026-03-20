import 'package:dartz/dartz.dart';
import '../../../../core/errors.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CreateProfile {
  final AuthRepository repository;

  CreateProfile(this.repository);

  Future<Either<Failure, User>> call(
    String email,
    String fullName,
    String username,
  ) async {
    return await repository.createProfile(email, fullName, username);
  }
}
