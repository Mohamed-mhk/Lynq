import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopIcon(Icons.language, () => _showTopDialog(context, _buildAppLanguageDialog(context))),
                  Row(
                    children: [
                      _buildTopIcon(Icons.palette_outlined, () => _showTopDialog(context, _buildIconColorDialog(context))),
                      const SizedBox(width: 16),
                      _buildTopIcon(Icons.light_mode_outlined, () => _showTopDialog(context, _buildAppearanceDialog(context))),
                    ],
                  ),
                ],
              ),
            ),
            
            // const Spacer(flex: 2),
            
            // Logo & Title
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFF7C3AED), // Purpleish color
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.hub, // Network/Connection icon
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Discover. Save. Connect.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B), // Dark slate
              ),
            ),
            
            const Spacer(flex: 2),
            
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildPrimaryButton(
                    context, 
                    label: 'Sign in', 
                    onPressed: () => context.push('/sign-in')
                  ),
                  const SizedBox(height: 16),
                  _buildSecondaryButton(
                    context, 
                    label: 'Log in', 
                    onPressed: () => context.push('/sign-in') // Assuming sign-in for now
                  ),
                  const SizedBox(height: 16),
                  _buildSecondaryButton(
                    context, 
                    label: 'Continue with Google', 
                    icon: _buildGoogleIcon(),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildSecondaryButton(
                    context, 
                    label: 'Continue with Apple', 
                    icon: const Icon(Icons.apple, color: Colors.black, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Bottom text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLinkText('Terms of us'),
                const Text(' . ', style: TextStyle(color: Colors.grey, fontSize: 14)),
                _buildLinkText('Privacy Policy'),
              ],
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTopIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
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
      child: Center(
        child: Icon(icon, color: Colors.black, size: 24),
      ),
    ));
  }

  void _showTopDialog(BuildContext context, Widget dialogContent) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: dialogContent,
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Start from deep right
            end: Offset.zero, // End exactly in the center
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuint, // Energetic deceleration
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogHeader(BuildContext context, String title, {bool showDone = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        if (showDone)
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.check, size: 20, color: Colors.black),
            ),
          ),
      ],
    );
  }

  Widget _buildAppLanguageDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDialogHeader(context, 'App language', showDone: true),
          const SizedBox(height: 16),
          _buildRadioItem('Default (system)', false),
          _buildRadioItem('العربية', false),
          _buildRadioItem('English', true),
        ],
      ),
    );
  }

  Widget _buildAppearanceDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDialogHeader(context, 'Appearance', showDone: true),
          const SizedBox(height: 16),
          _buildRadioItem('Default (system)', false),
          _buildRadioItem('Light', true),
          _buildRadioItem('Dark', false),
          _buildRadioItem('Night', false),
        ],
      ),
    );
  }

  Widget _buildRadioItem(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
          ),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isSelected ? Colors.black : Colors.grey.shade400,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildIconColorDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDialogHeader(context, 'Icon color', showDone: false),
          const SizedBox(height: 24),
          _buildColorItem('Default', const Color(0xFF1E293B), true),
          const SizedBox(height: 16),
          _buildColorItem('Purple', const Color(0xFF8B5CF6), false),
          const SizedBox(height: 16),
          _buildColorItem('Red', const Color(0xFFDC2626), false),
        ],
      ),
    );
  }

  Widget _buildColorItem(String text, Color color, bool isSelected) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
          ),
        ),
        if (isSelected)
          const Icon(Icons.check, color: Colors.black, size: 24),
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, {required String label, Widget? icon, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
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
            if (icon != null)
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
            Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
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
