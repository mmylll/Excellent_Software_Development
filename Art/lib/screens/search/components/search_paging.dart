import 'package:art/screens/search/components/search_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageview_widget_indicator/pageview_widget_indicator.dart';

class SearchPaging extends StatefulWidget {
  SearchPaging({Key? key}) : super(key: key);


  @override
  _SearchPagingState createState() => _SearchPagingState();
}

class _SearchPagingState extends State<SearchPaging> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 1,
      keepPage: true,
    );
  }

  Widget _myWidget(index, isSelected) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Material(
      color: Colors.white.withOpacity(isSelected ? 0.25 : 0.0),
      borderRadius: BorderRadius.circular(12.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          controller.jumpToPage(index);
        },
        child: Center(
          child: Text(
            '${index + 1}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: PageViewIndicator(
            pageController: controller,
            itemWidth: 50.0,
            itemCount: 10,
            builder: (context, index, isSelected) =>
                _myWidget(index, isSelected),
          ),
        ),
      ),
      body: PageView.builder(
        controller: controller,
        itemCount: 10,
        itemBuilder: (context, index) =>
        //     Container(
        //   color: Colors.red[(index + 1) % 10 * 100],
        //   child: Center(
        //     child: Text(
        //       'shade ' + ((index + 1) % 10 * 100).toString(),
        //       style:
        //       CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        //     ),
        //   ),
        // ),
        Container(),
        // SearchSection(),
      ),
    );
  }
}