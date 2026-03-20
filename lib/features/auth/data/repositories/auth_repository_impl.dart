import 'package:dartz/dartz.dart';
import '../../../../core/errors.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmail(String email) async {
    try {
      final response = await remoteDataSource.signInWithEmail(email);
      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail(String email, String code) async {
    try {
      final response = await remoteDataSource.verifyEmail(email, code);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> createProfile(
    String email,
    String fullName,
    String username,
  ) async {
    try {
      final response = await remoteDataSource.createProfile(
        email,
        fullName,
        username,
      );
      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
