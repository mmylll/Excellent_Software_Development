import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:art/model/art_order.dart';
import 'package:art/model/painting.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/art_cart.dart';
import '../model/art_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../packages/flutter_firebase_chat_core/src/firebase_chat_core.dart';

class DioClient {
  final Dio _dio = Dio();

  // final _baseUrl = 'http://localhost:8085/';
  final _baseUrl = 'http://180.76.151.171:8085/';

  //拦截器部分
  tokenInter(){
   _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (request, requestInterceptorHandler){
          _dio.lock();
          Future<dynamic> future = Future(()async{
            SharedPreferences prefs =await SharedPreferences.getInstance();
            return prefs.getString("token");
          });
          future.then((value){
            request.headers["Authorization"] = value;
          }).whenComplete(() => _dio.unlock());
        },
        // onRequest:(RequestOptions options){
        //   // 在发送请求之前做一些预处理
        //   //我这边是在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
        //   //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
        //   dio.lock();
        //   Future<dynamic> future = Future(()async{
        //     SharedPreferences prefs =await SharedPreferences.getInstance();
        //     return prefs.getString("loginToken");
        //   });
        //   return future.then((value) {
        //     options.headers["Authorization"] = value;
        //     return options;
        //   }).whenComplete(() => dio.unlock()); // unlock the dio
        // },
        onResponse:(response, responseInterceptorHandler) {
          // 在返回响应数据之前做一些预处理

        },
        onError: (dioError, errorInterceptorHandler) {
          // 当请求失败时做一些预处理

        }
    ));
  }

  Future<bool?> register({required ArtUser user}) async {
    ArtUser? retrievedUser;
    bool result = false;


    try {
      Response response = await _dio.post(
        _baseUrl + 'Register',
        data: user.toJson(),
      );

      if(response.data["status"] as int != 200){
        EasyLoading.showError(response.data["message"]);
      }else {
        try {
          final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );
          await FirebaseChatCore.instance.createUserInFirestore(
            types.User(
              firstName: "",
              id: credential.user!.uid,
              imageUrl: 'https://art-store.oss-cn-shanghai.aliyuncs.com/images/self/default_user.jpeg',
              lastName: user.username,
              // metadata: _metaData,
            ),
          );
          result = true;
          EasyLoading.showSuccess('Register Success!');
        } catch (e) {
          debugPrint('Error : $e');
        }
      }

    } catch (e) {
      debugPrint('Error : $e');
    }
    return result;
  }

  Future<bool?> login({required String email, required String password}) async {
    UserCredential? userCredential;
    ArtUser? artUser;
    bool result = true;
    String artEmail = email;
    bool getEmail = false;

    var data={'username':email};

      try{
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: artEmail,
          password: password,
        );
        EasyLoading.showSuccess('Login Success!');
      }catch(e){
        // EasyLoading.showError('wrong user name or password');
        EasyLoading.showError(e.toString());
        debugPrint('Error: $e');
        result = false;
      }



    String? token = await userCredential?.user?.getIdToken();
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString("token",token!);
    // debugPrint('token: ${prefs.getString("token")}');
    return result;
  }

  Future<String?> getToken({required String token}) async {
    try{
      Response response = await _dio.post(
        _baseUrl + 'GetToken',
        data: {"token": token},
      );
      // artUser = ArtUser.fromJson(response.data);
    }catch(e){
      debugPrint('Error login: $e');
    }
    return null;
  }

  Future<String?> getEmail(String email) async {
    ArtUser? artUser;
    String artEmail;
    var data={'username':email};
      try {
        Response response = await _dio.post(
          _baseUrl + 'Login',
          queryParameters: data,
        );

        if(response.data['status'] != 200){
          EasyLoading.showError(response.data['message']);
        }else{
          artUser = ArtUser.fromJson(response.data["data"]);
        }
        // artUser = ArtUser.fromJson(response.data["data"]);

      }catch(e){
        EasyLoading.showError(e.toString());
      }
    return artUser?.email;
  }

  Future<String?> test() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'test',
      );
      // artUser = ArtUser.fromJson(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    return null;
  }

  Future<List<Painting>> getPopularArts() async{
    List<Painting> paintings = [];
    List _list = [];
    SharedPreferences prefs =await SharedPreferences.getInstance();
    Options options = Options();
    // options.headers!["Access-Control-Allow-Origin"] = "*";
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getPopularPaintings',
        // options: options,
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){
          Painting? painting = Painting.fromJson(a);
          paintings.add(painting);
        }
      }
      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return paintings;
  }

  Future<int> getAllPaintingsCount() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    int pageCount = 0;
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getAllPaintingsCount',
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        pageCount = response.data["data"];
      }

      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return pageCount;
  }

  Future<List<Painting>> getAllPaintings(int pageIndex) async{
    List<Painting> paintings = [];
    List _list = [];
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'pageIndex':pageIndex};
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getAllPaintings',
        queryParameters: data,
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){
          Painting? painting = Painting.fromJson(a);
          paintings.add(painting);
        }
      }

      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return paintings;
  }

  Future<List<Painting>> getSearchPaintings(String search,int pageIndex) async{
    List<Painting> paintings = [];
    List _list = [];
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'search':search,'pageIndex':pageIndex};
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getSearchPaintings',
        queryParameters: data,
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
     if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){
          Painting? painting = Painting.fromJson(a);
          paintings.add(painting);
        }
      }

      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return paintings;
  }

  Future<int> getSearchPaintingsCount(String search) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    int pageCount = 0;
    var data={'search':search};
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getSearchPaintingsCount',
        queryParameters: data,
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        pageCount = response.data["data"];
      }


      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return pageCount;
  }

  Future<List<Painting>> getSearchPaintingsAndSort(String search,int pageIndex,int sort) async{
    List<Painting> paintings = [];
    List _list = [];
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'search':search,'pageIndex':pageIndex,'sort':sort};
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getSearchPaintingsAndSort',
        queryParameters: data,
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){
          Painting? painting = Painting.fromJson(a);
          paintings.add(painting);
        }
      }

      print(paintings);

      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return paintings;
  }

  Future<List<Painting>> getAllPaintingsAndSort(int pageIndex,int sort) async{
    List<Painting> paintings = [];
    List _list = [];
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'pageIndex':pageIndex,'sort':sort};
    try{
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getAllPaintingsAndSort',
        queryParameters: data,
      );
      // artUser = ArtUser.fromJson(response.data);
      // debugPrint('${response.data["data"]}');
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){
          Painting? painting = Painting.fromJson(a);
          paintings.add(painting);
        }
      }

      // for(int i = 0;i < response.data.data.length)
    }catch(e){
      debugPrint('Error: $e');
    }

    return paintings;
  }

  Future<String?> getTime(int yearOfWork) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'yearOfWork':yearOfWork};
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getTime',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        result = response.data["data"];
      }

      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    return result;
  }

  Future<int?> updateViews(int paintingId) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'paintingId':paintingId};
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.post(
        _baseUrl + 'updateViews',
        queryParameters: data,
      );

      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        result = response.data["data"];
      }

      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    return result;
  }

  Future<ArtUser?> getArtUserByEmail(String? email) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'email':email};
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getArtUserByEmail',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        result = ArtUser.fromJson(response.data["data"]);
      }

    }catch(e){
      debugPrint('Error: $e');
    }
    return result;
  }

  Future<List<ArtCart>> getAllCartByUserEmail(String? userEmail) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'email':userEmail};
    List<ArtCart> listArtCart = [];
    List _list = [];
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getAllCartByUserEmail',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){

          ArtCart artCart = ArtCart.fromJson(a);
          listArtCart.add(artCart);
        }
      }

    }catch(e){
      debugPrint('Error: $e');
    }

    return listArtCart;
  }

  Future<void> addToCart(int paintingId,double money,String? email) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'paintingId':paintingId,'money':money,'email':email};
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.post(
        _baseUrl + 'addToCart',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        result = response.data["data"];
      }
      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    // return result;
  }

  Future<void> deleteCartById(int? id)async {

    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'id':id};
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.post(
        _baseUrl + 'deleteCartById',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        result = response.data["data"];
      }

      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
  }

  Future<ArtUser> recharge(String? email,String? addBalance)async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'email':email,'addBalance':addBalance};
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.post(
        _baseUrl + 'recharge',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        result = ArtUser.fromJson(response.data["data"]);
      }

      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    return result;
  }

  Future<bool> payment(int? totalMoney,String? email) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'totalMoney':totalMoney,'email':email};
    bool result = false;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.post(
        _baseUrl + 'payment',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        EasyLoading.showSuccess(response.data["message"]);
        result = response.data["data"];
        result = true;
      }
      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    return result;
  }

  Future<List<ArtOrder>> getAllOrderByUserEmail(String? userEmail) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'email':userEmail};
    List<ArtOrder> listArtOrder = [];
    List _list = [];
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getAllOrderByUserEmail',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        _list = response.data["data"];
        for(var a in _list){
          ArtOrder artOrder = ArtOrder.fromJson(a);
          listArtOrder.add(artOrder);
        }
      }
    }catch(e){
      debugPrint('Error: $e');
    }
    return listArtOrder;
  }

  Future<bool?> uploadImage(String? photoUrl,String? email) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'photoUrl':photoUrl,'email':email};
    bool result = false;
    var artUser;
    EasyLoading.showProgress(0.3, status: 'loading...');
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.post(
        _baseUrl + 'uploadImage',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        artUser = response.data["data"];
        result = true;
      }
      // print("/////////////////");
      // print(response.data);
    }catch(e){
      debugPrint('Error: $e');
    }
    return result;
  }

  Future<ArtUser?> getArtUserByUsername(String? username) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var data={'username':username};
    ArtUser? artUser;
    var result;
    try {
      _dio.options.headers["Authorization"] = prefs.getString("token");
      Response response = await _dio.get(
        _baseUrl + 'getArtUserByUsername',
        queryParameters: data,
      );
      if(response.data['status'] != 200){
        EasyLoading.showError(response.data['message']);
      }else{
        artUser = ArtUser.fromJson(response.data["data"]);
        // print(response.data["data"]);
        // print(artUser.photoUrl);
      }

    }catch(e){
      debugPrint('Error: $e');
    }
    return artUser;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }


//TODO: Add methods
}