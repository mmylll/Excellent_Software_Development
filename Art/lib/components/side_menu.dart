import 'dart:html';

import 'package:art/bloc/main/view.dart';
import 'package:art/components/art_app_bar.dart';
import 'package:art/dio/dio_client.dart';
import 'package:art/model/art_user.dart';
import 'package:art/screens/cart/cart_page.dart';
import 'package:art/screens/chat/rooms.dart';
import 'package:art/screens/personal_center/skills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/constants.dart';
import '../screens/chat/users.dart';
import '../screens/personal_center/area_info_text.dart';
import '../screens/personal_center/coding.dart';
import '../screens/personal_center/components/send_money.dart';
import '../screens/personal_center/knowledges.dart';
import '../screens/personal_center/my_info.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:file_selector/file_selector.dart';
import 'package:file_selector/file_selector.dart';

import '../screens/personal_center/personal_center_screen.dart';
import '../screens/personal_center/upload/upload.dart';

class SideMenu extends StatefulWidget {

  SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int _selectedDestination = -1;

  DioClient dioClient = DioClient();
  User? _user;
  ArtUser? artUser;
  bool _initialized = false;
  bool _error = false;
  String? photoUrl;

  @override
  initState() {
    initializeFlutterFire();
    super.initState();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void initializeFlutterFire() {
    try {
      // await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user!;
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



  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Color.alphaBlend(Colors.cyanAccent, Colors.blue),
        child:  SafeArea(
          child: Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [

                      FutureBuilder(
                        future:  dioClient.getArtUserByEmail(_user!.email),
                        builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              artUser = snapshot.data as ArtUser?;
                              print(snapshot.data);
                              return Column(
                                children: [
                                  MyInfo(photoUrl: artUser?.photoUrl,),

                                  AreaInfoText(
                                    title: "username",
                                    text: artUser == null ? "null" : artUser?.username,
                                  ),
                                  AreaInfoText(
                                    title: "email",
                                    text: _user?.email,
                                  ),
                                  AreaInfoText(
                                    title: "Phone",
                                    text: artUser == null ? "null" : artUser?.phone,
                                  ),
                                  AreaInfoText(
                                    title: "address",
                                    text: artUser == null ? "null" : artUser?.address,
                                  ),
                                ],
                              );
                            }else{
                              return Container();
                            }
                        }),


                      // AreaInfoText(
                      //   title: "username",
                      //   text: artUser == null ? "null" : artUser?.username,
                      // ),
                      // AreaInfoText(
                      //   title: "email",
                      //   text: _user?.email,
                      // ),
                      // AreaInfoText(
                      //   title: "Phone",
                      //   text: artUser == null ? "null" : artUser?.phone,
                      // ),
                      // AreaInfoText(
                      //   title: "address",
                      //   text: artUser == null ? "null" : artUser?.address,
                      // ),

                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.account_balance_wallet),
                          title: const Text('Recharge'),
                          selected: _selectedDestination == 0,
                          onTap: () {
                            selectDestination(0);
                            FocusScope.of(context).requestFocus(FocusNode());
                            showDialog<void>(context: context, builder: (context) => SendMoneyPage(artUser: artUser));
                          }
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.chat),
                          title: const Text('Chat'),
                          selected: _selectedDestination == 1,
                          onTap: (){
                            selectDestination(1);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) {
                            //     return RoomsPage();
                            //   },
                            // ));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => UsersPage(),
                              ),
                            );
                          }
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.add_shopping_cart_rounded),
                          title: const Text('Cart'),
                          selected: _selectedDestination == 2,
                          onTap: (){
                            selectDestination(2);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return CartPage(userEmail: _user?.email,);
                              },
                            ));
                          }
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.upload),
                          title: const Text('Upload'),
                          selected: _selectedDestination == 3,
                          onTap: () async {
                            selectDestination(3);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return UploadPage(email: artUser?.email,);
                              },
                            ));
                          }
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.person),
                          title: const Text('Personal Center'),
                          selected: _selectedDestination == 4,
                          onTap: (){
                            selectDestination(4);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const PersonalCenterScreen();
                              },
                            ));
                          }
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.logout),
                          title: const Text('Sign out'),
                          selected: _selectedDestination == 5,
                          onTap: (){
                            selectDestination(5);
                            logout();
                            EasyLoading.showSuccess('logout Success!');
                            // Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const MainPage();
                              },
                            ));
                          }
                      ),

                      // const Skills(),
                      // const SizedBox(height: defaultPadding),
                      // const Coding(),
                      // const Knowledges(),
                      // const Divider(),
                      // const SizedBox(height: defaultPadding / 2),

                      // TextButton(
                      //   onPressed: () {},
                      //   child: FittedBox(
                      //     child: Row(
                      //       children: [
                      //         Text(
                      //           "DOWNLOAD CV",
                      //           style: TextStyle(
                      //             color: Theme.of(context)
                      //                 .textTheme
                      //                 .bodyText1!
                      //                 .color,
                      //           ),
                      //         ),
                      //         const SizedBox(width: defaultPadding / 2),
                      //         SvgPicture.asset("assets/icons/download.svg")
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //
                      // Container(
                      //   margin: const EdgeInsets.only(top: defaultPadding),
                      //   color: const Color(0xFF24242E),
                      //   child: Row(
                      //     children: [
                      //       const Spacer(),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: SvgPicture.asset("assets/icons/linkedin.svg"),
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: SvgPicture.asset("assets/icons/github.svg"),
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: SvgPicture.asset("assets/icons/twitter.svg"),
                      //       ),
                      //       const Spacer(),
                      //     ],
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}