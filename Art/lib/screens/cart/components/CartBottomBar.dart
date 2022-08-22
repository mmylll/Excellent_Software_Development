import 'package:flutter/material.dart';
import '../model/food_item.dart';

class CartBottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          nextButtonBar(),
        ],
      ),
    );
  }


  Container totalAmount(List<FoodItem> foodItems) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            "Total:",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          Text(
            "\$${returnTotalAmount(foodItems)}",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<FoodItem> foodItems) {
    double totalAmount = 0.0;

    for (int i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }

  Container nextButtonBar() {
    return Container(
      margin: const EdgeInsets.only(right: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: const Color(0xfffeb324), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: const <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Text(
            "Next",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}