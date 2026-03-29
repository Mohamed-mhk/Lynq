import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController _codeController = TextEditingController();
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(() {
      if (_hasError) {
        setState(() {
          _hasError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
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
                    color: Colors.black.withOpacity(0.05),
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
          'Verify your account',
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
          if (state is EmailVerified) {
            context.push('/create-profile', extra: state.email);
          } else if (state is AuthError) {
            setState(() {
              _hasError = true;
            });
          }
        },
        builder: (context, state) {
          final topPadding = MediaQuery.of(context).padding.top;
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
                  
                  // Verification Text
                  const Text(
                    "We've sent a 6-digit verification code to",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 4),     
                  
                  // Email
                  Text(
                    widget.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  
                  // Change Email link
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.chevron_left, color: Color(0xFF5B30CA), size: 18),
                        const Text(
                          'Change Email',
                          style: TextStyle(
                            color: Color(0xFF5B30CA),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF5B30CA),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.edit_outlined, color: Color(0xFF5B30CA), size: 14),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _hasError ? 'Enter Verification Code' : 'Verification Code',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF94A3B8), // slate-400
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Icon(Icons.assignment_outlined, size: 16, color: Color(0xFF125BB5)),
                            SizedBox(width: 4),
                            Text(
                              'Paste Code',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF125BB5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Enter Code Field
                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enter code',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                      filled: true,
                      fillColor: const Color(0xFFFAFAFA),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: _hasError ? const Color(0xFFDC2626) : const Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: _hasError ? const Color(0xFFDC2626) : const Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: _hasError ? const Color(0xFFDC2626) : const Color(0xFF94A3B8)),
                      ),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _codeController,
                        builder: (context, value, child) {
                          if (value.text.isEmpty) return const SizedBox.shrink();
                          return IconButton(
                            icon: const Icon(Icons.cancel, color: Color(0xFFBDBDBD), size: 18),
                            onPressed: () {
                              _codeController.clear();
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Error Message
                  if (_hasError) ...[
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                         Icon(Icons.close, color: Color(0xFFDC2626), size: 18),
                         SizedBox(width: 4),
                         Text('Incorrect code', style: TextStyle(color: Color(0xFFDC2626), fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Resend vs Open App actions
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {}, 
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF8FAFC), 
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                          icon: const Icon(Icons.refresh, color: Color(0xFF7C3AED), size: 18),
                          label: const Text('Resend Code', style: TextStyle(color: Color(0xFF7C3AED), fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {}, 
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF8FAFC),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                          icon: const Icon(Icons.mail_outline, color: Color(0xFF7C3AED), size: 18),
                          label: const Text('Open App', style: TextStyle(color: Color(0xFF7C3AED), fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
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
                  const SizedBox(height: 16),

                  // Verify and Continue Button
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _codeController,
                    builder: (context, value, child) {
                      final isNotEmpty = value.text.isNotEmpty;
                      final isLoading = state is AuthLoading;

                      Color btnBackgroundColor;
                      if (_hasError) {
                          btnBackgroundColor = const Color(0xFF808080);
                      } else if (isNotEmpty) {
                          btnBackgroundColor = Colors.black;
                      } else {
                          btnBackgroundColor = const Color(0xFF808080);
                      }

                      return SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: (isNotEmpty && !isLoading && !_hasError)
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  context.read<AuthBloc>().add(
                                    VerifyEmailRequested(
                                      email: widget.email,
                                      code: _codeController.text,
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: btnBackgroundColor,
                            disabledBackgroundColor: btnBackgroundColor,
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
                                'Verify and Continue',
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
                  SizedBox(height: bottomPadding > 0 ? bottomPadding : 24),
                ],
              ),
            ),
          );
        },
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
