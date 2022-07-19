// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://api.tgkfexpresspatna.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<VerifyOtp> verifyOTP(mobileNo, otp, hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'MobileNo': mobileNo, 'OTP': otp};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyOtp>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/verifymobileOTP/${hotelId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyOtp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Logindata> signUp(mobile, hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Logindata>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GenerateMobileOTP/${mobile}/${hotelId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Logindata.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HotelData> hotelData(hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HotelData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'hotelbyid/${hotelId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HotelData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NotificationData> getnotification(mobileNo, hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'UsersID_FK': mobileNo, 'HotelID_FK': hotelId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'SeatOrderNotifications/SeatOrderNotificationsByUser',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NotificationData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingStatusData> getbookingStatus(hotelId, userID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID': hotelId, 'UserID': userID};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingStatusData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'seatorder/GetSeatBookingByUserandHotel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingStatusData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingCancelData> getbookingCancel(userID, seatOrderID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'UserID': userID, 'SeatOrderID': seatOrderID};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingCancelData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'seatorder/CancelBooking',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingCancelData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MenuData> getMenuLsit(hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MenuData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'MenuItemCategory/MenuItemCategoryByHotel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MenuData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BannerData> getbannerLsit(hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BannerData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'photogallery/GetPhotoGalleryOfOfferByHotel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BannerData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MenuDescData> getMenuDescription(hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MenuDescData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Menu/MenuItemsWithCategoryByHotel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MenuDescData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReviewData> getReviews(hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReviewData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'review/ReviewByHotel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReviewData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GalleryData> getGallery(hotelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GalleryData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'PhotoGallery/PhotoGalleryByHotel',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GalleryData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SlotsData> getTimeSlot(hotelId, foodTimingID_FK) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId, 'FoodTimingID_FK': foodTimingID_FK};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SlotsData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'slots/SlotsByHotelandFoodTiming',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SlotsData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SeatPrices> getTimeSlotPrice(
      hotelId, foodTimingID_FK, bookingDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'HotelID_FK': hotelId,
      'FoodTimingID_FK': foodTimingID_FK,
      'BookingDate': bookingDate
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SeatPrices>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'seatprice/SeatPriceByHotelFoodTimingDayName',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SeatPrices.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DiscountData> getDiscounts(hotelId, userID_FK) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'HotelID_FK': hotelId, 'UserID_FK': userID_FK};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DiscountData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Discounts/DiscountsByHotelandUser',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DiscountData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingResponse> savebooking(list) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = list.map((e) => e.toJson()).toList();
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'seatorder/SeatOrderCreateUpdate',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BookingResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> sendReview(hotelId, pperation, reviewID_PK, orderID,
      orderTypeID_FK, usersID_FK, message, replyMessage, userID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'HotelID_FK': hotelId,
      'Operation': pperation,
      'ReviewID_PK': reviewID_PK,
      'OrderID': orderID,
      'OrderTypeID_FK': orderTypeID_FK,
      'UsersID_FK': usersID_FK,
      'Message': message,
      'ReplyMessage': replyMessage,
      'UserID': userID
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'REview/ReviewCreateUpdate',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
