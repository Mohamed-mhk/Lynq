import 'package:flutter/material.dart';

import '../../../../features/settings/presentation/pages/settings_page.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import '../../../../features/channel/presentation/pages/create_channel_page.dart';
import '../../../../features/channel/presentation/pages/channel_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isDrawerOpen = false;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
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
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.drag_handle, color: Colors.black, size: 32),
                        onPressed: () {
                          // TODO: implement drawer open if desired here
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              spreadRadius: 1,
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
                              svgIconPath: 'assets/icons/setting icon.svg',
                              label: 'Settings',
                              index: 1,
                              isSelected: _currentIndex == 1,
                            ),
                            _buildNavItem(
                              imageUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&auto=format&fit=crop&w=256&q=80',
                              label: 'Profile',
                              index: 2,
                              isSelected: _currentIndex == 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    IconData? icon,
    String? imageUrl,
    String? assetImagePath,
    String? svgIconPath,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    final Color itemColor = isSelected ? Colors.black : const Color(0xFFC2C2C2);
    
    return GestureDetector(
      onTap: () {
        if (_currentIndex != index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70, // Provide consistent width so items have tap area
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl != null)
              Opacity(
                opacity: isSelected ? 1.0 : 0.4,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else if (assetImagePath != null)
              Opacity(
                opacity: isSelected ? 1.0 : 0.4,
                child: Image.asset(
                  assetImagePath,
                  width: 28,
                  height: 28,
                ),
              )
            else if (svgIconPath != null)
              Opacity(
                opacity: isSelected ? 1.0 : 0.4,
                child: SvgPicture.asset(
                  svgIconPath,
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
                ),
              )
            else if (icon != null)
              Icon(
                icon,
                color: itemColor,
                size: 32,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: itemColor,
              ),
            ),
          ],
        ),
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

