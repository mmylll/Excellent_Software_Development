import 'package:art/dio/dio_client.dart';
import 'package:art/screens/main/components/popular_art_card.dart';
import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../../model/painting.dart';
import '../../personal_center/project.dart';
import '../../../config/responsive.dart';

class PopularArt extends StatelessWidget {
  const PopularArt({
    Key? key,
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
            "Popular Art",
            style: TextStyle(
              fontSize: 40,
              letterSpacing: 2,
              wordSpacing: 10,
            ),
          ),
        ),
        // const SizedBox(height: defaultPadding),
        const Responsive(
          mobile: PopularArtGridView(
            crossAxisCount: 1,
            childAspectRatio: 0.9,
          ),
          mobileLarge:
              PopularArtGridView(crossAxisCount: 2, childAspectRatio: 0.3),
          tablet: PopularArtGridView(childAspectRatio: 0.4),
          desktop: PopularArtGridView(childAspectRatio: 0.6),
        )
      ],
    );
  }
}

class PopularArtGridView extends StatefulWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const PopularArtGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
  }) : super(key: key);

  @override
  _PopularArtGridViewState createState() => _PopularArtGridViewState();
}

class _PopularArtGridViewState extends State<PopularArtGridView> {
  List<Painting> popularArts = [];
  DioClient dioClient = DioClient();

  @override
  void initState() {
    super.initState();
  }

  void getPopularArts() async{
    setState(() async {
      popularArts = await dioClient.getPopularArts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dioClient.getPopularArts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List? _list = [];
            _list = snapshot.data as List?;
            return GridView.builder(
              padding: EdgeInsets.all(50.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // itemCount: demo_projects.length,
              itemCount: _list?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                childAspectRatio: widget.childAspectRatio,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
              ),
              itemBuilder: (context, index) => PopularArtCard(
                project: _list![index],
              ),
            );
          }else{
            return Container();
          }
        }
    );

    return GridView.builder(
      padding: EdgeInsets.all(50.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // itemCount: demo_projects.length,
      itemCount: popularArts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => PopularArtCard(
        project: popularArts[index],
      ),
    );
  }
}
