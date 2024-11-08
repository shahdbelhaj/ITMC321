import 'package:Bytes/pages/cart_page.dart';
import 'package:Bytes/pages/events_screen.dart';
import 'package:Bytes/pages/favorites_page.dart';
import 'package:Bytes/pages/forum_screen.dart';
import 'package:Bytes/pages/home_screen.dart';
import 'package:Bytes/pages/profile_screen.dart';
import 'package:Bytes/pages/projects_screen.dart';
import 'package:Bytes/pages/start_screen.dart';
import 'package:Bytes/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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

class AnimatedMenu extends StatelessWidget {
  final Function closeMenu;
  final String userName;
  final String userEmail;
  final String profileImageUrl;

  AnimatedMenu({
    required this.closeMenu,
    required this.userName,
    required this.userEmail,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => closeMenu(),
            child: Container(
              color: Colors.black.withOpacity(0.4), // Adjusted transparency
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Dismissible(
              key: Key('menu'),
              direction: DismissDirection.startToEnd,
              onDismissed: (_) => closeMenu(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6, // Halfway width
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: MenuContent(
                  userName: '',
                  userEmail: '',
                  profileImageUrl: '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuContent extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String profileImageUrl;

  MenuContent({
    required this.userName,
    required this.userEmail,
    required this.profileImageUrl,
  });

  @override
  _MenuContentState createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(-0.6, 0), // Slide in halfway (60% of the screen width)
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.userEmail,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            MenuItem(
              text: " الصفحة الرئيسية ",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            MenuItem(
              text: "المشاريع",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectsScreen()),
                );
              },
            ),
            MenuItem(
              text: "المنتدي",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumScreen()),
                );
              },
            ),
            MenuItem(
              text: "الأحداث",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumScreen()),
                );
              },
            ),
            MenuItem(
              text: "الاشعارات",
              onTap: () {},
            ),
            MenuItem(
              text: "الحساب",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final String text;
  final Function onTap;

  MenuItem({required this.text, required this.onTap});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isHovering = false;
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isClicked = !_isClicked;
          });
          widget.onTap();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 20),
          color: _isClicked
              ? const Color.fromARGB(255, 5, 50, 87)
              : (_isHovering
                  ? Color.fromARGB(255, 8, 55, 94).withOpacity(0.1)
                  : Colors.transparent),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: _isHovering || _isClicked ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
