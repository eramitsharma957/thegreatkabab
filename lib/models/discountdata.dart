// To parse this JSON data, do
//
//     final discountData = discountDataFromJson(jsonString);

import 'dart:convert';

DiscountData discountDataFromJson(String str) => DiscountData.fromJson(json.decode(str));

String discountDataToJson(DiscountData data) => json.encode(data.toJson());

class DiscountData {
  DiscountData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<DiscountList> data;

  factory DiscountData.fromJson(Map<String, dynamic> json) => DiscountData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<DiscountList>.from(json["Data"].map((x) => DiscountList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DiscountList {
  DiscountList({
    required this.discountsIdPk,
    required this.hotelIdFk,
    required this.discountName,
    required this.discount,
    required this.discountInPercent,
    required this.canBeClubbedWithOtherDiscount,
    required this.onlyOnceToAUser,
    required this.discountDescription,
    required this.tax,
    required this.discountStatus,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
  });

  int discountsIdPk;
  String hotelIdFk;
  String discountName;
  double discount;
  bool discountInPercent;
  bool canBeClubbedWithOtherDiscount;
  bool onlyOnceToAUser;
  String discountDescription;
  bool tax;
  String discountStatus;
  DateTime updatedOn;
  dynamic updatedBy;
  DateTime createdOn;
  dynamic createdBy;

  factory DiscountList.fromJson(Map<String, dynamic> json) => DiscountList(
    discountsIdPk: json["DiscountsID_PK"],
    hotelIdFk: json["HotelID_FK"],
    discountName: json["DiscountName"],
    discount: json["Discount"].toDouble(),
    discountInPercent: json["DiscountInPercent"],
    canBeClubbedWithOtherDiscount: json["CanBeClubbedWithOtherDiscount"],
    onlyOnceToAUser: json["OnlyOnceToAUser"],
    discountDescription: json["DiscountDescription"],
    tax: json["Tax"],
    discountStatus: json["DiscountStatus"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "DiscountsID_PK": discountsIdPk,
    "HotelID_FK": hotelIdFk,
    "DiscountName": discountName,
    "Discount": discount,
    "DiscountInPercent": discountInPercent,
    "CanBeClubbedWithOtherDiscount": canBeClubbedWithOtherDiscount,
    "OnlyOnceToAUser": onlyOnceToAUser,
    "DiscountDescription": discountDescription,
    "Tax": tax,
    "DiscountStatus": discountStatus,
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
