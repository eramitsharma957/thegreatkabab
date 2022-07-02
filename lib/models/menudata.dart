// To parse this JSON data, do
//
//     final menuData = menuDataFromJson(jsonString);

import 'dart:convert';

MenuData menuDataFromJson(String str) => MenuData.fromJson(json.decode(str));

String menuDataToJson(MenuData data) => json.encode(data.toJson());

class MenuData {
  MenuData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<Datamenu> data;

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<Datamenu>.from(json["Data"].map((x) => Datamenu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datamenu {
  Datamenu({
    required this.menuItemCategoryIdPk,
    required this.hotelIdFk,
    required this.name,
    required this.description,
    required this.iconImage,
    required this.updatedOn,
    this.updatedBy,
    required this.createdOn,
    this.createdBy,
  });

  int menuItemCategoryIdPk;
  String hotelIdFk;
  String name;
  String description;
  String iconImage;
  DateTime updatedOn;
  dynamic updatedBy;
  DateTime createdOn;
  dynamic createdBy;

  factory Datamenu.fromJson(Map<String, dynamic> json) => Datamenu(
    menuItemCategoryIdPk: json["MenuItemCategoryID_PK"],
    hotelIdFk: json["HotelID_FK"],
    name: json["Name"],
    description: json["Description"],
    iconImage: json["IconImage"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "MenuItemCategoryID_PK": menuItemCategoryIdPk,
    "HotelID_FK": hotelIdFk,
    "Name": name,
    "Description": description,
    "IconImage": iconImage,
    "UpdatedOn": updatedOn.toIso8601String(),
    "UpdatedBy": updatedBy,
    "CreatedOn": createdOn.toIso8601String(),
    "CreatedBy": createdBy,
  };
}

class Header {
  Header({
    required this.success,
    required  this.message,
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
