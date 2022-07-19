// To parse this JSON data, do
//
//     final bannerData = bannerDataFromJson(jsonString);

import 'dart:convert';

BannerData bannerDataFromJson(String str) => BannerData.fromJson(json.decode(str));

String bannerDataToJson(BannerData data) => json.encode(data.toJson());

class BannerData {
  BannerData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<BannerList> data;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<BannerList>.from(json["Data"].map((x) => BannerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BannerList {
  BannerList({
    required  this.photoGalleryIdPk,
    required this.photoGalleryCategoryIdFk,
    required this.hotelIdFk,
    required this.name,
    required this.description,
    required this.url,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
  });

  int photoGalleryIdPk;
  int photoGalleryCategoryIdFk;
  String hotelIdFk;
  String name;
  dynamic description;
  String url;
  DateTime updatedOn;
  dynamic updatedBy;
  DateTime createdOn;
  dynamic createdBy;

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
    photoGalleryIdPk: json["PhotoGalleryID_PK"],
    photoGalleryCategoryIdFk: json["PhotoGalleryCategoryID_FK"],
    hotelIdFk: json["HotelID_FK"],
    name: json["Name"],
    description: json["Description"],
    url: json["URL"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "PhotoGalleryID_PK": photoGalleryIdPk,
    "PhotoGalleryCategoryID_FK": photoGalleryCategoryIdFk,
    "HotelID_FK": hotelIdFk,
    "Name": name,
    "Description": description,
    "URL": url,
    "UpdatedOn": updatedOn.toIso8601String(),
    "UpdatedBy": updatedBy,
    "CreatedOn": createdOn.toIso8601String(),
    "CreatedBy": createdBy,
  };
}

class Header {
  Header({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
