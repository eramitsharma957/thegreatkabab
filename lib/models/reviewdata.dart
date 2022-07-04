// To parse this JSON data, do
//
//     final reviewData = reviewDataFromJson(jsonString);

import 'dart:convert';

ReviewData reviewDataFromJson(String str) => ReviewData.fromJson(json.decode(str));

String reviewDataToJson(ReviewData data) => json.encode(data.toJson());

class ReviewData {
  ReviewData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<ReviewList> data;

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<ReviewList>.from(json["Data"].map((x) => ReviewList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ReviewList {
  ReviewList({
    required this.reviewIdPk,
    required this.hotelIdFk,
    required this.orderId,
    required this.orderTypeIdFk,
    required this.usersIdFk,
    required this.message,
    required this.replyMessage,
    required this.approved,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
    required this.reviewByName,
  });

  int reviewIdPk;
  String hotelIdFk;
  int orderId;
  int orderTypeIdFk;
  int usersIdFk;
  String message;
  String replyMessage;
  bool approved;
  DateTime updatedOn;
  int updatedBy;
  DateTime createdOn;
  int createdBy;
  String reviewByName;

  factory ReviewList.fromJson(Map<String, dynamic> json) => ReviewList(
    reviewIdPk: json["ReviewID_PK"],
    hotelIdFk: json["HotelID_FK"],
    orderId: json["OrderID"],
    orderTypeIdFk: json["OrderTypeID_FK"],
    usersIdFk: json["UsersID_FK"],
    message: json["Message"],
    replyMessage: json["ReplyMessage"]??'',
    approved: json["Approved"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
    reviewByName: json["ReviewByName"]??'',
  );

  Map<String, dynamic> toJson() => {
    "ReviewID_PK": reviewIdPk,
    "HotelID_FK": hotelIdFk,
    "OrderID": orderId,
    "OrderTypeID_FK": orderTypeIdFk,
    "UsersID_FK": usersIdFk,
    "Message": message,
    "ReplyMessage": replyMessage,
    "Approved": approved,
    "UpdatedOn": updatedOn.toIso8601String(),
    "UpdatedBy": updatedBy,
    "CreatedOn": createdOn.toIso8601String(),
    "CreatedBy": createdBy,
    "ReviewByName": reviewByName,
  };
}

class Header {
  Header({
    required  this.success,
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
