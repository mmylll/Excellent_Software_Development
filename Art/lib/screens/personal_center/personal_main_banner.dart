import 'package:art/screens/personal_center/pay_activity_screen.dart';
import 'package:art/screens/personal_center/pay_custom_box.dart';
import 'package:art/screens/personal_center/send_money_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../data/constants.dart';
import '../../config/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalMainBanner extends StatelessWidget {
  String? username;
  double? balance;
  PersonalMainBanner({
    Key? key,
    this.username,
    this.balance
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: Responsive.isMobile(context) ? 1.5 : 3.2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   "assets/images/bg.jpeg",
          //   fit: BoxFit.cover,
          // ),
          // Container(color: darkColor.withOpacity(0.66)),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         "Discover my Amazing \nArt Space!",
          //         style: Responsive.isDesktop(context)
          //             ? Theme.of(context).textTheme.headline3!.copyWith(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         )
          //             : Theme.of(context).textTheme.headline5!.copyWith(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //       if (Responsive.isMobileLarge(context))
          //         const SizedBox(height: defaultPadding / 2),
          //       const MyBuildAnimatedText(),
          //       const SizedBox(height: defaultPadding),
          //       if (!Responsive.isMobileLarge(context))
          //         ElevatedButton(
          //           onPressed: () {},
          //           style: TextButton.styleFrom(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: defaultPadding * 2,
          //                 vertical: defaultPadding),
          //             backgroundColor: primaryColor,
          //           ),
          //           child: const Text(
          //             "EXPLORE NOW",
          //             style: TextStyle(color: darkColor),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),

          Container(
            width: size.width/2,
            height: size.height * 0.1,
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
            padding: EdgeInsets.only(top: (Responsive.isDesktop(context) ? 72 : 0), left: 32, right: 32),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    // 'Hello, Vadim!',
                    '$username',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: colorWhite.withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: (Responsive.isDesktop(context) ? 30 : 10)),
                  child: Text(
                    '\$ $balance',
                    style: GoogleFonts.manrope(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: colorWhite,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
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
    );
  }
}

class MyBuildAnimatedText extends StatelessWidget {
  const MyBuildAnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      // it applies same style to all the widgets under it
      style: Theme.of(context).textTheme.subtitle1!,
      maxLines: 1,
      child: Row(
        children: [
          if (!Responsive.isMobileLarge(context)) const FlutterCodedText(),
          if (!Responsive.isMobileLarge(context))
            const SizedBox(width: defaultPadding / 2),
          const Text("I build "),
          Responsive.isMobile(context)
              ? const Expanded(child: AnimatedText())
              : const AnimatedText(),
          if (!Responsive.isMobileLarge(context))
            const SizedBox(width: defaultPadding / 2),
          if (!Responsive.isMobileLarge(context)) const FlutterCodedText(),
        ],
      ),
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          "responsive web and mobile app.",
          speed: const Duration(milliseconds: 60),
        ),
        TyperAnimatedText(
          "complete e-Commerce app UI.",
          speed: const Duration(milliseconds: 60),
        ),
        TyperAnimatedText(
          "Chat app with dark and light theme.",
          speed: const Duration(milliseconds: 60),
        ),
      ],
    );
  }
}

class FlutterCodedText extends StatelessWidget {
  const FlutterCodedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        text: "<",
        children: [
          TextSpan(
            text: "flutter",
            style: TextStyle(color: primaryColor),
          ),
          TextSpan(text: ">"),
        ],
      ),
    );
  }
}