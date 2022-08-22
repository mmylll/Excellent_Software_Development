import 'package:art/model/artist.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Painting {
  int paintingId;
   int artistId;
   int galleryId;
   String ? imageFileName;
   String ? title;
   int shapeId;
   String ? museumLink;
   String ? accessionNumber;
   String ? copyrightText;
   String ? description;
   String ? excerpt;
   int yearOfWork;
   int? width;
   int? height;
   String? medium;
   double cost;
   double? MSRP;
   String? googleLink;
   String? googleDescription;
   String? wikiLink;
   int views;
   bool sell;

   Artist artist;



  // Painting({required this.paintingId, required this.artistId, required this.galleryId, this.imageFileName, required this.shapeId, this.museumLink, this.accessionNumber, this.copyrightText, this.excerpt, this.yearOfWork, this.width, this.height, this.medium, this.cost, this.MSRP, this.googleLink, this.googleDescription, this.wikiLink, required this.views, this.title, this.description});


  Painting({
    required this.paintingId,
    required this.artistId,
    required this.galleryId,
    this.imageFileName,
    this.title,
    required this.shapeId,
    this.museumLink,
    this.accessionNumber,
    this.copyrightText,
    this.description,
    this.excerpt,
    required this.yearOfWork,
    this.width,
    this.height,
    this.medium,
    required this.cost,
    this.MSRP,
    this.googleLink,
    this.googleDescription,
    this.wikiLink,
    required this.views,
    required this.sell,
    required this.artist
  });

  static Painting fromJson(Map<String,dynamic> rootData){
    Map<String,dynamic> data = rootData;
    Painting painting = Painting(paintingId: data["paintingId"],
        artistId: data["artistId"],
        galleryId: data["galleryId"],
        imageFileName: data["imageFileName"],
        title:data["title"],
        shapeId:data["shapeId"],
        museumLink:data["museumLink"],
        accessionNumber: data["accessionNumber"],
        copyrightText: data["copyrightText"],
        description: data["description"],
        excerpt: data["excerpt"],
        yearOfWork: data["yearOfWork"],
        width: data["width"],
        height: data["height"],
        medium: data["medium"],
        cost: data["cost"],
        MSRP: data["MSRP"],
        googleLink: data["googleLink"],
        googleDescription: data["googleDescription"],
        wikiLink: data["wikiLink"],
        views: data["views"],
        sell: data["sell"],
        artist: Artist.fromJson(data["artist"]),
    );
    return painting;

  }

  // Map<String, dynamic> toJson() {
  //    Map<String, dynamic> data = <String, dynamic>{};
  //   if(id != null){
  //     data['id'] = id;
  //   }
  //   data['username'] = username;
  //   data['password'] = password;
  //   data['email'] = email;
  //   data['address'] = address;
  //   data['phone'] = phone;
  //   return data;
  // }
}