import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparrow/screens/chat_screen/ChatScreen.dart';
import 'package:sparrow/screens/questions/addProperty.dart';
import 'package:sparrow/screens/home_screen/home_screen.dart';
import 'package:sparrow/screens/profile/profile_screen.dart';
import 'package:sparrow/screens/searchScreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final int _selectedIndex = 0;
  var _page = 0;

  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final Screen = [
    HomeScreen(),
    SearchScreen(),
    addProperty(),
    ChatPage(),
    ProfileScreen(),
  ];

  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      _page = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[_page],
      extendBody: false,
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
         onTap: _handleIndexChanged,
        backgroundColor: Theme.of(context).primaryColor,
        enableFloatingNavBar: true,
        marginR: const EdgeInsets.all(15),
        items: [
          /// Home
          DotNavigationBarItem(
            
            icon: const Icon(CupertinoIcons.app_badge_fill),
            selectedColor: Color.fromARGB(255, 139, 100, 148),
          ),

          /// Likes
          DotNavigationBarItem(
            icon: const Icon(CupertinoIcons.search),
            selectedColor: Colors.pink,
          ),

          /// Likes
          DotNavigationBarItem(
            icon: const Icon(CupertinoIcons.square_arrow_up_fill),
            selectedColor: Colors.pink,
          ),

          /// Search
          DotNavigationBarItem(
            icon: const Icon(CupertinoIcons.bubble_left_bubble_right_fill),
            selectedColor: Colors.orange,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

enum _SelectedTab { home, search, add, chat, person }
