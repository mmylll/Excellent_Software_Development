import 'package:art/screens/home/components/home_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/constants.dart';
import '../../components/art_app_bar.dart';
import '../../components/art_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 100.0),
      //   child: const ArtAppBar(screenIndex: 0),
      //   // child: BlocBuilder<AppBarCubit, double>(
      //   //   builder: (context, scrollOffset) {
      //   //     return ArtAppBar(
      //   //       screenIndex: 0,
      //   //       scrollOffset: scrollOffset,
      //   //     );
      //   //   },
      //   // ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: kDefaultPadding * 2),
            const HomeCarousel(),
            const SizedBox(height: kDefaultPadding * 1),
            ArtBottomBar(),
          ],
        ),
      ),
    );
  }
}