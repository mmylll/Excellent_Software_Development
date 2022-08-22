import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/art_app_bar.dart';
import 'components/CartBottomBar.dart';
import 'components/cart_body.dart';
import 'model/food_item.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    List<FoodItem> foodItems = foodItemList;
    // return StreamBuilder(
    //   builder: (context, snapshot) {
          return Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: Size(screenSize.width, 100.0),
            //   child: ArtAppBar(),
            // ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CartBody(foodItems),
            ),
            bottomNavigationBar: CartBottomBar(foodItems),
          );
    //   },
    // );
  }
}

