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
