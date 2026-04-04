import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/create_profile_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/verify_email_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/settings/account/presentation/pages/account_page.dart';
import '../../features/settings/appearance/presentation/pages/appearance_page.dart';
import '../../features/settings/languages/presentation/pages/languages_page.dart';
import '../../features/settings/lynq_updates/presentation/pages/lynq_updates_page.dart';
import '../../features/settings/appearance/presentation/pages/theme_page.dart';
import '../../features/settings/appearance/presentation/pages/view_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
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
      GoRoute(
        path: '/account',
        builder: (context, state) => const AccountPage(),
      ),
      GoRoute(
        path: '/appearance',
        builder: (context, state) => const AppearancePage(),
      ),
      GoRoute(
        path: '/languages',
        builder: (context, state) => const LanguagesPage(),
      ),
      GoRoute(
        path: '/lynq-updates',
        builder: (context, state) => const LynqUpdatesPage(),
      ),
      GoRoute(path: '/theme', builder: (context, state) => const ThemePage()),
      GoRoute(path: '/view', builder: (context, state) => const ViewPage()),
    ],
  );
}
