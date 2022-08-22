import 'package:flutter/cupertino.dart';

import '../model/food_item.dart';

class CartBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: const Text(
              "My Order",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
            ),
          ),
        ),
        DragTargetWidget(),
      ],
    );
  }
}

class DragTargetWidget extends StatefulWidget {


  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  @override
  Widget build(BuildContext context) {
    FoodItem currentFoodItem;

    return DragTarget<FoodItem>(
      onAccept: (FoodItem foodItem) {
        currentFoodItem = foodItem;
        // widget.bloc.removeFromList(currentFoodItem);
      },

      builder: (BuildContext context, List incoming, List rejected) {
        return const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.delete,
            size: 35,
          ),
        );
      },
    );
  }
}