// To parse this JSON data, do
//
//     final seatAvailableData = seatAvailableDataFromJson(jsonString);

import 'dart:convert';

SeatAvailableData seatAvailableDataFromJson(String str) => SeatAvailableData.fromJson(json.decode(str));

String seatAvailableDataToJson(SeatAvailableData data) => json.encode(data.toJson());

class SeatAvailableData {
  SeatAvailableData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<SeatAvailableList> data;

  factory SeatAvailableData.fromJson(Map<String, dynamic> json) => SeatAvailableData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<SeatAvailableList>.from(json["Data"].map((x) => SeatAvailableList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SeatAvailableList {
  SeatAvailableList({
    required this.availableSeats,
  });

  String availableSeats;

  factory SeatAvailableList.fromJson(Map<String, dynamic> json) => SeatAvailableList(
    availableSeats: json["AvailableSeats"],
  );

  Map<String, dynamic> toJson() => {
    "AvailableSeats": availableSeats,
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
