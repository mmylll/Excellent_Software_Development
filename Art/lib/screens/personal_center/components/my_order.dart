import 'package:art/screens/personal_center/components/order_card.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatelessWidget {
  List? listArtOrder;
  MyOrder({
    Key? key,
    this.listArtOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF559BEC),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return OrderCard(artOrder: listArtOrder![index],);
          },
          itemCount: listArtOrder?.length,
        ),
      ),

    );
    // return MediaQuery.removePadding(
    //   context: context,
    //   removeTop: true,
    //   removeBottom: true,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     primary: false,
    //     itemBuilder: (context, position) {
    //       return const OrderCard();
    //     },
    //     itemCount: 5,
    //   ),
    // );
    //
    // return ListView.builder(
    //   shrinkWrap: true,
    //   primary: false,
    //   itemBuilder: (context, position) {
    //     return const OrderCard();
    //   },
    //   itemCount: 5,
    // );
  }
}