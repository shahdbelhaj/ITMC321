import 'package:Bytes/pages/cart_page.dart';
import 'package:Bytes/pages/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/home_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/projects_screen.dart';
import 'pages/events_screen.dart';
import 'pages/forum_screen.dart';
import 'widgets/bottom_navbar.dart';
import 'widgets/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: GoogleFonts.almaraiTextTheme(),
        colorScheme: const ColorScheme.light(),
      ),
      locale: Locale('ar'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
      ],
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: StartScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;

  final String _userName = "Mohammed Khalifa";
  final String _userEmail = "mokhalifa@example.com";
  final String _profileImageUrl = "assets/images/user1.png";
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProjectsScreen(),
    ForumScreen(),
    EventsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_basket_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          _isMenuOpen
              ? AnimatedMenu(
                  closeMenu: _toggleMenu,
                  userName: _userName,
                  userEmail: _userEmail,
                  profileImageUrl: _profileImageUrl,
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
