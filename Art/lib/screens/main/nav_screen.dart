import 'dart:developer';

import 'package:art/config/responsive.dart';
import 'package:art/screens/personal_center/personal_center_screen.dart';
import 'package:art/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat/rooms.dart';
import '../login/login_screen.dart';
import '../../components/art_app_bar.dart';
import 'main_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const MainScreen(
      key: PageStorageKey('homeScreen'),
    ),
    const SearchScreen(
      key: PageStorageKey('searchScreen'),
    ),
    const LoginScreen(
      key: PageStorageKey('login'),
    ),
    // const RoomsPage(
    //   key: PageStorageKey('chat'),,
    // ),
    const PersonalCenterScreen(
      key: PageStorageKey('person'),
    ),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Login': Icons.login,
    'Chat': Icons.chat,
    'Person': Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

        // extendBodyBehindAppBar: true,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.grey[850],
        //   child: const Icon(Icons.cast),
        //   onPressed: () => log('Cast'),
        // ),
        // appBar: PreferredSize(
        //   preferredSize: Size(screenSize.width, 100.0),
        //   child: ArtAppBar(screenIndex: _currentIndex),
        // ),

        // body: BlocProvider<AppBarCubit>(
        //   create: (context) => AppBarCubit(),
        //   child: _screens[_currentIndex],
        // ),

        body: _screens[_currentIndex],
        bottomNavigationBar: !Responsive.isDesktop(context) ?
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: _icons
              .map((title, icon) => MapEntry(
              title,
              BottomNavigationBarItem(
                icon: Icon(
                  icon,
                  size: 30,
                ),
                label: title,
              )))
              .values
              .toList(),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          selectedFontSize: 11,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 11,
          onTap: (index) => setState(() => _currentIndex = index),
        ):null
    );
  }
}