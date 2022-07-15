// To parse this JSON data, do
//
//     final bookingStatusData = bookingStatusDataFromJson(jsonString);

import 'dart:convert';

BookingStatusData bookingStatusDataFromJson(String str) => BookingStatusData.fromJson(json.decode(str));

String bookingStatusDataToJson(BookingStatusData data) => json.encode(data.toJson());

class BookingStatusData {
  BookingStatusData({
    required this.header,
    required this.data,
  });

  List<Header> header;
  List<BookingList> data;

  factory BookingStatusData.fromJson(Map<String, dynamic> json) => BookingStatusData(
    header: List<Header>.from(json["Header"].map((x) => Header.fromJson(x))),
    data: List<BookingList>.from(json["Data"].map((x) => BookingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Header": List<dynamic>.from(header.map((x) => x.toJson())),
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BookingList {
  BookingList({
    required this.seatOrderIdPk,
    required this.seatOrderId,
    required this.hotelIdFk,
    required this.bookingDate,
    required this.bookingTime,
    required this.usersIdFk,
    required this.seatPriceIdFk,
    required this.noOfSeats,
    required this.pricePerSeat,
    required this.seatDiscount,
    required this.discountDetail,
    required this.couponDiscountInTotal,
    required this.finalPrice,
    required this.orderStatus,
    required this.updatedOn,
    required this.updatedBy,
    required this.createdOn,
    required this.createdBy,
  });

  int seatOrderIdPk;
  int seatOrderId;
  String hotelIdFk;
  DateTime bookingDate;
  String bookingTime;
  int usersIdFk;
  int seatPriceIdFk;
  int noOfSeats;
  double pricePerSeat;
  double seatDiscount;
  String discountDetail;
  double couponDiscountInTotal;
  double finalPrice;
  String orderStatus;
  DateTime updatedOn;
  int updatedBy;
  DateTime createdOn;
  int createdBy;

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
    seatOrderIdPk: json["SeatOrderID_PK"],
    seatOrderId: json["SeatOrderID"],
    hotelIdFk: json["HotelID_FK"],
    bookingDate: DateTime.parse(json["BookingDate"]),
    bookingTime: json["BookingTime"],
    usersIdFk: json["UsersID_FK"],
    seatPriceIdFk: json["SeatPriceID_FK"],
    noOfSeats: json["NoOfSeats"],
    pricePerSeat: json["PricePerSeat"],
    seatDiscount: json["SeatDiscount"],
    discountDetail: json["DiscountDetail"],
    couponDiscountInTotal: json["CouponDiscountInTotal"],
    finalPrice: json["FinalPrice"].toDouble(),
    orderStatus: json["OrderStatus"],
    updatedOn: DateTime.parse(json["UpdatedOn"]),
    updatedBy: json["UpdatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "SeatOrderID_PK": seatOrderIdPk,
    "SeatOrderID": seatOrderId,
    "HotelID_FK": hotelIdFk,
    "BookingDate": bookingDate.toIso8601String(),
    "BookingTime": bookingTime,
    "UsersID_FK": usersIdFk,
    "SeatPriceID_FK": seatPriceIdFk,
    "NoOfSeats": noOfSeats,
    "PricePerSeat": pricePerSeat,
    "SeatDiscount": seatDiscount,
    "DiscountDetail": discountDetail,
    "CouponDiscountInTotal": couponDiscountInTotal,
    "FinalPrice": finalPrice,
    "OrderStatus": orderStatus,
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
