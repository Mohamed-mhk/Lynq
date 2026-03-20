import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_profile.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/verify_email.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final VerifyEmail verifyEmail;
  final CreateProfile createProfile;

  AuthBloc({
    required this.signIn,
    required this.verifyEmail,
    required this.createProfile,
  }) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await signIn(event.email);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(CodeSent(event.email)),
      );
    });

    on<VerifyEmailRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await verifyEmail(event.email, event.code);
      result.fold((failure) => emit(AuthError(failure.message)), (success) {
        if (success) {
          emit(EmailVerified(event.email));
        } else {
          emit(const AuthError('Invalid code'));
        }
      });
    });

    on<CreateProfileRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await createProfile(
        event.email,
        event.fullName,
        event.username,
      );
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(ProfileCreated(user)),
      );
    });
  }
}
