// To parse this JSON data, do
//
//     final winnerData = winnerDataFromJson(jsonString);

import 'dart:convert';

WinnerData winnerDataFromJson(String str) => WinnerData.fromJson(json.decode(str));

String winnerDataToJson(WinnerData data) => json.encode(data.toJson());

class WinnerData {
  WinnerData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<WinnerList> data;

  factory WinnerData.fromJson(Map<String, dynamic> json) => WinnerData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<WinnerList>.from(json["Data"].map((x) => WinnerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WinnerList {
  WinnerList({
    required this.winnerIdPk,
    required this.usersIdFk,
    required this.hotelIdFk,
    required this.title,
    required this.description,
    required this.winnerRank,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
  });

  int winnerIdPk;
  int usersIdFk;
  String hotelIdFk;
  String title;
  String description;
  String winnerRank;
  DateTime updatedOn;
  int updatedBy;
  DateTime createdOn;
  int createdBy;

  factory WinnerList.fromJson(Map<String, dynamic> json) => WinnerList(
    winnerIdPk: json["WinnerID_PK"],
    usersIdFk: json["UsersID_FK"],
    hotelIdFk: json["HotelID_FK"],
    title: json["Title"],
    description: json["Description"],
    winnerRank: json["WinnerRank"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "WinnerID_PK": winnerIdPk,
    "UsersID_FK": usersIdFk,
    "HotelID_FK": hotelIdFk,
    "Title": title,
    "Description": description,
    "WinnerRank": winnerRank,
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
