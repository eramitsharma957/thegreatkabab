// To parse this JSON data, do
//
//     final menuDescData = menuDescDataFromJson(jsonString);

import 'dart:convert';

MenuDescData menuDescDataFromJson(String str) => MenuDescData.fromJson(json.decode(str));

String menuDescDataToJson(MenuDescData data) => json.encode(data.toJson());

class MenuDescData {
  MenuDescData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<MenuDesc> data;

  factory MenuDescData.fromJson(Map<String, dynamic> json) => MenuDescData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<MenuDesc>.from(json["Data"].map((x) => MenuDesc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MenuDesc {
  MenuDesc({
    required this.menuIdPk,
    required this.item,
    required this.itemPrice,
    required this.itemDescription,
    required this.menuItemCategoryIdPk,
    required this.name,
  });

  int menuIdPk;
  String item;
  double itemPrice;
  String itemDescription;
  int menuItemCategoryIdPk;
  String name;

  factory MenuDesc.fromJson(Map<String, dynamic> json) => MenuDesc(
    menuIdPk: json["MenuID_PK"],
    item: json["Item"],
    itemPrice: json["ItemPrice"],
    itemDescription: json["ItemDescription"],
    menuItemCategoryIdPk: json["MenuItemCategoryID_PK"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "MenuID_PK": menuIdPk,
    "Item": item,
    "ItemPrice": itemPrice,
    "ItemDescription": itemDescription,
    "MenuItemCategoryID_PK": menuItemCategoryIdPk,
    "Name": name,
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
