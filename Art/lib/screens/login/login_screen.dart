import 'package:art/screens/login/sign_in/sign_in_screen.dart';
import 'package:art/screens/login/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late PageView _pageView;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageView = PageView(
      controller: _pageController,
      children: const <Widget>[
        SignInScreen(),
        SignUpScreen(),
      ],
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        /**
       * SafeArea，让内容显示在安全的可见区域
       * SafeArea，可以避免一些屏幕有刘海或者凹槽的问题
       */
        body: SafeArea(
      child: SingleChildScrollView(
          /**
             * 用SingleChildScrollView+Column，避免弹出键盘的时候，出现overFlow现象
             */
          child: Container(
              /**这里要手动设置container的高度和宽度，不然显示不了
                 * 利用MediaQuery可以获取到跟屏幕信息有关的数据
                 */
              height: screenSize.height*1.2,
              width: screenSize.width,
              //设置渐变的背景
              decoration: const BoxDecoration(
                gradient: theme.Theme.primaryGradient,
                image: DecorationImage(
                  image: AssetImage("assets/images/login_logo.png"),
                  // image: AssetImage("assets/images/welcome.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.2,
                  ),
                  /**
                       * 可以用SizeBox这种写法代替Padding：在Row或者Column中单独设置一个方向的间距的时候
                       * new Padding(padding: EdgeInsets.only(top: 75)),
                       */
                  //中间的Indicator指示器
                  Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color(0x552B2B2B),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          /**
                                   * TODO:暂时不会用Paint去自定义indicator，所以暂时只能这样实现了
                                   */
                          decoration: _currentPage == 0
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white,
                                )
                              : null,
                          child: Center(
                            child: FlatButton(
                              onPressed: () {
                                _pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                              child: const Text(
                                "Existing",
                                style: TextStyle(
                                    fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: Container(
                          decoration: _currentPage == 1
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white,
                                )
                              : null,
                          child: Center(
                            child: FlatButton(
                              onPressed: () {
                                _pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                              child: const Text(
                                "New",
                                style: TextStyle(
                                    fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
//                      new SignInPage(),
//                      new SignUpPage(),
                  Expanded(child: _pageView),
                ],
              ))),
    ));
  }
}
