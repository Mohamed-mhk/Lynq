import 'package:flutter/material.dart';

class SupportsPage extends StatelessWidget {
  const SupportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: const Text(
          'Supports',
          style: TextStyle(
            color: Color(0xFF1E293B), // Dark slate
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                reverse: true,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA), // Very light grey
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(text: 'Hi ', style: TextStyle(color: Color(0xFF1E293B), fontSize: 18, fontWeight: FontWeight.normal)),
                            TextSpan(text: 'lynq team', style: TextStyle(color: Color(0xFF1E293B), fontSize: 18, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            // Bottom Input Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black.withValues(alpha: 0.05),
                           blurRadius: 15,
                           spreadRadius: 2,
                           offset: const Offset(0, 4),
                         ),
                       ],
                    ),
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.black, size: 28),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Chat Supports Team',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFDC2626), // Red color
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
