// To parse this JSON data, do
//
//     final bookingCancelData = bookingCancelDataFromJson(jsonString);

import 'dart:convert';

BookingCancelData bookingCancelDataFromJson(String str) => BookingCancelData.fromJson(json.decode(str));

String bookingCancelDataToJson(BookingCancelData data) => json.encode(data.toJson());

class BookingCancelData {
  BookingCancelData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<Datum> data;

  factory BookingCancelData.fromJson(Map<String, dynamic> json) => BookingCancelData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.bookingStatus,
    required this.column1,
  });

  int bookingStatus;
  String column1;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookingStatus: json["BookingStatus"],
    column1: json["Column1"],
  );

  Map<String, dynamic> toJson() => {
    "BookingStatus": bookingStatus,
    "Column1": column1,
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
