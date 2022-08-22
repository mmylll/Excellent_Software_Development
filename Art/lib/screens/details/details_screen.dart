import 'dart:developer';

import 'package:art/screens/details/components/details_section.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../cart/cart.dart';
import '../../components/art_app_bar.dart';
import '../../components/art_bottom_bar.dart';
import '../cart/model/food_item.dart';
import 'components/details_art.dart';
import 'package:art/data/theme.dart' as theme;

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.add_shopping_cart),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return Cart();
          },
        )),
      ),
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 100.0),
      //   child: const ArtAppBar(),
      // ),
      body: Container(
      decoration: const BoxDecoration(
      gradient: theme.Theme.mainGradient,
    ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kDefaultPadding * 2),
              // const DetailsSection(),
              // CourseInfoScreen(),
              const SizedBox(height: kDefaultPadding * 1),
              ArtBottomBar(),
            ],
          ),
        ),
      ),

    );
  }
}

GestureDetector buildGestureDetector(int length, BuildContext context, List<FoodItem> foodItems) {
  return GestureDetector(
    onTap: () {
      if (length > 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Cart()));
      } else {
        return;
      }
    },
    child: Container(
      margin: EdgeInsets.only(right: 30),
      child: Text(length.toString()),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
    ),
  );
}
