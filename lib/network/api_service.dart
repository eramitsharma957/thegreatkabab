import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:thegreatkabab/models/hoteldata.dart';
import 'dart:async';

import 'package:thegreatkabab/models/logindata.dart';
import 'package:thegreatkabab/models/menudata.dart';
import 'package:thegreatkabab/models/notificatiodata.dart';
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

  @POST("MenuItemCategory/MenuItemCategoryByHotel")
  Future<MenuData> getMenuLsit(
      @Field("HotelID_FK") hotelId,
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