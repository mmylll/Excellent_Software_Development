import 'package:flutter/material.dart';

class SearchModel {
  final String name, review, userPic;
  final int id;
  final Color color;

  SearchModel({required this.name, required this.review, required this.userPic, required this.id, required this.color});
}

// List of demo
List<SearchModel> searchArts = [
  SearchModel(
    id: 1,
    name: "Ronald Thompson",
    review: review,
    userPic: "assets/images/people.png",
    color: Color(0xFFFFF3DD),
  ),
  SearchModel(
    id: 2,
    name: "Ronald Thompson",
    review: review,
    userPic: "assets/images/people.png",
    color: Color(0xFFD9FFFC),
  ),
  SearchModel(
    id: 3,
    name: "Ronald Thompson",
    review: review,
    userPic: "assets/images/people.png",
    color: Color(0xFFFFE0E0),
  ),
];

String review =
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore mag aliqua enim ad minim veniam.';
