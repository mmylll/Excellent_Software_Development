import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ArtUser {
  int? id;
  String username;
  String password;
  String email;
  String address;
  String phone;
  double balance;
  String? photoUrl;

  ArtUser({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.address,
    required this.phone,
    required this.balance,
    this.photoUrl,
  });

  static ArtUser fromJson(Map<String,dynamic> rootData){
    ///解析第一层
    Map<String,dynamic> data = rootData;
    ///解析第二层
    ArtUser user = ArtUser(id: data["id"], username: data["username"],password: data["password"], email: data["email"], address: data["address"], phone: data["phone"],balance: data["balance"],photoUrl: data["photoUrl"]);
    return user;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id != null){
      data['id'] = id;
    }
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['balance'] = balance;
    data['photoUrl'] = photoUrl;
    return data;
  }


  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // Map<String, dynamic> toJson() => _$UserToJson(this);
}