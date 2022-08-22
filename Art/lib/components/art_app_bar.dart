import 'package:art/bloc/main/view.dart';
import 'package:art/config/responsive.dart';
import 'package:art/screens/main/main_screen.dart';
import 'package:art/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/login/login_screen.dart';

class ArtAppBar extends StatelessWidget {
  final double scrollOffset;
  int? screenIndex;
  ValueChanged? pageChange;

  ArtAppBar({Key? key, this.scrollOffset = 0.0, this.screenIndex,this.pageChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Responsive(
        mobile: const _ArtAppBarMobile(),
        desktop: _ArtAppBarDesktop(screenIndex: screenIndex, pageChange: pageChange!),
      ),
    );
  }
}

class _ArtAppBarMobile extends StatelessWidget {
  const _ArtAppBarMobile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container();
    // SafeArea(
    // child: Row(
    //   children: [
    //     Image.asset(Assets.netflixLogo0),
    //     const SizedBox(
    //       width: 12,
    //     ),
    //     Expanded(
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           _AppBarButton(
    //             title: 'TV Shows',
    //             onTap: () => log('TV Shows'),
    //           ),
    //           _AppBarButton(
    //             title: 'Movies',
    //             onTap: () => log('Movies'),
    //           ),
    //           _AppBarButton(
    //             title: 'My List',
    //             onTap: () => log('My List'),
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // ),
    // );
  }
}

class _ArtAppBarDesktop extends StatefulWidget {
  _ArtAppBarDesktop({Key? key, this.screenIndex,this.pageChange})
      : super(key: key);
  int? screenIndex;

  ValueChanged? pageChange;

  @override
  _ArtAppBarDesktopState createState() => _ArtAppBarDesktopState();
}

class _ArtAppBarDesktopState extends State<_ArtAppBarDesktop> {


  User? fireUser;
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      // await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          fireUser = user;
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

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  TextEditingController textController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          // Image.asset(Assets.netflixLogo1),
          InkWell(
            child: Text(
              'Art Store',
              style: TextStyle(
                color: Colors.blueGrey[100],
                fontSize: 80,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                letterSpacing: 3,
              ),
            ),
          ),
          // Text(
          //   'Art Store',
          //   style: TextStyle(
          //     color: Colors.blueGrey[100],
          //     fontSize: 80,
          //     fontFamily: 'Montserrat',
          //     fontWeight: FontWeight.w400,
          //     letterSpacing: 3,
          //   ),
          // ),
          const SizedBox(
            width: 12,
          ),
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       _AppBarButton(
          //         title: 'Home',
          //         onTap: () => log('My List'),
          //       ),
          //       _AppBarButton(
          //         title: 'TV Shows',
          //         onTap: () => log('TV Shows'),
          //       ),
          //       _AppBarButton(
          //         title: 'Movies',
          //         onTap: () => log('Movies'),
          //       ),
          //       _AppBarButton(
          //         title: 'Latest',
          //         onTap: () => log('My List'),
          //       ),
          //       _AppBarButton(
          //         title: 'My List',
          //         onTap: () => log('My List'),
          //       ),
          //     ],
          //   ),
          // ),
          const Spacer(flex: 4),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // AnimSearchBar(
                //   width: 40,
                //   textController: textController,
                //   onSuffixTap: () {
                //     setState(() {
                //       textController.clear();
                //     });
                //   },
                // ),

                // InkWell(
                //   child: IconButton(
                //     padding: EdgeInsets.zero,
                //     icon: const Icon(Icons.search),
                //     color: Colors.white,
                //     iconSize: 28,
                //     // onPressed: () => log('Search'),
                //     onPressed: (){
                //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                //         return const SearchScreen();
                //         // return const LoginPage();
                //       },));
                //     },
                //   ),
                // ),

                // _AppBarButton(
                //   title: 'Home',
                //   onTap: () => log('Home'),
                // ),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[0] = true : _isHovering[0] = false;
                    });
                  },
                  // onTap: () {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) {
                  //       return const MainScreen();
                  //     },
                  //   ));
                  // },
                  onTap: () => {
                    if(widget.screenIndex == null){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const MainPage();
                        },
                      )),
                    }else if (widget.screenIndex != null && widget.screenIndex != 0){
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return const MainScreen();
                        //   },
                        // )),
                      print("------------------------------"),
                      widget.pageChange!(0)
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                          color: _isHovering[0] || (widget.screenIndex == 0)
                              ? Colors.blue[200]
                              : Colors.blueGrey[100],
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[0],
                        child: Container(
                          height: 2,
                          width: 20,
                          color: Colors.blueGrey[100],
                        ),
                      )
                    ],
                  ),
                ),

                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[1] = true : _isHovering[1] = false;
                    });
                  },
                  onTap: () {
                    if(widget.screenIndex == null){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const SearchScreen();
                        },
                      ));
                    }else if (widget.screenIndex != null && widget.screenIndex != 1){
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) {
                      //     return const SearchScreen();
                      //   },
                      // ));
                      widget.pageChange!(1);
                  }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Search',
                        style: TextStyle(
                          color: _isHovering[1] || (widget.screenIndex == 1)
                              ? Colors.blue[200]
                              : Colors.blueGrey[100],
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: _isHovering[1],
                        child: Container(
                          height: 2,
                          width: 20,
                          color: Colors.blueGrey[100],
                        ),
                      )
                    ],
                  ),
                ),

                // cubit.state.loginStatus
                fireUser != null
                    ? InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[2] = true
                                : _isHovering[2] = false;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: const Icon(Icons.menu),
                              color: _isHovering[2] || (widget.screenIndex == 2)
                                  ? Colors.blue[200]
                                  : Colors.blueGrey[100],
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[2],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.blueGrey[100],
                              ),
                            )
                          ],
                        ),
                      )
                    : InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[2] = true
                                : _isHovering[2] = false;
                          });
                        },
                        onTap: () {
                          if (widget.screenIndex != null && widget.screenIndex != 2){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ));
                            // widget.pageChange(2);
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color:
                                    _isHovering[2] || (widget.screenIndex == 2)
                                        ? Colors.blue[200]
                                        : Colors.blueGrey[100],
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[2],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.blueGrey[100],
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  const _AppBarButton({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
