// To parse this JSON data, do
//
//     final hotelData = hotelDataFromJson(jsonString);

import 'dart:convert';

HotelData hotelDataFromJson(String str) => HotelData.fromJson(json.decode(str));

String hotelDataToJson(HotelData data) => json.encode(data.toJson());

class HotelData {
  HotelData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<Datum> data;

  factory HotelData.fromJson(Map<String, dynamic> json) => HotelData(
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
    required this.hotelIdPk,
    required this.name,
    required this.logo,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.seatDiscountInPercent,
    required this.itemDiscountInPercent,
    required this.firstTimeDiscountInPercent,
    required this.contactPerson,
    required this.oneTimeBookingSeatNo,
  });

  String hotelIdPk;
  String name;
  String logo;
  String address;
  String phoneNumber;
  String email;
  double seatDiscountInPercent;
  double itemDiscountInPercent;
  double firstTimeDiscountInPercent;
  int oneTimeBookingSeatNo;
  String contactPerson;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    hotelIdPk: json["HotelID_PK"]??'',
    name: json["Name"]??'',
    logo: json["Logo"]??'',
    address: json["Address"]??'',
    phoneNumber: json["PhoneNumber"]??'',
    email: json["Email"]??'',
    seatDiscountInPercent: json["SeatDiscountInPercent"]??0.0,
    itemDiscountInPercent: json["ItemDiscountInPercent"]??0.0,
    firstTimeDiscountInPercent: json["FirstTimeDiscountInPercent"]??0.0,
    contactPerson: json["ContactPerson"]??'',
    oneTimeBookingSeatNo: json["OneTimeBookingSeatNo"]??'',
  );

  Map<String, dynamic> toJson() => {
    "HotelID_PK": hotelIdPk,
    "Name": name,
    "Logo": logo,
    "Address": address,
    "PhoneNumber": phoneNumber,
    "Email": email,
    "SeatDiscountInPercent": seatDiscountInPercent,
    "ItemDiscountInPercent": itemDiscountInPercent,
    "FirstTimeDiscountInPercent": firstTimeDiscountInPercent,
    "ContactPerson": contactPerson,
    "OneTimeBookingSeatNo": oneTimeBookingSeatNo,
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
    success: json["Success"]??'',
    message: json["Message"]??'',
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
