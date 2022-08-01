import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:thegreatkabab/models/bannerdata.dart';
import 'package:thegreatkabab/models/bookingcanceldata.dart';
import 'package:thegreatkabab/models/bookingdata.dart';
import 'package:thegreatkabab/models/bookingresponse.dart';
import 'package:thegreatkabab/models/bookingstatusdata.dart';
import 'package:thegreatkabab/models/discountdata.dart';
import 'package:thegreatkabab/models/foodcategory.dart';
import 'package:thegreatkabab/models/gallerydata.dart';
import 'package:thegreatkabab/models/hoteldata.dart';
import 'dart:async';

import 'package:thegreatkabab/models/logindata.dart';
import 'package:thegreatkabab/models/menudata.dart';
import 'package:thegreatkabab/models/menudescdata.dart';
import 'package:thegreatkabab/models/notificatiodata.dart';
import 'package:thegreatkabab/models/reviewdata.dart';
import 'package:thegreatkabab/models/seatprices.dart';
import 'package:thegreatkabab/models/slotsdata.dart';
import 'package:thegreatkabab/models/verifyotp.dart';

part 'api_service.g.dart';

@RestApi(baseUrl:"http://api.tgkfexpresspatna.com/api/")


abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return ApiService(dio);
  }


  @POST("users/verifymobileOTP/{HotelId}")
  Future<VerifyOtp> verifyOTP(
      @Field("MobileNo") mobileNo,
      @Field("OTP") otp,
      @Path("HotelId") hotelId,
      );

  @GET("GenerateMobileOTP/{mobile}/{HotelId}")
  Future<Logindata> signUp(
      @Path("mobile") mobile,
      @Path("HotelId")hotelId,
      );

  @GET("hotelbyid/{HotelId}")
  Future<HotelData> hotelData(
      @Path("HotelId") hotelId,
      );

  @POST("SeatOrderNotifications/SeatOrderNotificationsByUser")
  Future<NotificationData> getnotification(
      @Field("UsersID_FK") mobileNo,
      @Field("HotelID_FK") hotelId,
      );

  @POST("SeatOrderNotificationsReadStatus/SeatOrderNotificationsReadStatusByUser")
  Future<NotificationData> updatenotification(
      @Field("Operation") operation,
      @Field("UsersID_FK") userid,
      @Field("SeatOrderNotificationsID_FK") id,
      );

  @POST("seatorder/GetSeatBookingByUserandHotel")
  Future<BookingStatusData> getbookingStatus(
      @Field("HotelID") hotelId,
      @Field("UserID") userID,
      );

  @POST("seatorder/CancelBooking")
  Future<BookingCancelData> getbookingCancel(
      @Field("UserID") userID,
      @Field("SeatOrderID") seatOrderID,
      );

  @POST("MenuItemCategory/MenuItemCategoryByHotel")
  Future<MenuData> getMenuLsit(
      @Field("HotelID_FK") hotelId,
      );

  @POST("photogallery/GetPhotoGalleryOfOfferByHotel")
  Future<BannerData> getbannerLsit(
      @Field("HotelID_FK") hotelId,
      );

  @POST("Menu/MenuItemsWithCategoryByHotel")
  Future<MenuDescData> getMenuDescription(
      @Field("HotelID_FK") hotelId,
      );

  @POST("review/ReviewByHotel")
  Future<ReviewData> getReviews(
      @Field("HotelID_FK") hotelId,
      );

  @POST("PhotoGallery/PhotoGalleryByHotel")
  Future<GalleryData> getGallery(
      @Field("HotelID_FK") hotelId,
      );

  @POST("slots/SlotsByHotelandFoodTiming")
  Future<SlotsData> getTimeSlot(
      @Field("HotelID_FK") hotelId,
      @Field("FoodTimingID_FK") foodTimingID_FK,
      );

  @POST("foodtiming/FoodTimingByHotel")
  Future<FoodCategory> getFoodCategory(
      @Field("HotelID_FK") hotelId,
      );

  @POST("seatprice/SeatPriceByHotelFoodTimingDayName")
  Future<SeatPrices> getTimeSlotPrice(
      @Field("HotelID_FK") hotelId,
      @Field("FoodTimingID_FK") foodTimingID_FK,
      @Field("BookingDate") bookingDate,
      );

  @POST("Discounts/DiscountsByHotelandUser")
  Future<DiscountData> getDiscounts(
      @Field("HotelID_FK") hotelId,
      @Field("UserID_FK") userID_FK,
      );


  @POST("seatorder/SeatOrderCreateUpdate")
  Future<BookingResponse> savebooking(@Body() List<BookingData> list);


  @POST("REview/ReviewCreateUpdate")
  Future<String> sendReview(
      @Field("HotelID_FK") hotelId,
      @Field("Operation") pperation,
      @Field("ReviewID_PK") reviewID_PK,
      @Field("OrderID") orderID,
      @Field("OrderTypeID_FK") orderTypeID_FK,
      @Field("UsersID_FK") usersID_FK,
      @Field("Message") message,
      @Field("ReplyMessage") replyMessage,
      @Field("UserID") userID,
      );



  /*@POST("UserSignup")
  Future<SignupData> signUp(
      @Field("Login_Email") email,
      @Field("Login_Mobile") mobile,
      @Field("Login_Name") name,
      @Field("Login_Password") password,
      );

  @POST("Login")
  Future<SignupData> login(
      @Field("Login_Mobile") mobile,
      @Field("Login_Password") password,
      );*/
}