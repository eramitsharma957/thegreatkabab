// To parse this JSON data, do
//
//     final slotsData = slotsDataFromJson(jsonString);

import 'dart:convert';

SlotsData slotsDataFromJson(String str) => SlotsData.fromJson(json.decode(str));

String slotsDataToJson(SlotsData data) => json.encode(data.toJson());

class SlotsData {
  SlotsData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<SlotListdata> data;

  factory SlotsData.fromJson(Map<String, dynamic> json) => SlotsData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<SlotListdata>.from(json["Data"].map((x) => SlotListdata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SlotListdata {
  SlotListdata({
    required this.slotsIdPk,
    required this.hotelIdFk,
    required this.foodTimingIdFk,
    required this.slotName,
    required this.slotTime,
  });

  int slotsIdPk;
  String hotelIdFk;
  int foodTimingIdFk;
  String slotName;
  String slotTime;

  factory SlotListdata.fromJson(Map<String, dynamic> json) => SlotListdata(
    slotsIdPk: json["SlotsID_PK"],
    hotelIdFk: json["HotelID_FK"],
    foodTimingIdFk: json["FoodTimingID_FK"],
    slotName: json["SlotName"],
    slotTime: json["SlotTime"],
  );

  Map<String, dynamic> toJson() => {
    "SlotsID_PK": slotsIdPk,
    "HotelID_FK": hotelIdFk,
    "FoodTimingID_FK": foodTimingIdFk,
    "SlotName": slotName,
    "SlotTime": slotTime,
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

