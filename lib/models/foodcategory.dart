// To parse this JSON data, do
//
//     final foodCategory = foodCategoryFromJson(jsonString);

import 'dart:convert';

FoodCategory foodCategoryFromJson(String str) => FoodCategory.fromJson(json.decode(str));

String foodCategoryToJson(FoodCategory data) => json.encode(data.toJson());

class FoodCategory {
  FoodCategory({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<FoodTypeList> data;

  factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<FoodTypeList>.from(json["Data"].map((x) => FoodTypeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FoodTypeList {
  FoodTypeList({
    required this.foodTimingIdPk,
    required this.hotelIdFk,
    required this.fromTime,
    required this.toTime,
    required this.differenceInMinutes,
    required this.bookingCapacity,
    required this.name,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
  });

  int foodTimingIdPk;
  String hotelIdFk;
  String fromTime;
  String toTime;
  int differenceInMinutes;
  int bookingCapacity;
  String name;
  DateTime updatedOn;
  dynamic updatedBy;
  DateTime createdOn;
  dynamic createdBy;

  factory FoodTypeList.fromJson(Map<String, dynamic> json) => FoodTypeList(
    foodTimingIdPk: json["FoodTimingID_PK"],
    hotelIdFk: json["HotelID_FK"],
    fromTime: json["FromTime"],
    toTime: json["ToTime"],
    differenceInMinutes: json["DifferenceInMinutes"],
    bookingCapacity: json["BookingCapacity"],
    name: json["Name"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "FoodTimingID_PK": foodTimingIdPk,
    "HotelID_FK": hotelIdFk,
    "FromTime": fromTime,
    "ToTime": toTime,
    "DifferenceInMinutes": differenceInMinutes,
    "BookingCapacity": bookingCapacity,
    "Name": name,
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
