// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) => NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) => json.encode(data.toJson());

class NotificationData {
  NotificationData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<Datum> data;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
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
    required this.seatOrderNotificationsIdPk,
    required this.seatOrderIdFk,
    required this.notificationsMessage,
    required this.readStatus,
    required this.createdOn,
  });

  int seatOrderNotificationsIdPk;
  int seatOrderIdFk;
  String notificationsMessage;
  int readStatus;
  DateTime createdOn;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    seatOrderNotificationsIdPk: json["SeatOrderNotificationsID_PK"],
    seatOrderIdFk: json["SeatOrderID"],
    notificationsMessage: json["NotificationsMessage"],
    readStatus: json["ReadStatus"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "SeatOrderNotificationsID_PK": seatOrderNotificationsIdPk,
    "SeatOrderID": seatOrderIdFk,
    "NotificationsMessage": notificationsMessage,
    "ReadStatus": readStatus,
    "CreatedOn": createdOn.toIso8601String(),
  };
}

class Header {
  Header({
    required  this.success,
    required  this.message,
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
