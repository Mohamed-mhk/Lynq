import 'package:flutter/material.dart';

import '../../../../features/settings/presentation/pages/settings_page.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import '../../../../features/channel/presentation/pages/create_channel_page.dart';
import '../../../../features/channel/presentation/pages/channel_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isDrawerOpen = false;

  void _handleDrawerChanged(bool isOpen) {
    if (_isDrawerOpen != isOpen) {
      setState(() {
        _isDrawerOpen = isOpen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              HomeContent(onDrawerChanged: _handleDrawerChanged),
              const SettingsPage(),
              const ProfilePage()
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            bottom: _isDrawerOpen ? -150 : 0, // Moves off-screen gently bypassing Scaffold truncation
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        icon: Icons.home_filled,
                        label: 'Home',
                        index: 0,
                        isSelected: _currentIndex == 0,
                      ),
                      _buildNavItem(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                        index: 1,
                        isSelected: _currentIndex == 1,
                      ),
                      _buildNavItem(
                        icon: Icons.account_circle_outlined,
                        label: 'Profile',
                        index: 2,
                        isSelected: _currentIndex == 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey[500],
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final ValueChanged<bool>? onDrawerChanged;

  const HomeContent({super.key, this.onDrawerChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      onDrawerChanged: onDrawerChanged,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 72,
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            );
          }
        ),
        title: const Text(
          'Lynq',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChannelPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Cossthub',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B), // Dark slate
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'زر جديد بعنوان محاضرات النظري',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.settings,
                          color: Colors.cyanAccent,
                          size: 24,
                        ), // Mocking the logo inner part
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 120,
              ), // Spacing to center the spinner roughly
              // Simple large progress spinner to simulate UI image
              SizedBox(
                width: 72,
                height: 72,
                child: CircularProgressIndicator(
                  value: 0.75, // Keeps the indicator completely static
                  strokeWidth: 8,
                  color: Colors.grey[800],
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          children: [
            // Create Channel
            InkWell(
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateChannelPage(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Create Channel',
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Divider(color: Colors.grey[100], thickness: 1),
            const SizedBox(height: 24),

            // My Post Lists
            const Text(
              'My Post Lists',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPostListItem('محاضرات علوم الحاسوب'),
            const SizedBox(height: 16),
            _buildPostListItem('محاضرات علوم الحاسوب'),
            const SizedBox(height: 16),
            _buildPostListItem('محاضرات علوم الحاسوب'),
            
            const SizedBox(height: 24),
            Divider(color: Colors.grey[100], thickness: 1),
            const SizedBox(height: 24),
            
            // My Channels
            const Text(
              'My Channels',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildChannelItem('cossthub', context),
            const SizedBox(height: 16),
            _buildChannelItem('cossthub', context),
            const SizedBox(height: 16),
            _buildChannelItem('cossthub', context),
          ],
        ),
      ),
    );
  }

  Widget _buildPostListItem(String title) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey[800],
          // Placeholder for the post list image
          child: const Icon(Icons.domain, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelItem(String title, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChannelPage()),
        );
      },
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.settings, // Using the same mocked icon
                color: Colors.cyanAccent,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

