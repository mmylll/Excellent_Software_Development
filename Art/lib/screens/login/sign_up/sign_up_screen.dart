import 'dart:math';

import 'package:art/dio/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:art/data/theme.dart' as theme;
import '../../../packages/flutter_firebase_chat_core/src/firebase_chat_core.dart';
import '../../../model/art_user.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DioClient dioClient = DioClient();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
        padding: const EdgeInsets.only(top: 23),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,

          fit: StackFit.loose,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                ),
                width: 300,
                height: 530,
                child: buildSignUpTextForm()),
            Positioned(
              child: Center(
                  child: buildSignUpButton()
              ),
              top: 490,
              bottom: 0,
            ),
          ],
        ),
 );
  }

  void showPassWord() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  void showConfirmPassword() {
    setState(() {
      isShowConfirmPassword = !isShowConfirmPassword;
    });
  }

  Widget buildSignUpTextForm() {
    return Form(
        key: _signUpFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //用户名字
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.black,
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    RegExp reg = RegExp(r'[a-zA-Z0-9_-]+');
                    if(value == null || value.isEmpty){
                      return 'username can not be empty';
                    }else if (!reg.hasMatch(value)) {
                      return 'username can only contain upper and lower case letters, numbers, _ and -';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            //邮箱
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                // child: TextFormField(
                //   controller: emailController,
                //   decoration: const InputDecoration(
                //       icon: Icon(
                //         Icons.email,
                //         color: Colors.black,
                //       ),
                //       hintText: "Email Address",
                //       hintStyle: TextStyle(color: Colors.black),
                //       border: InputBorder.none),
                //   style: const TextStyle(fontSize: 16, color: Colors.black),
                //   validator: (value) {
                //     RegExp reg = RegExp(r'^[\w-]+(/.[\w-]+)*@[\w-]+(/.[\w-]+)+$');
                //     if(value == null){
                //       return 'email can not be empty';
                //     }else if (!reg.hasMatch(value)) {
                //       return 'the email format is like A@B.C';
                //     }else{
                //       return null;
                //     }
                //   },
                // ),
                child: TextFormField(
                  //关联焦点
                  // focusNode: emailFocusNode,
                  controller: emailController,
                  onEditingComplete: () {
                    // focusScopeNode;
                    // focusScopeNode.requestFocus(passwordFocusNode);
                  },

                  decoration: const InputDecoration(
                      hintText: "Email",
                      hintStyle:TextStyle(
                        color: Colors.black,
                      ),
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      // hintText: "Email Address",
                      // hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                        RegExp reg = RegExp(r'\w+@[a-zA-Z0-9]{1,}(.[a-zA-Z0-9]{1,}){1,}');
                        if(value == null || value.isEmpty){
                          return 'email can not be empty';
                        }else if (!reg.hasMatch(value)) {
                          return 'the email format is like A@B.C';
                        }else{
                          return null;
                        }
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
            //地址
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      hintText: "Address",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'address can not be empty';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
            ),

            Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            //电话
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: phoneController,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //       RegExp(r"(d+-)?(d{4}-?d{7}|d{3}-?d{8}|^d{7,8})(-d+)?"))
                  // ],
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      hintText: "Phone",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    RegExp reg = RegExp(r'^(\+86|0086)?\s*1[34578]\d{9}$');
                    if(value == null || value.isEmpty){
                      return 'phone can not be empty';
                    }else if (!reg.hasMatch(value)) {
                      return 'Incorrect phone format';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
            ),

            Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            //密码
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        icon: !isShowPassword ?
                        const Icon(
                          Icons.visibility_off,
                          color: Colors.black,
                        ) : const Icon(Icons.visibility),
                        onPressed: () {showPassWord();}),
                  ),
                  obscureText: !isShowPassword,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    RegExp reg = RegExp(r'^[0-9]*$');
                    if(value == null || value.isEmpty){
                      return 'password can not be empty';
                    }else if(value.length < 6){
                      return 'Password length must be greater than or equal to 6 digits';
                    } else if (reg.hasMatch(value)) {
                      return 'Password length must not be pure numbers';
                    }else if(value == usernameController.text){
                      return 'Username and password cannot be the same';
                    }else{
                      return null;
                    }
                  },
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
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        icon: !isShowConfirmPassword ?
                        const Icon(
                          Icons.visibility_off,
                          color: Colors.black,
                        ) : const Icon(Icons.visibility),
                        onPressed: () {showConfirmPassword();}),
                  ),
                  obscureText: !isShowConfirmPassword,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if(value != passwordController.text){
                      return 'The password entered twice is not the same, please check';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildSignUpButton(){
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(
            top: 10, bottom: 10, left: 42, right: 42),
        decoration: const BoxDecoration(
          gradient: theme.Theme.primaryGradient,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: const Text("SignUp",
            style: TextStyle(fontSize: 25, color: Colors.white)),
      ),
      onTap: () async {
        if (_signUpFormKey.currentState!.validate()) {
          //如果输入都检验通过，则进行登录操作
          // Scaffold.of(context)
          //     .showSnackBar(const SnackBar(content: Text("执行注册操作")));
          //调用所有自孩子的save回调，保存表单内容
          _signUpFormKey.currentState!.save();

          ArtUser user = ArtUser(
              username: usernameController.text,
              password: passwordController.text,
              email: emailController.text,
              address: addressController.text,
              phone: phoneController.text,
            balance: 0,
          );
          bool result = dioClient.register(user: user) as bool;
          if(result){
            Navigator.pop(context);
          }
        }

      },
    );
  }
}
