import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Artist {
  int artistId;
  String? firstName;
  String lastName;
  String? nationality;
  String gender;
  int yearOfBirth;
  int? yearOfDeath;
  String details;
  String? artistLink;

  Artist(
      {required this.artistId,
      this.firstName,
      required this.lastName,
      this.nationality,
      required this.gender,
      required this.yearOfBirth,
      this.yearOfDeath,
      required this.details,
      this.artistLink});

  static Artist fromJson(Map<String, dynamic> rootData) {
    Map<String, dynamic> data = rootData;
    Artist artist = Artist(
        artistId: data["artistId"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        nationality: data["nationality"],
        gender: data["gender"],
        yearOfBirth: data["yearOfBirth"],
        yearOfDeath: data["yearOfDeath"],
        details: data["details"],
        artistLink: data["artistLink"]);
    return artist;
  }
}
