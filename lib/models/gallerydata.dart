// To parse this JSON data, do
//
//     final galleryData = galleryDataFromJson(jsonString);

import 'dart:convert';

GalleryData galleryDataFromJson(String str) => GalleryData.fromJson(json.decode(str));

String galleryDataToJson(GalleryData data) => json.encode(data.toJson());

class GalleryData {
  GalleryData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<GalleryList> data;

  factory GalleryData.fromJson(Map<String, dynamic> json) => GalleryData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<GalleryList>.from(json["Data"].map((x) => GalleryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GalleryList {
  GalleryList({
    required this.photoGalleryIdPk,
    required this.name,
    required this.description,
    required this.url,
    required  this.photoGalleryCategoryIdPk,
    required this.catName,
    required this.catDescription,
  });

  int photoGalleryIdPk;
  String name;
  String description;
  String url;
  int photoGalleryCategoryIdPk;
  String catName;
  String catDescription;

  factory GalleryList.fromJson(Map<String, dynamic> json) => GalleryList(
    photoGalleryIdPk: json["PhotoGalleryID_PK"],
    name: json["Name"]??'',
    description: json["Description"]??'',
    url: json["URL"]??'',
    photoGalleryCategoryIdPk: json["PhotoGalleryCategoryID_PK"],
    catName: json["CatName"]??'',
    catDescription: json["CatDescription"]??'',
  );

  Map<String, dynamic> toJson() => {
    "PhotoGalleryID_PK": photoGalleryIdPk,
    "Name": name == null ? null : name,
    "Description": description,
    "URL": url == null ? null : url,
    "PhotoGalleryCategoryID_PK": photoGalleryCategoryIdPk,
    "CatName": catName,
    "CatDescription": catDescription,
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
