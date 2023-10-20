import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie/screens/home_screen.dart';
import 'package:movie/screens/recommed_screen.dart';
import 'package:movie/screens/search_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    RecommendationScreen()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // print('${_selectedIndex}');

    //   switch (index) {
    //     case 0:
    //       Navigator.of(context).pushNamed('/home'); // Navigate to HomeScreen
    //       break;
    //     case 1:
    //       Navigator.of(context).pushNamed('/search'); // Navigate to SearchScreen
    //       break;
    //     default:
    //       // Handle other cases if needed
    //       break;
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 80,
        child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            // gap: 4,
            padding: EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Favorites',
              ),
              GButton(
                icon: Icons.recommend_rounded,
                text: 'Recommendation',
              ),
              // GButton(
              //   icon: Icons.person,
              //   text: 'Profile',
              // ),
            ]),
      ),
    );
  }
}