import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 4.0, bottom: 4.0),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
            ),
          ),
        ),
        title: const Text(
          'Sign in or log in',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is CodeSent) {
            context.push('/verify-email', extra: state.email);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final bottomPadding = MediaQuery.of(context).padding.bottom;

          return SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                      
                      // Logo
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xFF7C3AED), // Purpleish color
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.hub, color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Title
                      const Center(
                        child: Text(
                          'Discover. Save. Connect.',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      
                      // Email Label
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF94A3B8), // slate-400
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Email Field
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'example@email.com',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                          filled: true,
                          fillColor: const Color(0xFFFAFAFA),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)), // slate-200
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFF94A3B8)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Send Verification Code Button
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _emailController,
                        builder: (context, value, child) {
                          final isEmailNotEmpty = value.text.isNotEmpty;
                          final isLoading = state is AuthLoading;

                          return SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: (isEmailNotEmpty && !isLoading)
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      context.read<AuthBloc>().add(
                                        SignInRequested(_emailController.text),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isEmailNotEmpty
                                    ? Colors.black
                                    : const Color(0xFF808080),
                                disabledBackgroundColor: isEmailNotEmpty
                                    ? Colors.black // Keep it black when loading
                                    : const Color(0xFF808080),
                                foregroundColor: Colors.white,
                                disabledForegroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isLoading) ...[
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                  const Text(
                                    'Send Verification Code',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (!isLoading) ...[
                                    const SizedBox(width: 8),
                                    const Icon(Icons.chevron_right, size: 20),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      // OR Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade200)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'OR',
                              style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade200)),
                        ],
                      ),
                      const SizedBox(height: 32),
                  
                      // Google Button
                      SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            side: BorderSide(color: Colors.grey.shade200, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: _buildGoogleIcon(),
                              ),
                              const Center(
                                child: Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                  
                      // Bottom Term text
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLinkText('Terms of us'),
                          const Text(' . ', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          _buildLinkText('Privacy Policy'),
                        ],
                      ),
                      SizedBox(height: bottomPadding > 0 ? bottomPadding : 24),
                    ],
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue],
            stops: [0.0, 0.33, 0.66, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: const Center(
          child: Text(
            'G',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLinkText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF475569), // slate-600
        fontSize: 14,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationColor: Color(0xFF475569),
      ),
    );
  }
}
