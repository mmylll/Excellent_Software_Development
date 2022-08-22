import 'package:art/dio/dio_client.dart';
import 'package:art/screens/cart/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/art_app_bar.dart';
import '../../data/assets.dart';
import '../../data/constants.dart';
import '../../model/art_cart.dart';
import '../details/components/details_art.dart';
import 'checkout_page.dart';
import 'custom_text_style.dart';
import 'custom_utils.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartPage extends StatefulWidget {
  String? userEmail;

  CartPage({Key? key, this.userEmail}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  DioClient dioClient = DioClient();
  List? listArtCart;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 100.0),
      //   child: const ArtAppBar(),
      // ),
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: const BoxDecoration(
          gradient: theme.Theme.mainGradient,
        ),
        child: Builder(builder: (context) {
          return FutureBuilder(
              future: dioClient.getAllCartByUserEmail(widget.userEmail),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // List _list = [];
                  listArtCart = snapshot.data as List;
                  int totalMoney = 0;

                  for (ArtCart artCart in listArtCart!) {
                    totalMoney = (totalMoney + artCart.money) as int;
                  }
                  return ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              color:Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,),
                            ),
                            Text(
                              "SHOPPING CART",
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorBlack,
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      // createHeader(),
                      createSubTitle(listArtCart?.length),
                      createCartList(listArtCart),
                      footer(context, totalMoney,listArtCart?.length),
                    ],
                  );
                } else {
                  return Container();
                }
              });
          // return FutureBuilder(
          //   future: dioClient.getAllCartByUserEmail(widget.userEmail!),
          //   builder: (context, snapshot){
          //     if(snapshot.hasData){
          //       List? _list = [];
          //       _list = snapshot.data as List?;
          //       return ListView(
          //         children: <Widget>[
          //           createHeader(),
          //           createSubTitle(),
          //           createCartList(),
          //           footer(context),
          //         ],
          //       );
          //     }else{
          //       return Container();
          // }
          //   };

          // return ListView(
          //   children: <Widget>[
          //     createHeader(),
          //     createSubTitle(),
          //     createCartList(),
          //     footer(context),
          //   ],
          // );
        }),
      ),
    );
  }

  footer(BuildContext context, int totalMoney, int? itemsCount) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.white, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  "\$$totalMoney",
                  style: CustomTextStyle.textFormFieldBlack.copyWith(
                      color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8),
          RaisedButton(
            onPressed: () {
              if(itemsCount != null && itemsCount > 0){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage(email: widget.userEmail,totalMoney: totalMoney,)));
              }else{
                EasyLoading.showInfo("Cart is empty");
              }
            },
            // onPressed: () => {
            // showThankYouBottomSheet(context),
            // },
            color: Colors.green,
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Checkout",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(color: Colors.white),
            ),
          ),
          Utils.getSizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "SHOPPING CART",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle(int? itemsLength) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total($itemsLength) Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.white),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList(List<dynamic>? listArtCart) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: listArtCart?.length,
      itemBuilder: (context, index) {
        return createCartListItem(listArtCart![index], index);
      },
    );
  }

  createCartListItem(ArtCart artCart, int index) {
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CourseInfoScreen(
                      painting: artCart.painting,
                    );
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.blue.shade200,
                      image: DecorationImage(
                        image:  NetworkImage(Assets.oss_painting_square + '${artCart.painting.imageFileName}' + '.jpg'),
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 8, top: 4),
                            child: Text(
                              // "NIKE XTM Basketball Shoeas",
                              '${artCart.painting.title}',
                              maxLines: 2,
                              softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                          Utils.getSizedBox(width: 6),
                          Text(
                            artCart.painting.artist.firstName != null ?
                            "${artCart.painting.artist.firstName}" " " + artCart.painting.artist.lastName : "null",
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                          Container(
                            width: screenSize.width * 7,
                            child:  Text(
                              artCart.painting.description == null ? "null" : '${artCart.painting.description}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                            ),
                          ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              // "\$299.00",
                              "\$${artCart.painting.cost}",
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.green),
                            ),

                            if(artCart.painting.sell)
                              Text(
                              // "\$299.00",
                              "Sold, invalid order!",
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.green),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.remove,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                      "1",
                                      style:
                                          CustomTextStyle.textFormFieldSemiBold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
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
            child: InkWell(
              onTap: () async {
                await dioClient.deleteCartById(artCart.id);
                setState(() {
                  listArtCart?.removeAt(index);
                });
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.green),
          ),
        )
      ],
    );
  }
}
