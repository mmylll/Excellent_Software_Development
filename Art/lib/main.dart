import 'package:art/bloc/main/view.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Art Store',
      debugShowCheckedModeBanner: false,
      // theme: theme.Theme.lightThemeData,
      darkTheme: theme.Theme.darkThemeData,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // theme: ThemeData.dark().copyWith(
      //   primaryColor: primaryColor,
      //   scaffoldBackgroundColor: bgColor,
      //   canvasColor: bgColor,
      //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
      //       .apply(bodyColor: Colors.white)
      //       .copyWith(
      //     bodyText1: const TextStyle(color: bodyTextColor),
      //     bodyText2: const TextStyle(color: bodyTextColor),
      //   ),
      // ),

      // theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //     scaffoldBackgroundColor: Colors.black
      // ),
      // home: BlocProvider<AppBarCubit>(
      //   create: (context) => AppBarCubit(),
      //   child: const NavScreen(),
      // ),
      // home: Pager(total: 14, pageChange: (value) {
      //
      // },),
      // home: const TestPage(title: "test"),
      // home: const NavScreen(),
      home: const MainPage(),
      builder: EasyLoading.init(),
      // home: CounterPage(),
      // home: const RoomsPage(),
    );
  }
}
