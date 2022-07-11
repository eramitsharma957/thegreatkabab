// To parse this JSON data, do
//
//     final seatPrices = seatPricesFromJson(jsonString);

import 'dart:convert';

SeatPrices seatPricesFromJson(String str) => SeatPrices.fromJson(json.decode(str));

String seatPricesToJson(SeatPrices data) => json.encode(data.toJson());

class SeatPrices {
  SeatPrices({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<PriceData> data;

  factory SeatPrices.fromJson(Map<String, dynamic> json) => SeatPrices(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<PriceData>.from(json["Data"].map((x) => PriceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PriceData {
  PriceData({
    required this.seatPriceIdPk,
    required this.seatTypeIdFk,
    required this.whoIsDiningIdFk,
    required this.foodTimingIdFk,
    required this.dayNamesIdFk,
    required this.price,
    required this.seatType,
  });

  int seatPriceIdPk;
  int seatTypeIdFk;
  int whoIsDiningIdFk;
  int foodTimingIdFk;
  int dayNamesIdFk;
  double price;
  String seatType;

  factory PriceData.fromJson(Map<String, dynamic> json) => PriceData(
    seatPriceIdPk: json["SeatPriceID_PK"],
    seatTypeIdFk: json["SeatTypeID_FK"],
    whoIsDiningIdFk: json["WhoIsDiningID_FK"],
    foodTimingIdFk: json["FoodTimingID_FK"],
    dayNamesIdFk: json["DayNamesID_FK"],
    price: json["Price"],
    seatType: json["SeatType"],
  );

  Map<String, dynamic> toJson() => {
    "SeatPriceID_PK": seatPriceIdPk,
    "SeatTypeID_FK": seatTypeIdFk,
    "WhoIsDiningID_FK": whoIsDiningIdFk,
    "FoodTimingID_FK": foodTimingIdFk,
    "DayNamesID_FK": dayNamesIdFk,
    "Price": price,
    "SeatType": seatType,
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
