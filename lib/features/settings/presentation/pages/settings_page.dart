import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            // Profile Section
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&auto=format&fit=crop&w=256&q=80'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.edit, size: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Mohamad Ayad',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 32),

            // Settings Group 1
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.person_outline,
                    title: 'Account',
                    trailingWidget: const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 18),
                    onTap: () => context.push('/account'),
                  ),
                  Container(height: 2, color: Colors.white),
                  _buildSettingsItem(
                    icon: Icons.language,
                    title: 'Languages',
                    trailingWidget: const Text("English", style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600, fontSize: 14)),
                    onTap: () => _showTopDialog(context, _buildAppLanguageDialog(context)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Settings Group 2
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.light_mode_outlined,
                    title: 'Appearance',
                    trailingWidget: const Text("Light", style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600, fontSize: 14)),
                    onTap: () => _showTopDialog(context, _buildAppearanceDialog(context)),
                  ),
                  Container(height: 2, color: Colors.white),
                  _buildSettingsItem(
                    icon: Icons.palette_outlined,
                    title: 'View',
                    trailingWidget: const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 18),
                    onTap: () => context.push('/view'),
                  ),
                  Container(height: 2, color: Colors.white),
                  _buildSettingsItem(
                    icon: Icons.circle,
                    iconColor: const Color(0xFF1E293B),
                    title: 'Accent color',
                    trailingWidget: const Text("Default", style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600, fontSize: 14)),
                    onTap: () => _showTopDialog(context, _buildIconColorDialog(context)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Settings Group 3
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Supports',
                    trailingWidget: const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 18),
                    onTap: () => context.push('/supports'),
                  ),
                  Container(height: 2, color: Colors.white),
                  _buildSettingsItem(
                    icon: Icons.info_outline,
                    title: 'Lynq Features',
                    trailingWidget: const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 18),
                  ),
                  Container(height: 2, color: Colors.white),
                  _buildSettingsItem(
                    icon: Icons.system_update_alt_outlined,
                    title: 'Lynq Updates',
                    trailingWidget: const Text("v1.0.0", style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 120), // Add padding for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Widget? trailingWidget,
    VoidCallback? onTap,
    Color iconColor = const Color(0xFF64748B),
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              if (trailingWidget != null) trailingWidget,
            ],
          ),
        ),
      ),
    );
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
    String selectedLanguage = 'English';

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDialogHeader(context, 'App language', showDone: false),
              const SizedBox(height: 16),
              _buildRadioItem('Default (system)', selectedLanguage == 'Default (system)', () => setState(() => selectedLanguage = 'Default (system)')),
              const SizedBox(height: 8),
              _buildRadioItem('العربية', selectedLanguage == 'العربية', () => setState(() => selectedLanguage = 'العربية')),
              const SizedBox(height: 8),
              _buildRadioItem('English', selectedLanguage == 'English', () => setState(() => selectedLanguage = 'English')),
            ],
          ),
        );
      }
    );
  }

  Widget _buildAppearanceDialog(BuildContext context) {
    String selectedAppearance = 'Light';

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDialogHeader(context, 'Appearance', showDone: false),
              const SizedBox(height: 16),
              _buildRadioItem('Default (system)', selectedAppearance == 'Default (system)', () => setState(() => selectedAppearance = 'Default (system)')),
              const SizedBox(height: 8),
              _buildRadioItem('Light', selectedAppearance == 'Light', () => setState(() => selectedAppearance = 'Light')),
              const SizedBox(height: 8),
              _buildRadioItem('Dark', selectedAppearance == 'Dark', () => setState(() => selectedAppearance = 'Dark')),
              const SizedBox(height: 8),
              _buildRadioItem('Night', selectedAppearance == 'Night', () => setState(() => selectedAppearance = 'Night')),
            ],
          ),
        );
      }
    );
  }

  Widget _buildRadioItem(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8F9FA) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
              ? Border.all(color: Colors.grey.shade200, width: 1.5) 
              : Border.all(color: Colors.transparent, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
            ),
            if (isSelected)
              const Icon(Icons.radio_button_checked, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIconColorDialog(BuildContext context) {
    String selectedColor = 'Default';

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDialogHeader(context, 'Accent color', showDone: false),
              const SizedBox(height: 16),
              _buildColorItem('Default', const Color(0xFF1E293B), selectedColor == 'Default', () => setState(() => selectedColor = 'Default')),
              const SizedBox(height: 8),
              _buildColorItem('Purple', const Color(0xFF8B5CF6), selectedColor == 'Purple', () => setState(() => selectedColor = 'Purple')),
              const SizedBox(height: 8),
              _buildColorItem('Red', const Color(0xFFDC2626), selectedColor == 'Red', () => setState(() => selectedColor = 'Red')),
            ],
          ),
        );
      }
    );
  }

  Widget _buildColorItem(String text, Color color, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8F9FA) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
              ? Border.all(color: Colors.grey.shade200, width: 1.5) 
              : Border.all(color: Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
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
              const Icon(Icons.radio_button_checked, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }
}
