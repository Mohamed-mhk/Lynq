import 'package:dartz/dartz.dart';
import '../../../../core/errors.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithEmail(String email);
  Future<Either<Failure, bool>> verifyEmail(String email, String code);
  Future<Either<Failure, User>> createProfile(
    String email,
    String fullName,
    String username,
  );
}
