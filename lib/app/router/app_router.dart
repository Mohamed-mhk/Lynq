import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/create_profile_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/verify_email_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome', //that's was intial location
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) {
          final String email = state.extra as String? ?? 'example@email.com';
          return VerifyEmailPage(email: email);
        },
      ),
      GoRoute(
        path: '/create-profile',
        builder: (context, state) {
          final String email = state.extra as String? ?? 'example@email.com';
          return CreateProfilePage(email: email);
        },
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}
