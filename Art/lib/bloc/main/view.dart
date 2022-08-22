import 'package:art/components/side_menu.dart';
import 'package:art/screens/cart/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../components/art_app_bar.dart';
import '../../config/responsive.dart';
import '../../screens/cart/cart_page.dart';
import '../../screens/chat/rooms.dart';
import '../../screens/chat/users.dart';
import '../../screens/details/components/details_art.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/main/main_screen.dart';
import '../../screens/personal_center/personal_center_screen.dart';
import '../../screens/search/search_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _error = false;
  bool _initialized = false;
  User? user;
  int _currentPageIndex = 0;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  final List<Widget> _screens = [
    const MainScreen(
      key: PageStorageKey('homeScreen'),
    ),
    const SearchScreen(
      key: PageStorageKey('searchScreen'),
    ),
    // const LoginScreen(
    //   key: PageStorageKey('login'),
    // ),
    UsersPage(
      key: const PageStorageKey('chat'),
    ),
    // const PersonalCenterScreen(
    //   key: PageStorageKey('person'),
    // ),
    // CourseInfoScreen(
    //   key: const PageStorageKey('details'),
    // ),
    // CartPage(
    //   key: const PageStorageKey('cart'),
    // ),
    // CheckOutPage(
    //   key: PageStorageKey('checkout'),
    // ),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    // 'Login': Icons.login,
    'Chat': Icons.chat,
    // 'Person': Icons.menu,
  };

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (BuildContext context) => MainCubit(),
    //   child: Builder(builder: (context) => _buildPage(context)),
    // );
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.grey[850],
        //   child: const Icon(Icons.cast),
        //   onPressed: () => log('Cast'),
        // ),

        // body: BlocProvider<AppBarCubit>(
        //   create: (context) => AppBarCubit(),
        //   child: _screens[_currentIndex],
        // ),

        appBar: _currentPageIndex != 2
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                // child: BlocBuilder<AppBarCubit, double>(
                //   builder: (context, scrollOffset) {
                //     return ArtAppBar(
                //       scrollOffset: scrollOffset,
                //     );
                //   },
                // ),
                child: ArtAppBar(screenIndex: _currentPageIndex, pageChange: (value) {
                  setState(() {
                    _currentPageIndex = value;
                  });
                },),
              )
            : null,
        endDrawer: SideMenu(),
        body: _screens[_currentPageIndex],
        // body: _screens[0],
        // body: BlocBuilder<MainCubit, MainState>(
        //   builder: (context, state) {
        //     return  _screens[cubit.state.currentIndex];
        //   },
        // ),

        bottomNavigationBar: !Responsive.isDesktop(context)
            ? BottomNavigationBar(
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
                currentIndex: _currentPageIndex,
                selectedItemColor: Colors.white,
                selectedFontSize: 11,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 11,
                onTap: (index) => {
                  setState(() {
                    _currentPageIndex = index;
                  })
                },
              )
            : null);
  }
}
