// To parse this JSON data, do
//
//     final menuDayData = menuDayDataFromJson(jsonString);

import 'dart:convert';

MenuDayData menuDayDataFromJson(String str) => MenuDayData.fromJson(json.decode(str));

String menuDayDataToJson(MenuDayData data) => json.encode(data.toJson());

class MenuDayData {
  MenuDayData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<MenuDayList> data;

  factory MenuDayData.fromJson(Map<String, dynamic> json) => MenuDayData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<MenuDayList>.from(json["Data"].map((x) => MenuDayList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MenuDayList {
  MenuDayList({
    required this.toDayMenuIdPk,
    required this.item,
    required this.itemPrice,
    required this.itemDescription,
    required this.menuItemCategoryIdPk,
    required this.name,
  });

  int toDayMenuIdPk;
  String item;
  double itemPrice;
  String itemDescription;
  int menuItemCategoryIdPk;
  String name;

  factory MenuDayList.fromJson(Map<String, dynamic> json) => MenuDayList(
    toDayMenuIdPk: json["ToDayMenuID_PK"],
    item: json["Item"],
    itemPrice: json["ItemPrice"],
    itemDescription: json["ItemDescription"],
    menuItemCategoryIdPk: json["MenuItemCategoryID_PK"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "ToDayMenuID_PK": toDayMenuIdPk,
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
