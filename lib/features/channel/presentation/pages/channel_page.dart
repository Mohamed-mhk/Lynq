import 'package:flutter/material.dart';
import 'channel_info_page.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  bool _showGridMenu = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Handled keyboard visibility independently to allow overlapping
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double menuHeight = _showGridMenu ? 260.0 + bottomPadding : bottomPadding;
    final double spacerHeight = bottomInset > menuHeight ? bottomInset : menuHeight;

    return PopScope(
      canPop: !_showGridMenu,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_showGridMenu) {
          setState(() {
            _showGridMenu = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 72,
        leading: Padding(
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
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChannelInfoPage()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.settings, color: Colors.cyanAccent, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cossthub',
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '792 subscribers',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: Container(
              width: 40,
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
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159),
                  child: const Icon(Icons.reply, color: Colors.black, size: 20),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24.0),
                children: [
                  // Message 1 (Text)
                  _buildMessageRow(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'wrgrgrgrrrrhrh\nleije;lihgelsdvk/dvh/dlkhvd/klvhklv/dhlh\ndvldi;vyd;i\ndvihydilvd',
                        style: TextStyle(color: Color(0xFF1E293B), fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                  
                  // Message 2 (Image + text)
                  _buildMessageRow(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1D4ED8), // Deep blue
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(Icons.settings, color: Colors.blue[300]!.withOpacity(0.5), size: 100),
                                ),
                                Center(
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.download, color: Colors.black87),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildDot(true),
                                      _buildDot(false),
                                      _buildDot(false),
                                      _buildDot(false),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'wrgrgrgrrrrhrh\nleije;lihgelsdvk/dvh/dlkhvd/klvhklv/dhlh\ndvldi;vyd;i\ndvihydilvd',
                              style: TextStyle(color: Color(0xFF1E293B), fontSize: 16, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Message 3 (File)
                  _buildMessageRow(
                    title: 'جدول المحاضرات',
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                const Center(child: Icon(Icons.picture_as_pdf, color: Colors.grey, size: 28)),
                                Center(
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
                                      ],
                                    ),
                                    child: const Icon(Icons.download, color: Colors.black, size: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'جدول التحضيرات الاسبوعي.pdf',
                                  style: TextStyle(
                                    color: Color(0xFF8B5CF6), // Purple color from image
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '2.81 MB',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
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
            
            // Bottom Input Area
            Container(
              color: const Color(0xFFFAFAFA),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildIconButton(Icons.attach_file, onTap: () {}),
                  const SizedBox(width: 8),
                  _buildIconButton(
                    Icons.grid_view_rounded, 
                    onTap: () {
                      if (_focusNode.hasFocus) {
                        _focusNode.unfocus();
                        if (!_showGridMenu) {
                          setState(() {
                            _showGridMenu = true;
                          });
                        }
                      } else {
                        setState(() {
                          _showGridMenu = !_showGridMenu;
                        });
                      }
                    }
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                           BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset:const Offset(0,2))
                        ]
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: 'Create Content',
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.send, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

                // Bottom spacer for Keyboard/Menu
                AnimatedContainer(
                  duration: Duration(milliseconds: bottomInset > 0 ? 0 : 250),
                  curve: Curves.easeOutCubic,
                  height: spacerHeight,
                ),
              ],
            ),

            // Fixed Grid Menu positioned under the keyboard
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomPadding,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: _showGridMenu ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: !_showGridMenu,
                  child: _buildGridMenu(),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildMessageRow({String? title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                child,
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
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
            child: Icon(Icons.delete_outline, color: Colors.grey[500], size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, color: Colors.black, size: 20),
        ),
      ),
    );
  }

  static Widget _buildGridMenu() {
    return Container(
      height: 260,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          _buildMenuButton('إختيار المرحلة', isFullWidth: true),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildMenuButton('جدول المحاضرات')),
              const SizedBox(width: 8),
              Expanded(child: _buildMenuButton('جدول الفاينل')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildMenuButton('كورسات')),
              const SizedBox(width: 8),
              Expanded(child: _buildMenuButton('كورسات')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildMenuButton('كورسات')),
              const SizedBox(width: 8),
              Expanded(child: _buildMenuButton('كورسات')),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildMenuButton(String text, {bool isFullWidth = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
