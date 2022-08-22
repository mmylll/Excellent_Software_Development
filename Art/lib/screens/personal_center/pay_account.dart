import 'package:art/screens/personal_center/pay_activity_screen.dart';
import 'package:art/screens/personal_center/pay_custom_box.dart';
import 'package:art/screens/personal_center/send_money_screen.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PayAccount extends StatefulWidget {
  @override
  _PayAccountState createState() => _PayAccountState();
}

class _PayAccountState extends State<PayAccount> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size / 5 ;

    return Expanded(
      child: ListView(

        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colorPrimaryDark.withOpacity(0.5),
                  blurRadius: 40,
                  spreadRadius: -20,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        colorPrimaryGradient,
                        colorPrimaryDark,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: -50,
                  width: 400,
                  height: 420,
                  child: Opacity(
                    opacity: 0.75,
                    child:
                    SvgPicture.asset('assets/images/paypal_backlogo.svg'),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 320,
                  padding: EdgeInsets.only(top: 72, left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('assets/images/paypal_minilogo.svg'),
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: colorPrimaryGradient,
                                width: 2,
                              ),
                              image: const DecorationImage(
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.topCenter,
                                image: AssetImage('assets/images/avatar.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Hello, Vadim!',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorWhite.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          '\$ 272.30',
                          style: GoogleFonts.manrope(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: colorWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Your Balance',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 35, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorPrimaryDark.withOpacity(0.5),
                        blurRadius: 50,
                        spreadRadius: -20,
                        offset: Offset(0, 24),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        colorPrimaryGradient,
                        colorPrimaryDark,
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendMoneyScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/upload.svg'),
                          Text(
                            'Send Money',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorPrimaryDark.withOpacity(0.1),
                        blurRadius: 50,
                        spreadRadius: -20,
                        offset: Offset(2, 8),
                      ),
                    ],
                    color: colorWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: SvgPicture.asset(
                            'assets/icons/upload.svg',
                            color: colorPrimaryShade,
                          ),
                        ),
                        Text(
                          'Send Money',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorPrimaryShade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorPrimaryDark.withOpacity(0.1),
                        blurRadius: 50,
                        spreadRadius: -20,
                        offset: Offset(2, 8),
                      ),
                    ],
                    color: colorWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ellipsis.svg',
                          color: colorPrimaryShade.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 35, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Activity',
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayActivityScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorBlack.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7, left: 35, right: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PayCustomBox(
                  label: 'Mike Rine',
                  text: '2 hours ago',
                  onRightArea: Text(
                    '+\$250',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorGreen,
                    ),
                  ), onLeftArea: Text(''),
                ),
                PayCustomBox(
                  label: 'Google Drive',
                  text: 'Yesterday',
                  onLeftArea: SvgPicture.asset(
                    'assets/icons/google_drive.svg',
                    color: colorBlack,
                  ),
                  onRightArea: Text(
                    '-\$138.5',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorRed,
                    ),
                  ),
                ),
                PayCustomBox(
                  label: 'Casey Smith',
                  text: '1 week ago',
                  onRightArea: Text(
                    '+\$531',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorGreen,
                    ),
                  ), onLeftArea: Text(''),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}