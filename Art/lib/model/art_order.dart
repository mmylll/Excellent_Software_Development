import 'package:art/model/painting.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ArtOrder {
  int orderId;
  int paintingId;
  String userEmail;
  String orderTime;
  double money;
  Painting painting;

  ArtOrder({required this.orderId, required this.paintingId, required this.userEmail, required this.orderTime,
      required this.money, required this.painting});

  static ArtOrder fromJson(Map<String,dynamic> rootData){
    Map<String,dynamic> data = rootData;
    ArtOrder artOrder = ArtOrder(
      orderId:data["orderId"],
      paintingId: data["paintingId"],
      userEmail: data["userEmail"],
      orderTime: data["orderTime"],
      money: data["money"],
      painting: Painting.fromJson(data["painting"]),
    );
    return artOrder;

  }
}