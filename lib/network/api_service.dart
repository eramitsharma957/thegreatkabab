import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:async';

part 'api_service.g.dart';

@RestApi(baseUrl:"http://183.83.180.48/HRSystem_API/api/")
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


/*@POST("LoginApi/ConnectionConnector")
  Future<List<ConnectionConnector>> getconnection(
      @Field("BranchUrl") branchUrl,
      );

  @POST("LoginApi/UserAuthentication")
  Future<List<LoginResponse>> signUp(
      @Field("UserName") UserName,
      @Field("Password") Password,
      @Field("DisplayCode") DisplayCode,
      @Field("GroupCode") GroupCode,
      @Field("SocietyCode") SocietyCode,
      @Field("SchoolCode") SchoolCode,
      @Field("BranchCode") BranchCode,
      @Field("GSMID") GSMID,
      @Field("LastLoginWith") LastLoginWith,
      );*/

/*
  @POST("UserSignup")
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