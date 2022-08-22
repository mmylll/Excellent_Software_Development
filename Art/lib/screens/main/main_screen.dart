import 'dart:developer';

import 'package:art/components/art_bottom_bar.dart';
import 'package:art/components/side_menu.dart';
import 'package:art/screens/main/components/main_head.dart';
import 'package:art/screens/main/components/popular_art.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/constants.dart';
import '../../data/data.dart';
import 'package:art/data/theme.dart' as theme;
import '../personal_center/personal_main_banner.dart';
// import 'app_bar_cubit.dart';
import 'widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // late ScrollController _scrollController;

  @override
  void initState() {
    // _scrollController = ScrollController();
    //   ..addListener(() {
    //     BlocProvider.of<AppBarCubit>(context)
    //         .setOffset(_scrollController.offset);
    //   });
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.grey[850],
      //   child: const Icon(Icons.add_shopping_cart),
      //   onPressed: () => log('Cast'),
      // ),
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 100.0),
      //   // child: BlocBuilder<AppBarCubit, double>(
      //   //   builder: (context, scrollOffset) {
      //   //     return ArtAppBar(
      //   //       scrollOffset: scrollOffset,
      //   //     );
      //   //   },
      //   // ),
      //   child: const ArtAppBar(),
      // ),

      // endDrawer: SideMenu(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: theme.Theme.mainGradient,
          // image: DecorationImage(
          //   image: AssetImage("assets/images/login_logo.png"),
          //   // image: AssetImage("assets/images/welcome.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child:  CustomScrollView(
          // controller: _scrollController,
          slivers:  [
            // const SliverToBoxAdapter(
            //   child: MainHead(),
            // ),
            const SliverToBoxAdapter(
                child: MainVideoHeader(
                  featuredContent: artStoreContent,
                )),

            // IconButton(
            //   onPressed: () {
            //     Scaffold.of(context).openDrawer();
            //   },
            //   icon: const Icon(Icons.menu),
            // ),
            const SliverToBoxAdapter(
              child: PopularArt(),
            ),
            SliverToBoxAdapter(
              child: ArtBottomBar(),
            ),

            // const SliverPadding(
            //   padding: EdgeInsets.only(top: 20),
            //   sliver: SliverToBoxAdapter(
            //     child: Previews(
            //         key: PageStorageKey('previews'),
            //         title: 'Previews',
            //         contentList: previews),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: ContentList(
            //     key: const PageStorageKey('my_list'),
            //     title: "My List",
            //     contentList: myList,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: ContentList(
            //     key: const PageStorageKey('originals'),
            //     title: "Netflix Originals",
            //     contentList: originals,
            //     isOriginals: true,
            //   ),
            // ),
            // SliverPadding(
            //   padding: const EdgeInsets.only(bottom: 20),
            //   sliver: SliverToBoxAdapter(
            //     child: ContentList(
            //       key: const PageStorageKey('trending'),
            //       title: 'Trending',
            //       contentList: trending,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),

    );
  }
}