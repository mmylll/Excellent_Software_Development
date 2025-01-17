import 'package:art/dio/dio_client.dart';
import 'package:art/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import '../../components/art_app_bar.dart';
import '../../data/constants.dart';
import '../personal_center/personal_center_screen.dart';
import 'custom_text_style.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:google_fonts/google_fonts.dart';

class CheckOutPage extends StatefulWidget {
  String? email;
  int totalMoney;
  CheckOutPage({Key? key,this.email,required this.totalMoney}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  DioClient dioClient = DioClient();

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 100.0),
      //   child: const ArtAppBar(),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: theme.Theme.mainGradient,
        ),
        child:  Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back, color: colorBlack),
                            ),
                            Text(
                              'CheckOut',
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
                      selectedAddressSection(),
                      // standardDelivery(),
                      // checkoutItem(),
                      priceSection()
                    ],
                  ),
                ),
                flex: 90,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: RaisedButton(
                    onPressed: () async {
                      // /*Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (context) => OrderPlacePage()));*/
                      bool result = await dioClient.payment(widget.totalMoney, widget.email);
                      if(result){
                        showThankYouBottomSheet(context);
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const PersonalCenterScreen();
                          },
                        ));
                      }
                    },
                    child: Text(
                      "Place Order",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                ),
                flex: 10,
              )
            ],
          );
        }),
      ),

    );
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState?.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                            "\n\nThank you for your purchase.",
                            style:
                            CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    const SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      // onPressed: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) {
                      //       return CartPage();
                      //     },
                      //   ));
                      // },
                      onPressed: ()=> {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const PersonalCenterScreen();
                            },
                          ))
                      },
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Track Order",
                        style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.white),
                      ),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  selectedAddressSection() {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "mmy (Default)",
                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                      style:
                      CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.indigoAccent.shade200, fontSize: 8),
                    ),
                  )
                ],
              ),
              createAddressText("431, Commerce House, Nagindas Master, Fort", 16),
              createAddressText("Mumbai - 400023", 6),
              createAddressText("Maharashtra", 6),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: "02222673745",
                      style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Edit / Change",
              style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 12, color: Colors.indigo.shade700),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 3,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Add New Address",
                style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 12, color: Colors.indigo.shade700)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  standardDelivery() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: Colors.tealAccent.withOpacity(0.4), width: 1),
          color: Colors.tealAccent.withOpacity(0.2)),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Standard Delivery",
                style: CustomTextStyle.textFormFieldMedium
                    .copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Get it by 20 jul - 27 jul | Free Delivery",
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  checkoutItem() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem();
            },
            itemCount: 3,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(
                "assets/images/animals.jpg",
              ),
              width: 35,
              height: 45,
              fit: BoxFit.fitHeight,
            ),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          ),
          SizedBox(
            width: 8,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Estimated Delivery : ", style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 12)),
              TextSpan(
                  text: "21 Jul 2019 ",
                  style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 12, fontWeight: FontWeight.w600))
            ]),
          )
        ],
      ),
    );
  }

  priceSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                style: CustomTextStyle.textFormFieldMedium
                    .copyWith(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total MRP", getFormattedCurrency(5197), Colors.grey.shade700),
              createPriceItem("Bag discount", getFormattedCurrency(3280), Colors.teal.shade300),
              createPriceItem("Tax", getFormattedCurrency(96), Colors.grey.shade700),
              createPriceItem("Order Total", getFormattedCurrency(2013), Colors.grey.shade700),
              createPriceItem("Delievery Charges", "FREE", Colors.teal.shade300),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black, fontSize: 12),
                  ),
                  Text(
                    getFormattedCurrency(widget.totalMoney.toDouble()),
                    style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.black, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getFormattedCurrency(double amount) {
    MoneyFormatter fmf = MoneyFormatter(amount: amount);
    fmf.settings!
      ..symbol = "₹"
      ..thousandSeparator = ","
      ..decimalSeparator = "."
      ..fractionDigits = 2;
    return fmf.output.symbolOnLeft;
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: CustomTextStyle.textFormFieldMedium.copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}