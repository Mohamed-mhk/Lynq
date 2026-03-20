import 'package:flutter/material.dart';

class LynqUpdatesPage extends StatelessWidget {
  const LynqUpdatesPage({super.key});

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
        title: const Text(
          'Lynq Updates',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: 2,
        itemBuilder: (context, index) {
          final showPlayButton =
              index == 1; // Play button on the second item in mockup
          return Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9), // Light grey placeholder
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(
                      // Using a simple pattern or just keeping solid color matching the check pattern mockup roughly
                      image: NetworkImage(
                        'https://via.placeholder.com/400x400.png?text=Placeholder',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: showPlayButton
                      ? Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 64,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                const Text( 
                  'Version 3.0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6.0, right: 8.0),
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: Color(0xFF1E293B),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'text text text text text text',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
