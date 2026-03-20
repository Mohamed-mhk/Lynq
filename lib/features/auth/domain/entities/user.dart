import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? fullName;
  final String? username;

  const User({
    required this.id,
    required this.email,
    this.fullName,
    this.username,
  });

  @override
  List<Object?> get props => [id, email, fullName, username];
}
