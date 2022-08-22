import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class DioUtil{
  static Dio dio = Dio();
  static const serviceUrl = 'http://localhost:8080/';
  //请求部分
  static Future request(url,{formData})async{
    try{
      Response response;
      dio.options.contentType = ContentType.parse("application/json;charset=UTF-8") as String?;
      if(formData == null){
        response = await dio.post(serviceUrl+url);
      }else{
        response = await dio.post(serviceUrl+url,data:formData);
      }
      if(response.statusCode == 200){
        return response;
      }else{
        throw Exception("接口异常R");
      }
    }catch(e){
      print("网络出现错误${e}");
    }
  }
  //拦截器部分
  static tokenInter(){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, requestInterceptorHandler){
        dio.lock();
          Future<dynamic> future = Future(()async{
            SharedPreferences prefs =await SharedPreferences.getInstance();
            return prefs.getString("loginToken");
          });
          future.then((value){
            request.headers["Authorization"] = value;
          }).whenComplete(() => dio.unlock());
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
}