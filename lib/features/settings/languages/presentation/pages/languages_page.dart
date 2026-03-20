import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  bool isArabic = false;
  bool isEnglish = true;
  bool isSmall = false;

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
          'Languages',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Color(0xFF64748B),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Chose Language',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSwitchRow('Arabic', isArabic, (val) {
                if (!val) return;
                setState(() {
                  isArabic = true;
                  isEnglish = false;
                  isSmall = false;
                });
              }),
              _buildSwitchRow('English', isEnglish, (val) {
                if (!val) return;
                setState(() {
                  isArabic = false;
                  isEnglish = true;
                  isSmall = false;
                });
              }),
              _buildSwitchRow('small', isSmall, (val) {
                if (!val) return;
                setState(() {
                  isArabic = false;
                  isEnglish = false;
                  isSmall = true;
                });
              }),
            ],
          ),
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
