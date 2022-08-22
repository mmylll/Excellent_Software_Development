import 'package:art/data/assets.dart';
import 'package:art/model/art_order.dart';
import 'package:flutter/material.dart';

import '../../cart/custom_text_style.dart';
import '../../cart/custom_utils.dart';
import '../../details/components/details_art.dart';

class OrderCard extends StatefulWidget {
  ArtOrder? artOrder;
  OrderCard({
    Key? key,
    this.index,
    this.artOrder,
  }) : super(key: key);

  final int ? index;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CourseInfoScreen(
            painting: widget.artOrder?.painting,
          );
        }));
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      color: Colors.blue.shade200,
                      image: DecorationImage(image: NetworkImage(Assets.oss_painting_square + '${widget.artOrder?.painting.imageFileName}' + '.jpg'))),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8, top: 4),
                              child: Text(
                                // "Order Number",
                                '${widget.artOrder?.orderId}',
                                maxLines: 2,
                                softWrap: true,
                                style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                              ),
                            ),

                            Container(
                              // height:50,
                              padding: EdgeInsets.only(right: 8, top: 4),
                              child: Text(
                                // "NIKE XTM Basketball Shoeas",
                                '${widget.artOrder?.painting.title}',
                                maxLines: 2,
                                softWrap: true,
                                style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Utils.getSizedBox(height: 6),
                            // Text(
                            //   "Green M",
                            //   style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.grey, fontSize: 14),
                            // ),
                            Text(
                              // "\$299.00",
                              '\$${widget.artOrder?.painting.cost}',
                              style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.green),
                            ),
                            Utils.getSizedBox(height: 6),
                            Container(
                              padding: EdgeInsets.only(right: 8, top: 4),
                              child: Text(
                                // "Order Time",
                                '${widget.artOrder?.orderTime}',
                                maxLines: 2,
                                softWrap: true,
                                style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        // Column(
                        //   mainAxisSize: MainAxisSize.max,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       padding: EdgeInsets.only(right: 8, top: 4),
                        //       child: Text(
                        //         // "Order Number",
                        //         '${widget.artOrder?.orderId}',
                        //         maxLines: 2,
                        //         softWrap: true,
                        //         style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                        //       ),
                        //     ),
                        //     // Utils.getSizedBox(height: 6),
                        //
                        //   ],
                        // ),

                        // Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       Text(
                        //         "\$299.00",
                        //         style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.green),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: <Widget>[
                        //             Icon(
                        //               Icons.remove,
                        //               size: 24,
                        //               color: Colors.grey.shade700,
                        //             ),
                        //             Container(
                        //               color: Colors.grey.shade200,
                        //               padding: const EdgeInsets.only(bottom: 2, right: 12, left: 12),
                        //               child: Text(
                        //                 "1",
                        //                 style: CustomTextStyle.textFormFieldSemiBold,
                        //               ),
                        //             ),
                        //             Icon(
                        //               Icons.add,
                        //               size: 24,
                        //               color: Colors.grey.shade700,
                        //             )
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  flex: 100,
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10, top: 8),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.green),
            ),
          )
        ],
      ),
    );
  }

}