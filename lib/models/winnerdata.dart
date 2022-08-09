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
    required this.userTypeIdFk,
    required this.name,
    required this.title,
    required this.description,
    required this.winnerRank,
  });

  int userTypeIdFk;
  String name;
  String title;
  String description;
  String winnerRank;

  factory WinnerList.fromJson(Map<String, dynamic> json) => WinnerList(
    userTypeIdFk: json["UsersID_PK"],
    name: json["name"],
    title: json["Title"],
    description: json["Description"],
    winnerRank: json["WinnerRank"],
  );

  Map<String, dynamic> toJson() => {
    "UsersID_PK": userTypeIdFk,
    "name": name,
    "Title": title,
    "Description": description,
    "WinnerRank": winnerRank,
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
