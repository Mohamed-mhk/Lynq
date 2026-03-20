import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;

  const SignInRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyEmailRequested extends AuthEvent {
  final String email;
  final String code;

  const VerifyEmailRequested({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}

class CreateProfileRequested extends AuthEvent {
  final String email;
  final String fullName;
  final String username;

  const CreateProfileRequested({
    required this.email,
    required this.fullName,
    required this.username,
  });

  @override
  List<Object?> get props => [email, fullName, username];
}
