// To parse this JSON data, do
//
//     final logindata = logindataFromJson(jsonString);

import 'dart:convert';

Logindata logindataFromJson(String str) => Logindata.fromJson(json.decode(str));

String logindataToJson(Logindata data) => json.encode(data.toJson());

class Logindata {
  Logindata({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<Datum> data;

  factory Logindata.fromJson(Map<String, dynamic> json) => Logindata(
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
    required  this.otp,
  });

  String otp;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
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
