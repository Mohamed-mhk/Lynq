import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  bool _isMenuOpen = false;
  bool _showGridMenu = false;
  bool _isEditMode = false;
  bool _isMoveMode = false;
  String? _currentSubMenu;

  // Reorderable menu items data
  final List<Map<String, dynamic>> _rootMenuItems = [
    {'icon': Icons.description_outlined, 'title': 'Announcements', 'subtitle': '12 posts', 'isHidden': false},
    {'icon': Icons.grid_view_outlined, 'title': 'Study Resources', 'subtitle': '6 buttons', 'isHidden': false},
    {'icon': Icons.link, 'title': 'Open Registration', 'subtitle': null, 'isHidden': false},
    {'icon': Icons.description_outlined, 'title': 'FAQs', 'subtitle': '8 posts', 'isHidden': true},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFE2E8F0), // Outer background for desktop
      body: Center(
        child: Container(
          // Phone frame simulator
          width: isDesktop ? 420 : size.width,
          height: isDesktop ? 850 : size.height,
          margin: isDesktop 
              ? const EdgeInsets.symmetric(vertical: 40)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA), // Inner page background
            borderRadius: BorderRadius.circular(isDesktop ? 44 : 0),
            boxShadow: [
              if (isDesktop)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDesktop ? 44 : 0),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: safePadding.top > 0 ? safePadding.top : 24),
                    
                    // Top Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left Pill
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_isEditMode) {
                                      setState(() => _isEditMode = false);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Icon(Icons.arrow_back, color: Color(0xFF1E293B), size: 22),
                                ),
                                const SizedBox(width: 8),
                                if (_isEditMode)
                                  DottedBorder(
                                    options: const RoundedRectDottedBorderOptions(
                                      color: Color(0xFF7C3AED),
                                      strokeWidth: 1.5,
                                      dashPattern: [6, 4],
                                      radius: Radius.circular(20),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF7C3AED),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            'Edit mode',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Color(0xFF7C3AED),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                else ...[
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF4F46E5), // Indigo blue
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'L',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Lynq Official',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          
                          // Right Pill / Dropdown
                          if (_isEditMode)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => _isEditMode = false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(Icons.close, color: Color(0xFF1E293B), size: 22),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => _isEditMode = false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF7C3AED),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.check, color: Colors.white, size: 22),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isMenuOpen = !_isMenuOpen;
                                });
                              },
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Color(0xFF1E293B),
                                  size: 24,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Content Area
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true, // Makes the content align to the bottom and start scrolled down
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 24), // Top clearance
                            
                            // Message 1
                            _buildMessageCard(
                              dotColor: const Color(0xFF7C3AED), // Purple
                              category: 'ANNOUNCEMENTS',
                              contentWidget: const Text(
                                'Welcome to Lynq. We just shipped the new v4 design system. Tap any button below to explore.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  color: Color(0xFF1E293B),
                                  height: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildMessageCard(
                              dotColor: const Color(0xFF7C3AED), // Purple
                              category: 'asdasd',
                              contentWidget: const Text(
                                'Welcome to Lynq. We just shipped the new v4 design system. Tap any button below to explore.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  color: Color(0xFF1E293B),
                                  height: 1.5,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Message 2
                            _buildMessageCard(
                              dotColor: const Color(0xFF7C3AED), // Purple
                              category: 'RESOURCES',
                              contentWidget: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE0E7FF),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.insert_drive_file_outlined,
                                        color: Color(0xFF4F46E5),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Onboarding Guide 2026.pdf',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F172A),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '2.4 MB Â· PDF Document',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 13,
                                              color: Color(0xFF94A3B8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Bottom clearance for the floating pill or grid menu
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubic,
                              height: _showGridMenu 
                                  ? (safePadding.bottom > 0 ? safePadding.bottom + 90 + (isDesktop ? 350 : size.height * 0.38) : 110 + (isDesktop ? 350 : size.height * 0.38))
                                  : (safePadding.bottom > 0 ? safePadding.bottom + 100 : 120),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Floating Dropdown Menu
                if (_isMenuOpen)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            top: (safePadding.top > 0 ? safePadding.top : 24) + 60,
                            right: 20, 
                            child: const MenuCard(),
                          ),
                        ],
                      ),
                    ),
                  ),

                // The full-screen blocking overlay has been removed so the user can still scroll the chat.

                // Floating Bottom Pill (animates out when grid menu opens)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  bottom: !_showGridMenu ? (safePadding.bottom > 0 ? safePadding.bottom + 20 : 40) : -100,
                  left: 20,
                  child: BottomPill(
                    onGridTap: () {
                      setState(() {
                        _showGridMenu = true;
                      });
                    },
                    onEditTap: () {
                      setState(() {
                        _isEditMode = true;
                        _showGridMenu = true;
                      });
                    },
                  ),
                ),

                // Bottom Grid Menu (animates in from bottom)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  bottom: _showGridMenu ? 0 : -600,
                  left: 0,
                  right: 0,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x230F1118),
                          blurRadius: 22,
                          offset: Offset(0, 10),
                          spreadRadius: -10,
                        ),
                        BoxShadow(
                          color: Color(0x380F1118),
                          blurRadius: 54,
                          offset: Offset(0, 26),
                          spreadRadius: -20,
                        ),
                        BoxShadow(
                          color: Color(0x0F0F1118),
                          blurRadius: 0,
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // LAYER 2: Menu Items (Scrollable content)
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: (isDesktop ? 350 : size.height * 0.38) + 120, // accommodate buttons and list
                        ),
                        child: _isMoveMode && _currentSubMenu == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 80,
                                left: 14,
                                right: 14,
                                bottom: safePadding.bottom > 0 ? safePadding.bottom + 16 : 32,
                              ),
                              child: ReorderableListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                buildDefaultDragHandles: false,
                                proxyDecorator: (child, index, animation) {
                                  return Material(
                                    color: Colors.transparent,
                                    elevation: 6,
                                    shadowColor: Colors.black.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(16),
                                    child: child,
                                  );
                                },
                                itemCount: _rootMenuItems.length,
                                onReorder: (oldIndex, newIndex) {
                                  setState(() {
                                    if (newIndex > oldIndex) newIndex--;
                                    final item = _rootMenuItems.removeAt(oldIndex);
                                    _rootMenuItems.insert(newIndex, item);
                                  });
                                },
                                itemBuilder: (context, index) {
                                  final item = _rootMenuItems[index];
                                  return Padding(
                                    key: ValueKey(item['title']),
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: _buildMoveListItem(
                                      item['icon'] as IconData,
                                      item['title'] as String,
                                      item['subtitle'] as String?,
                                      index: index,
                                      isHidden: item['isHidden'] as bool,
                                    ),
                                  );
                                },
                              ),
                            )
                          : SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: 80,
                            left: 14,
                            right: 14,
                            bottom: safePadding.bottom > 0 ? safePadding.bottom + 16 : 32,
                          ),
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.05, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Column(
                              key: ValueKey<String>(_currentSubMenu ?? 'root'),
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_currentSubMenu == null) ...[
                                  for (int i = 0; i < _rootMenuItems.length; i++) ...[
                                    if (i > 0) const SizedBox(height: 8),
                                    _buildMenuListItem(
                                      _rootMenuItems[i]['icon'] as IconData,
                                      _rootMenuItems[i]['title'] as String,
                                      _rootMenuItems[i]['subtitle'] as String?,
                                      isHidden: _rootMenuItems[i]['isHidden'] as bool,
                                      onTap: () => setState(() => _currentSubMenu = _rootMenuItems[i]['title'] as String),
                                    ),
                                  ],
                                ] else if (_currentSubMenu == 'Study Resources') ...[
                                  _buildMenuListItem(Icons.book_outlined, 'Mathematics', '12 files'),
                                  const SizedBox(height: 8),
                                  _buildMenuListItem(Icons.science_outlined, 'Physics', '8 files'),
                                  const SizedBox(height: 8),
                                  _buildMenuListItem(Icons.computer_outlined, 'Computer Science', '24 files'),
                                ] else ...[
                                  _buildMenuListItem(Icons.folder_outlined, 'Empty Folder', '0 files'),
                                ],
                                if (_isEditMode && !_isMoveMode) ...[
                                  const SizedBox(height: 8),
                                  DottedBorder(
                                    options: const RoundedRectDottedBorderOptions(
                                      color: Color(0xFF7C3AED),
                                      strokeWidth: 2.0,
                                      dashPattern: [8, 4],
                                      radius: Radius.circular(16),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8FAFC),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.add, color: Color(0xFF7C3AED)),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // LAYER 3: The Two Buttons on Top
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Stack(
                          children: [
                            // White fade (ignores pointer so user can scroll through the gap between buttons!)
                            IgnorePointer(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white,
                                      Colors.white.withValues(alpha: 0.9),
                                      Colors.white.withValues(alpha: 0.0),
                                    ],
                                    stops: const [0.0, 0.6, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            // The actual interactive buttons
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 14,
                                right: 14,
                                bottom: 6,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: _isMoveMode
                                  ? [
                                    // MOVE MODE HEADER
                                    // Left: Back arrow
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 44,
                                        width: 44,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
                                          ],
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B), size: 20),
                                          onPressed: () {
                                            setState(() {
                                              _isMoveMode = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    // Center: "Edit mode" dashed pill
                                    Align(
                                      alignment: Alignment.center,
                                      child: DottedBorder(
                                        options: RoundedRectDottedBorderOptions(
                                          radius: const Radius.circular(20),
                                          color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                                          strokeWidth: 1.5,
                                          dashPattern: const [4, 4],
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF7C3AED),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              const Text(
                                                'Edit mode',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Color(0xFF7C3AED),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Right: X (cancel) and âœ“ (confirm)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isMoveMode = false;
                                              });
                                            },
                                            child: const Icon(Icons.close, color: Color(0xFF64748B), size: 24),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isMoveMode = false;
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF7C3AED),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.check, color: Colors.white, size: 22),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                  : [
                                    // Action buttons (Back and Edit)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                        if (_currentSubMenu != null) ...[
                                          Container(
                                            height: 44,
                                            width: 44,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
                                              ],
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
                                              onPressed: () {
                                                setState(() {
                                                  _currentSubMenu = null;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                        ],
                                        Container(
                                          height: 44,
                                          width: 44,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
                                            ],
                                          ),
                                          child: _isEditMode
                                              ? Theme(
                                                  data: Theme.of(context).copyWith(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.black.withValues(alpha: 0.05),
                                                  ),
                                                  child: PopupMenuButton<String>(
                                                    icon: const Icon(Icons.more_vert, color: Color(0xFF1E293B)),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    color: Colors.white,
                                                    elevation: 10,
                                                    shadowColor: Colors.black.withValues(alpha: 0.2),
                                                    offset: const Offset(0, 48),
                                                    onSelected: (value) {
                                                      if (value == 'move') {
                                                        setState(() {
                                                          _isMoveMode = true;
                                                        });
                                                      }
                                                    },
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        value: 'move',
                                                        height: 50,
                                                        child: Row(
                                                          children: const [
                                                            Icon(Icons.dashboard_customize_outlined, color: Color(0xFF0F172A), size: 22),
                                                            SizedBox(width: 14),
                                                            Text('Move', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF0F172A))),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 'select',
                                                        height: 50,
                                                        child: Row(
                                                          children: const [
                                                            Icon(Icons.checklist, color: Color(0xFF0F172A), size: 22),
                                                            SizedBox(width: 14),
                                                            Text('Select', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF0F172A))),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 'create',
                                                        height: 50,
                                                        child: Row(
                                                          children: const [
                                                            Icon(Icons.add_box_outlined, color: Color(0xFF0F172A), size: 22),
                                                            SizedBox(width: 14),
                                                            Text('Create post', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF0F172A))),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : IconButton(
                                                  icon: const Icon(Icons.edit_outlined, color: Color(0xFF1E293B)),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isEditMode = true;
                                                    });
                                                  },
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Center Submenu title
                                  if (_currentSubMenu != null)
                                    Align(
                                      alignment: Alignment.center,
                                      child: DottedBorder(
                                        options: RoundedRectDottedBorderOptions(
                                          radius: const Radius.circular(20),
                                          color: const Color(0xFF6366F1).withValues(alpha: 0.5), // Soft Indigo border
                                          strokeWidth: 1.5,
                                          dashPattern: const [4, 4],
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Container(
                                          width:125,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFEEF2FF), // Light indigo background
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            '$_currentSubMenu...',
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: Color(0xFF4F46E5), // Indigo text
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),

                                  // Right Pill (Home and Close Grid)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (_currentSubMenu != null) ...[
                                            IconButton(
                                              icon: const Icon(Icons.home_outlined, color: Color(0xFF1E293B)),
                                              onPressed: () {
                                                setState(() {
                                                  _currentSubMenu = null;
                                                });
                                              },
                                            ),
                                          ],
                                          IconButton(
                                            icon: Stack(
                                              children: [
                                                const Icon(Icons.grid_view_outlined, color: Color(0xFF1E293B)),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(2),
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(Icons.close, size: 10, color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _showGridMenu = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    );
  }

  Widget _buildMessageCard({
    required Color dotColor,
    required String category,
    required Widget contentWidget,
    Color categoryColor = const Color(0xFF64748B),
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: categoryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (_isEditMode)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.visibility_off_outlined, color: Color(0xFFCBD5E1), size: 16),
                ),
            ],
          ),
          const SizedBox(height: 16),
          contentWidget,
        ],
      ),
    );
  }

  Widget _buildMoveListItem(IconData icon, String title, String? subtitle, {required int index, bool isHidden = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF94A3B8), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isHidden)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.visibility_off_outlined, color: const Color(0xFFCBD5E1), size: 18),
            ),
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.drag_indicator, color: Color(0xFF94A3B8), size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuListItem(IconData icon, String title, String? subtitle, {bool isHidden = false, VoidCallback? onTap}) {
    if (_isEditMode) {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Row(
                children: [
                  Icon(icon, color: const Color(0xFF94A3B8), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (isHidden)
                    const Icon(Icons.visibility_off_outlined, color: Color(0xFFCBD5E1), size: 18),
                ],
              ),
            ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: DottedBorder(
              options: const RoundedRectDottedBorderOptions(
                color: Color(0xFF7C3AED),
                strokeWidth: 2.0,
                dashPattern: [8, 4],
                radius: Radius.circular(16),
                padding: EdgeInsets.zero,
              ),
              child: Container(
                height: subtitle != null ? 60 : 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Color(0xFF7C3AED)),
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(icon, color: const Color(0xFF94A3B8), size: 22),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          _buildMenuItem(Icons.share_outlined, 'Share'),
          _buildMenuItem(Icons.link, 'Copy link'),
          _buildMenuItem(Icons.delete_outline, 'Delete channel', isDestructive: true),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isDestructive = false}) {
    final color = isDestructive ? const Color(0xFFDC2626) : const Color(0xFF1E293B);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomPill extends StatelessWidget {
  final VoidCallback onGridTap;
  final VoidCallback onEditTap;

  const BottomPill({super.key, required this.onGridTap, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.grid_view, color: Color(0xFF1E293B), size: 24),
                onPressed: onGridTap,
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444), // red badge
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF1E293B), size: 24),
            onPressed: onEditTap,
          ),
        ],
      ),
    );
  }
}

