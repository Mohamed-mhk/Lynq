import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isComfortable = true;
  bool isCompressed = false;

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
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: const Text(
          'View',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9), // Light grey placeholder
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://via.placeholder.com/400x300.png?text=View+Preview',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isComfortable ? 'comfortable' : 'Compressed',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildSwitchRow('comfortable', isComfortable, (val) {
                    if (!val) return;
                    setState(() {
                      isComfortable = true;
                      isCompressed = false;
                    });
                  }),
                  _buildSwitchRow('Compressed', isCompressed, (val) {
                    if (!val) return;
                    setState(() {
                      isComfortable = false;
                      isCompressed = true;
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.black,
            activeTrackColor: Colors.white,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.white,
            trackOutlineColor: MaterialStateProperty.resolveWith(
              (states) => Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
