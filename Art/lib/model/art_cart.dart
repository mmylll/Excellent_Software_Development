import 'dart:html';

import 'package:art/model/painting.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ArtCart {
  int id;
  String userEmail;
  int paintingId;
  double money;
  bool valid;
  Painting painting;

  ArtCart({required this.id, required this.userEmail, required this.paintingId, required this.money, required this.valid,
      required this.painting});

  static ArtCart fromJson(Map<String,dynamic> rootData){
    Map<String,dynamic> data = rootData;
    ArtCart artCart = ArtCart(
      id:data["id"],
      userEmail: data["userEmail"],
      paintingId: data["paintingId"],
      money: data["money"],
      valid: data["valid"],
      painting: Painting.fromJson(data["painting"]),
    );
    return artCart;

  }
}