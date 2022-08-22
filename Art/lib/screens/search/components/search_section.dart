import 'package:art/model/search_model.dart';
import 'package:art/screens/search/components/search_art_card.dart';
import 'package:art/screens/search/components/section_title.dart';
import 'package:flutter/material.dart';

import '../../../config/responsive.dart';
import '../../../data/constants.dart';
import '../../../dio/dio_client.dart';
import '../../../model/painting.dart';
import '../../personal_center/project.dart';

class SearchSection extends StatelessWidget {
  TextEditingController searchBarController;
  int pageIndex;
  String search;
  int sortId;
  SearchSection({
    Key? key,
    required this.pageIndex,
    required this.searchBarController,
    required this.search,
    required this.sortId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding * 2),
        Container(
          alignment: Alignment.center,
          child: const Text(
            "Search Art",
            style: TextStyle(
              fontSize: 40,
              letterSpacing: 2,
              wordSpacing: 10,
            ),
          ),
        ),
        // const SizedBox(height: defaultPadding),
        Responsive(
          mobile: SearchArtGridView(
            crossAxisCount: 1,
            childAspectRatio: 0.5,
            pageIndex: pageIndex,
            searchBarController: searchBarController,
            search: search,
            sortId: sortId,
          ),
          mobileLarge:
              SearchArtGridView(crossAxisCount: 2, childAspectRatio: 0.3, pageIndex: pageIndex, searchBarController: searchBarController,search: search,sortId: sortId,),
          tablet: SearchArtGridView(childAspectRatio: 0.4, pageIndex: pageIndex, searchBarController: searchBarController,search: search,sortId: sortId,),
          desktop: SearchArtGridView(childAspectRatio: 0.6,pageIndex: pageIndex, searchBarController: searchBarController,search: search,sortId: sortId,),
        )
      ],
    );
  }
}

class SearchArtGridView extends StatefulWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  int pageIndex;
  TextEditingController searchBarController;
  String search;
  int sortId;

  SearchArtGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
    required this.pageIndex,
    required this.searchBarController,
    required this.search,
    required this.sortId,
  }) : super(key: key);

  @override
  _SearchArtGridViewState createState() => _SearchArtGridViewState();
}

class _SearchArtGridViewState extends State<SearchArtGridView> {
  List<Painting> searchArts = [];
  DioClient dioClient = DioClient();

  @override
  void initState() {
    super.initState();
  }

  void getSearchArts() async {
    setState(() async {
      searchArts = await dioClient.getPopularArts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.search == "" ? dioClient.getAllPaintingsAndSort(widget.pageIndex,widget.sortId) : dioClient.getSearchPaintingsAndSort(widget.search, widget.pageIndex,widget.sortId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List? _list = [];
            _list = snapshot.data as List?;
            return GridView.builder(
              padding: const EdgeInsets.all(50.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _list?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                childAspectRatio: widget.childAspectRatio,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
              ),
              itemBuilder: (context, index) => SearchArtCard(
                project: _list![index],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
