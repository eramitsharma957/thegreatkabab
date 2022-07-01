// To parse this JSON data, do
//
//     final verifyOtp = verifyOtpFromJson(jsonString);

import 'dart:convert';

VerifyOtp verifyOtpFromJson(String str) => VerifyOtp.fromJson(json.decode(str));

String verifyOtpToJson(VerifyOtp data) => json.encode(data.toJson());

class VerifyOtp {
  VerifyOtp({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<Datum> data;

  factory VerifyOtp.fromJson(Map<String, dynamic> json) => VerifyOtp(
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
    required this.successStatus,
    required  this.message,
    required this.userID,
  });

  String successStatus;
  String message;
  int userID;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    successStatus: json["SuccessStatus"],
    message: json["Message"],
    userID: json["UserID"]??0,
  );

  Map<String, dynamic> toJson() => {
    "SuccessStatus": successStatus,
    "Message": message,
    "UserID": userID,
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
