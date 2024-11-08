import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBarWidget({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'مشاريع',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.forum_rounded),
          label: 'منتدى',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'أحداث',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'حسابك',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF213960),
      unselectedItemColor: Colors.grey[500],
      onTap: onTap,
    );
  }
}
