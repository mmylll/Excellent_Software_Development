import 'package:art/bloc/main/view.dart';
import 'package:art/dio/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:art/data/theme.dart' as theme;
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  /// 利用FocusNode和FocusScopeNode来控制焦点
  /// 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusScopeNode focusScopeNode = FocusScopeNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _signInFormKey = GlobalKey();

  DioClient dioClient = DioClient();

  bool isShowPassWord = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // return BlocProvider(
    //   create: (BuildContext context) => MainCubit(),
    //   child: Builder(builder: (context) => _buildPage(context)),
    // );
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            children: <Widget>[
              //创建表单
              buildSignInTextForm(),
              const Padding(
                padding: EdgeInsets.only(top: 75),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
              ),

              /**
               * Or所在的一行
               */
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
//                          mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 100,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.white10,
                            Colors.black,
                          ])),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Or",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.white,
                            Colors.white10,
                          ])),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const MainPage();
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Go Home?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),


              /**
               * 显示第三方登录的按钮
               */
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const IconButton(
                        icon: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF0084ff),
                        ),
                        onPressed: null),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const IconButton(
                        icon: Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFF0084ff),
                        ),
                        onPressed: null),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            child: buildSignInButton(context),
            top: 220,
          )
        ],
      ),
    );
  }

  /// 点击控制密码是否显示
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  /// 创建登录界面的TextForm
  Widget buildSignInTextForm() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      width: 300,
      height: 200,
      /**
       * Flutter提供了一个Form widget，它可以对输入框进行分组，
       * 然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
       */
      child: Form(
        key: _signInFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: TextFormField(
                  focusNode: emailFocusNode,
                  controller: emailController,
                  decoration: const InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.black,
                      ),
                      hintText: "Email Address / Username",
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Email or username can not be empty!";
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
              ),
            ),
            Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: TextFormField(
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: !isShowPassWord
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )
                              : const Icon(Icons.visibility),
                          onPressed: showPassWord)),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password is empty!";
                    }else if(value.length < 6){
                      return "Password length must longer than 6!";
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 创建登录界面的按钮
  Widget buildSignInButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding:
            const EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: theme.Theme.primaryGradient,
        ),
        child: const Text(
          "LOGIN",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () async {
        // dioClient.login(
        //     email: emailController.text,
        //     password: passwordController.text) as String;

        /**利用key来获取widget的状态FormState
            可以用过FormState对Form的子孙FromField进行统一的操作
         */

        if (_signInFormKey.currentState!.validate()) {
          //如果输入都检验通过，则进行登录操作
          // Scaffold.of(context)
          //     .showSnackBar(const SnackBar(content: Text("执行登录操作")));
          //调用所有自孩子的save回调，保存表单内容
          bool result = false;
          String? email = emailController.text;
          _signInFormKey.currentState!.save();
          if(!emailController.text.contains('@')){
            email = await dioClient.getEmail(emailController.text);
          }

          result = await dioClient.login(email: email!, password: passwordController.text) as bool;
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) {
          //     return const MainPage();
          //   },
          // ));
          if(result){
            Navigator.pop(context);
          }

          // dioClient.tokenInter();
          // String? test =  dioClient.test() as String?;
          // print(dioClient.test());
        } //          debugDumpApp();
      },
    );
  }
}
