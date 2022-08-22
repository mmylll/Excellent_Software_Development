import 'package:art/config/responsive.dart';
import 'package:art/dio/dio_client.dart';
import 'package:art/model/painting.dart';
import 'package:art/screens/cart/cart_page.dart';
import 'package:art/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../components/art_app_bar.dart';
import '../../../data/constants.dart';
import '../../cart/cart.dart';
import 'details_theme.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art/data/assets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseInfoScreen extends StatefulWidget {
  Painting? painting;

  CourseInfoScreen({Key? key, required this.painting}) : super(key: key);

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  DioClient dioClient = DioClient();
  late String times = "";
  User? fireUser;
  bool _initialized = false;
  bool _error = false;

  // var _futureBuilderFuture;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));

    initializeFlutterFire();
    setViews();

    setData();
    getTime();
    // _futureBuilderFuture = dioClient.getTime(widget.painting!.yearOfWork);
    super.initState();
  }

  void setViews() {
    dioClient.updateViews(widget.painting!.paintingId);
  }

  void getTime() async {
    setState(() async {
      times = await dioClient.getTime(widget.painting!.yearOfWork) as String;
    });
  }

  void initializeFlutterFire() async {
    try {
      // await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          fireUser = user!;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return Responsive(
      mobile: mobileDetails(),
      desktop: desktopDetails(),
      tablet: desktopDetails(),
    );
  }

  Widget mobileDetails() {
    final Size screenSize = MediaQuery.of(context).size;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      decoration: const BoxDecoration(
        gradient: theme.Theme.mainGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        // appBar: PreferredSize(
        //   preferredSize: Size(screenSize.width, 100.0),
        //   child: const ArtAppBar(),
        // ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image(
                    width: 300,
                    fit: BoxFit.contain,
                    image: NetworkImage(Assets.oss_painting_square + widget.painting!.imageFileName!+ '.jpg'),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              // 'Web Design\nCourse',
                              widget.painting == null
                                  ? 'Web Design\nCourse'
                                  : '${widget.painting?.title}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.painting == null
                                      ? '\$28.99'
                                      : '\$${widget.painting?.cost}',
                                  // '\$28.99',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.nearlyBlue,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        // '4.3',
                                        widget.painting == null
                                            ? '4.3'
                                            : '${widget.painting!.views}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: DesignCourseAppTheme.nearlyBlue,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(
                                    'Author',
                                    // 'Author'
                                    widget.painting == null
                                        ? 'Author'
                                        : '${widget.painting?.artist.firstName}'
                                        ' '
                                        '${widget.painting?.artist.lastName}',
                                  ),
                                  getTimeBoxUI(
                                    'Particular Year',
                                    widget.painting == null
                                        ? 'Particular Year'
                                        : '${widget.painting?.yearOfWork}',
                                  ),
                                  getTimeBoxUI(
                                    'Size',
                                    widget.painting == null
                                        ? 'Size'
                                        : '${widget.painting?.width}'
                                        '*'
                                        '${widget.painting?.height}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Text(
                                  // 'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                  widget.painting == null
                                      ? 'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.'
                                      : '${widget.painting!.description}',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 48,
                                    height: 48,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: DesignCourseAppTheme.nearlyWhite,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        border: Border.all(
                                            color: DesignCourseAppTheme.grey
                                                .withOpacity(0.2)),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: DesignCourseAppTheme.nearlyBlue,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async => {
                                        if (fireUser != null){
                                          if (!widget.painting!.sell){
                                            await dioClient.addToCart(
                                                widget.painting!.paintingId,
                                                widget.painting!.cost,
                                                fireUser?.email),
                                  EasyLoading.showSuccess("Add to cart successfully!"),
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                                CartPage(userEmail: fireUser?.email,))),
                                          }else{
                                            EasyLoading.showInfo("This artwork has been sold!"),
                                          }
                                        }else{
                                          EasyLoading.showInfo("Please log in first!"),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                  const LoginScreen())),
                                        }
                                      },
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: DesignCourseAppTheme.nearlyBlue,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: DesignCourseAppTheme
                                                    .nearlyBlue
                                                    .withOpacity(0.5),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 10.0),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Add To Cart',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              color: DesignCourseAppTheme
                                                  .nearlyWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController!, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: DesignCourseAppTheme.nearlyBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: DesignCourseAppTheme.nearlyWhite,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget desktopDetails() {
    final Size screenSize = MediaQuery.of(context).size;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
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
              // const SizedBox(height: kDefaultPadding * 3),
              Row(
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
                    'Details',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: colorBlack,
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                    height: 30,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  // Column(
                  //   children: <Widget>[
                  //     // AspectRatio(
                  //     //   aspectRatio: 1.2,
                  //     //   child: Image.asset('assets/images/animals.jpg'),
                  //     // ),
                  //     Image.asset(
                  //       'assets/images/animals.jpg',
                  //       width: screenSize.width * 0.4,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    width: screenSize.width,
                    // top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                    // bottom: 0,
                    // left: 0,
                    // right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: DesignCourseAppTheme.nearlyWhite,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight: infoHeight,
                                maxHeight: screenSize.height > infoHeight
                                    ? screenSize.height
                                    : infoHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: (Responsive.isDesktop(context)
                                          ? screenSize.width * 0.4
                                          : screenSize.width * 0.52),
                                      alignment: Alignment.centerRight,
                                      // child: Image.asset(
                                      //   'assets/images/animals.jpg',
                                      //   width: screenSize.width * 0.3,
                                      // ),
                                      child: AspectRatio(
                                        aspectRatio: 1.2,
                                        child:
                                        Image(
                                          width: 300,
                                          fit: BoxFit.contain,
                                          image: NetworkImage(Assets.oss_painting_square + widget.painting!.imageFileName!+ '.jpg'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.02,
                                    ),
                                    Container(
                                      width: (Responsive.isDesktop(context)
                                          ? screenSize.width * 0.48
                                          : screenSize.width * 0.4),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 18, right: 16),
                                            child: Text(
                                              // 'Web Design Course',
                                              widget.painting == null
                                                  ? 'Web Design Course'
                                                  : '${widget.painting?.title}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 8,
                                                top: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  // '\$28.99',
                                                  widget.painting == null
                                                      ? 'null'
                                                      : '\$${widget.painting?.cost}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 22,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .nearlyBlue,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        // '4.3',
                                                        widget.painting == null
                                                            ? 'null'
                                                            : '${widget.painting?.views}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 22,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyBlue,
                                                        size: 24,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            opacity: opacity1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Wrap(
                                                children: <Widget>[
                                                  getTimeBoxUI(
                                                    'Author',
                                                    // 'Author'
                                                    widget.painting == null
                                                        ? 'Author'
                                                        : '${widget.painting?.artist.firstName}'
                                                            ' '
                                                            '${widget.painting?.artist.lastName}',
                                                  ),
                                                  getTimeBoxUI(
                                                    'Visits',
                                                    widget.painting == null
                                                        ? 'Visits'
                                                        : '${widget.painting?.views}',
                                                  ),
                                                  getTimeBoxUI(
                                                    'Sell',
                                                    widget.painting == null
                                                        ? 'Sell'
                                                        : '${widget.painting?.sell}',
                                                  ),
                                                  getTimeBoxUI(
                                                    'Particular Year',
                                                    widget.painting == null
                                                        ? 'Particular Year'
                                                        : '${widget.painting?.yearOfWork}',
                                                  ),
                                                  getTimeBoxUI(
                                                    'Size',
                                                    widget.painting == null
                                                        ? 'Size'
                                                        : '${widget.painting?.width}'
                                                            '*'
                                                            '${widget.painting?.height}',
                                                  ),
                                                  // widget.painting != null
                                                  //     ? FutureBuilder(
                                                  //         future: _futureBuilderFuture,
                                                  //         builder: (context, snapshot) {
                                                  //           if (snapshot.hasData) {
                                                  //             print("/////////////////");
                                                  //             print(widget.painting?.paintingId);
                                                  //             print(snapshot.data);
                                                  //             return getTimeBoxUI(
                                                  //                 'Times',
                                                  //                 snapshot.data
                                                  //                     as String);
                                                  //           } else {
                                                  //             return getTimeBoxUI(
                                                  //                 'Times',
                                                  //                 'Times');
                                                  //           }
                                                  //         })
                                                  //     : getTimeBoxUI(
                                                  //         'Times', 'Times'),

                                                  times == ""
                                                      ? getTimeBoxUI(
                                                          'Times', 'Times')
                                                      : getTimeBoxUI(
                                                          "Times", times),
                                                  getTimeBoxUI(
                                                      'Style', 'Style'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 20,
                                                top: 16),
                                            child: Text(
                                              widget.painting == null
                                                  ? 'null'
                                                  : '${widget.painting?.description}',
                                              // 'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 14,
                                                letterSpacing: 0.27,
                                                color:
                                                    DesignCourseAppTheme.grey,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            opacity: opacity3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16,
                                                  bottom: 16,
                                                  right: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 48,
                                                    height: 48,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyWhite,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(16.0),
                                                        ),
                                                        border: Border.all(
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2)),
                                                      ),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyBlue,
                                                        size: 28,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      // onTap: () {
                                                      //   Navigator.of(context).push(MaterialPageRoute(
                                                      //     builder: (context) {
                                                      //       // return Cart();
                                                      //       return CartPage();
                                                      //       // return const PersonalCenterScreen();
                                                      //     },
                                                      //   ));
                                                      // },
                                                      onTap: () async => {
                                                        if (fireUser != null){
                                                            if (!widget.painting!.sell){
                                                                await dioClient.addToCart(
                                                                    widget.painting!.paintingId,
                                                                    widget.painting!.cost,
                                                                    fireUser?.email),
                                                              EasyLoading.showSuccess("Add to cart successfully!"),
                                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                                                                CartPage(userEmail: fireUser?.email,))),
                                                              }else{
                                                              EasyLoading.showInfo("This artwork has been sold!"),
                                                            }
                                                          }else{
                                                          EasyLoading.showInfo("Please log in first!"),
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext context) =>
                                                                  const LoginScreen())),
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 48,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .nearlyBlue,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                16.0),
                                                          ),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                                color: DesignCourseAppTheme
                                                                    .nearlyBlue
                                                                    .withOpacity(
                                                                        0.5),
                                                                offset:
                                                                    const Offset(
                                                                        1.1,
                                                                        1.1),
                                                                blurRadius:
                                                                    10.0),
                                                          ],
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Add To Cart',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18,
                                                              letterSpacing:
                                                                  0.0,
                                                              color: DesignCourseAppTheme
                                                                  .nearlyWhite,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                // const Padding(
                                //   padding: EdgeInsets.only(
                                //       top: 32.0, left: 18, right: 16),
                                //   child: Text(
                                //     'Web Design\nCourse',
                                //     textAlign: TextAlign.left,
                                //     style: TextStyle(
                                //       fontWeight: FontWeight.w600,
                                //       fontSize: 22,
                                //       letterSpacing: 0.27,
                                //       color: DesignCourseAppTheme.darkerText,
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 16, right: 16, bottom: 8, top: 16),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: <Widget>[
                                //       const Text(
                                //         '\$28.99',
                                //         textAlign: TextAlign.left,
                                //         style: TextStyle(
                                //           fontWeight: FontWeight.w200,
                                //           fontSize: 22,
                                //           letterSpacing: 0.27,
                                //           color: DesignCourseAppTheme.nearlyBlue,
                                //         ),
                                //       ),
                                //       Container(
                                //         child: Row(
                                //           children: const <Widget>[
                                //             Text(
                                //               '4.3',
                                //               textAlign: TextAlign.left,
                                //               style: TextStyle(
                                //                 fontWeight: FontWeight.w200,
                                //                 fontSize: 22,
                                //                 letterSpacing: 0.27,
                                //                 color: DesignCourseAppTheme.grey,
                                //               ),
                                //             ),
                                //             Icon(
                                //               Icons.star,
                                //               color: DesignCourseAppTheme.nearlyBlue,
                                //               size: 24,
                                //             ),
                                //           ],
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),

                                // Expanded(
                                //   child: AnimatedOpacity(
                                //     duration: const Duration(milliseconds: 500),
                                //     opacity: opacity2,
                                //     child: const Padding(
                                //       padding: EdgeInsets.only(
                                //           left: 16, right: 16, top: 8, bottom: 8),
                                //       child: Text(
                                //         'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                //         textAlign: TextAlign.justify,
                                //         style: TextStyle(
                                //           fontWeight: FontWeight.w200,
                                //           fontSize: 14,
                                //           letterSpacing: 0.27,
                                //           color: DesignCourseAppTheme.grey,
                                //         ),
                                //         maxLines: 3,
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                SizedBox(
                                  height: MediaQuery.of(context).padding.bottom,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   // top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                  //   // right: 35,
                  //   child: ScaleTransition(
                  //     alignment: Alignment.center,
                  //     scale: CurvedAnimation(
                  //         parent: animationController!, curve: Curves.fastOutSlowIn),
                  //     child: Card(
                  //       color: DesignCourseAppTheme.nearlyBlue,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(50.0)),
                  //       elevation: 10.0,
                  //       child: Container(
                  //         width: 60,
                  //         height: 60,
                  //         child: Center(
                  //           child: Icon(
                  //             Icons.favorite,
                  //             color: DesignCourseAppTheme.nearlyWhite,
                  //             size: 30,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Padding(
                  //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  //   child: SizedBox(
                  //     width: AppBar().preferredSize.height,
                  //     height: AppBar().preferredSize.height,
                  //     child: Material(
                  //       color: Colors.transparent,
                  //       child: InkWell(
                  //         borderRadius:
                  //         BorderRadius.circular(AppBar().preferredSize.height),
                  //         child: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: DesignCourseAppTheme.nearlyBlack,
                  //         ),
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
