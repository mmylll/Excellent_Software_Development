import 'package:art/components/side_menu.dart';
import 'package:art/screens/personal_center/components/my_order.dart';
import 'package:art/screens/personal_center/pay_account.dart';
import 'package:art/screens/personal_center/personal_main.dart';
import 'package:art/screens/personal_center/personal_main_banner.dart';
import 'package:art/screens/personal_center/recommendations.dart';
import 'package:art/screens/personal_center/send_money_screen.dart';
import 'package:flutter/material.dart';
import 'package:art/data/theme.dart' as theme;
import '../../components/art_app_bar.dart';
import '../../data/constants.dart';
import '../../dio/dio_client.dart';
import '../../model/art_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/order_card.dart';
import 'highlight_info.dart';
import 'my_projects.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalCenterScreen extends StatefulWidget {
  const PersonalCenterScreen({Key? key}) : super(key: key);

  @override
  _PersonalCenterScreenState createState() => _PersonalCenterScreenState();
}

class _PersonalCenterScreenState extends State<PersonalCenterScreen> {
  DioClient dioClient = DioClient();
  User? _user;
  ArtUser? artUser;
  bool _initialized = false;
  bool _error = false;
  List? listArtOrder;

  @override
  initState() {
    initializeFlutterFire();
    super.initState();
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
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: theme.Theme.mainGradient,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 100.0),
          child: Container(
            color: Color(0xff405cb7),
            // decoration: const BoxDecoration(
            //   gradient: theme.Theme.mainGradient,
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'Personal Center',
                  style: GoogleFonts.manrope(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                  ),
                ),
                const SizedBox(
                  width: 35,
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        body: PersonalMain(
          children: [
            FutureBuilder(
                future: dioClient.getArtUserByEmail(_user!.email),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    artUser = snapshot.data as ArtUser?;
                    return PersonalMainBanner(
                      username: artUser?.username,
                      balance: artUser?.balance,
                    );
                  } else {
                    return Container();
                  }
                }),

            // HighLightInfo(),
            // PayAccount(),
            // SendMoneyScreen(),

            // MyProjects(),

            const SizedBox(height: 20),
            FutureBuilder(
                future: dioClient.getAllOrderByUserEmail(_user!.email),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    listArtOrder = snapshot.data as List?;
                    return MyOrder(
                      listArtOrder: listArtOrder,
                    );
                  } else {
                    return Container();
                  }
                }),
            // MyOrder(),
            // Recommendations(),
          ],
        ),
      ),
    );
  }
}
