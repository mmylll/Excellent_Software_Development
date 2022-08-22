import 'package:art/screens/personal_center/pay_activity_screen.dart';
import 'package:art/screens/personal_center/pay_custom_box.dart';
import 'package:art/screens/personal_center/send_money_screen.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../../config/responsive.dart';
import 'animated_counter.dart';
import 'highlight.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HighLightInfo extends StatelessWidget {
  const HighLightInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Responsive.isMobileLarge(context)
          ? Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              HighLight(
                counter: AnimatedCounter(
                  value: 119,
                  text: "K+",
                ),
                label: "Subscribers",
              ),
              HighLight(
                counter: AnimatedCounter(
                  value: 40,
                  text: "+",
                ),
                label: "Videos",
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              HighLight(
                counter: AnimatedCounter(
                  value: 30,
                  text: "+",
                ),
                label: "GitHub Projects",
              ),
              HighLight(
                counter: AnimatedCounter(
                  value: 13,
                  text: "K+",
                ),
                label: "Stars",
              ),
            ],
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:   [
          // HighLight(
          //   counter: AnimatedCounter(
          //     value: 119,
          //     text: "K+",
          //   ),
          //   label: "Subscribers",
          // ),
          // HighLight(
          //   counter: AnimatedCounter(
          //     value: 40,
          //     text: "+",
          //   ),
          //   label: "Videos",
          // ),
          // HighLight(
          //   counter: AnimatedCounter(
          //     value: 30,
          //     text: "+",
          //   ),
          //   label: "GitHub Projects",
          // ),
          // HighLight(
          //   counter: AnimatedCounter(
          //     value: 13,
          //     text: "K+",
          //   ),
          //   label: "Stars",
          // ),
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
        ],
      ),
    );
  }
}