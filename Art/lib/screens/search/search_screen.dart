import 'dart:html';

import 'package:art/components/pager.dart';
import 'package:art/screens/search/components/art_search_bar.dart';
import 'package:art/screens/search/components/search_filter.dart';
import 'package:art/screens/search/components/search_pager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/side_menu.dart';
import '../../data/constants.dart';
import '../../components/art_app_bar.dart';
import '../../components/art_bottom_bar.dart';
import '../../dio/dio_client.dart';
import 'components/search_section.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:pageview_widget_indicator/pageview_widget_indicator.dart';
// import 'package:page_view_indicator/page_view_indicator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchBarController = TextEditingController();
  late PageController pageController;
  int pageIndex = 1;
  DioClient dioClient = DioClient();
  int allPageCount = 1;
  int allItemCount = 0;
  String search = "";
  int sortId = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 1,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey,
      extendBodyBehindAppBar: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.grey[850],
      //   child: const Icon(Icons.cast),
      //   onPressed: () => log('Cast'),
      // ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: theme.Theme.mainGradient,
          // image: DecorationImage(
          //   image: AssetImage("assets/images/login_logo.png"),
          //   // image: AssetImage("assets/images/welcome.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding * 6),
              // ArtSearchBar(
              //   textEditingController: searchBarController,
              //   search: search,
              // ),

          Container(
            width: screenSize.width * 0.8,
            alignment: Alignment.center,
            child: OutlineSearchBar(
              // textEditingController: widget.textEditingController,
              backgroundColor: Colors.white,
              borderColor: Colors.grey,
              textStyle: const TextStyle(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              hintText: "Search...",
              onSearchButtonPressed:(value){
                setState(() {
                  search = value;
                  pageIndex = 1;
                });
              },
              onClearButtonPressed: (value){
                setState(() {
                  pageIndex = 1;
                  search = "";
                });
              },
            ),
          ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    // Navigator.push<dynamic>(
                    //   context,
                    //   MaterialPageRoute<dynamic>(
                    //       builder: (BuildContext context) => FiltersScreen(),
                    //       fullscreenDialog: true),
                    // );
                    showDialog<void>(
                        context: context, builder: (context) => SearchFilter(pageChange: (value) {
                          sortId = value;
                          },));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const <Widget>[
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.sort, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SearchSection(
                pageIndex: pageIndex,
                searchBarController: searchBarController,
                search: search,
                sortId: sortId,
              ),
              // SearchPager(pageController: pageController),
              FutureBuilder(
                  future: search == ""
                      ? dioClient.getAllPaintingsCount()
                      : dioClient.getSearchPaintingsCount(search),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      allItemCount = snapshot.data as int;
                      allPageCount = (allItemCount / 6).ceil();
                      return Pager(
                        total: allPageCount,
                        pageChange: (value) {
                          setState(() {
                            pageIndex = value;
                          },
                          );
                        }, pageIndex: pageIndex,
                      );
                    } else {
                      return Container();
                    }
                  }),
              // Pager(total: 16, pageChange: (value) {
              //   setState(() {
              //     pageIndex = value;
              //   });
              // }, ),

              // SearchPaging(),
              const SizedBox(height: kDefaultPadding * 1),
              ArtBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
