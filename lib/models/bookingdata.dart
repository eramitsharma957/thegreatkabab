// To parse this JSON data, do
//
//     final bookingData = bookingDataFromJson(jsonString);

import 'dart:convert';

List<BookingData> bookingDataFromJson(String str) => List<BookingData>.from(json.decode(str).map((x) => BookingData.fromJson(x)));

String bookingDataToJson(List<BookingData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingData {
  BookingData({
    required this.operation,
    required this.seatOrderIdPk,
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
    required this.userId,
    required this.userName,
  });

  String operation;
  int seatOrderIdPk;
  String hotelIdFk;
  String bookingDate;
  String bookingTime;
  String usersIdFk;
  int seatPriceIdFk;
  int noOfSeats;
  double pricePerSeat;
  double seatDiscount;
  String discountDetail;
  double couponDiscountInTotal;
  double finalPrice;
  String orderStatus;
  String userId;
  String userName;

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    operation: json["Operation"],
    seatOrderIdPk: json["SeatOrderID_PK"],
    hotelIdFk: json["HotelID_FK"],
    bookingDate: json["BookingDate"],
    bookingTime: json["BookingTime"],
    usersIdFk: json["UsersID_FK"],
    seatPriceIdFk: json["SeatPriceID_FK"],
    noOfSeats: json["NoOfSeats"],
    pricePerSeat: json["PricePerSeat"],
    seatDiscount: json["SeatDiscount"],
    discountDetail: json["DiscountDetail"],
    couponDiscountInTotal: json["CouponDiscountInTotal"],
    finalPrice: json["FinalPrice"],
    orderStatus: json["OrderStatus"],
    userId: json["UserID"],
    userName: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Operation": operation,
    "SeatOrderID_PK": seatOrderIdPk,
    "HotelID_FK": hotelIdFk,
    "BookingDate": bookingDate,
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
    "UserID": userId,
    "Name": userName,
  };
}
