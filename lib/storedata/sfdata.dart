import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SFData{


  Future<void> saveLoginDataToSF(BuildContext context,int userId,String userName,String loginAs,String mobileNo,String emailId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('UserId', userId);
    prefs.setString('UserName', userName);
    prefs.setString('IsLogin', loginAs);
    prefs.setString("MobileNo", mobileNo);
    prefs.setString("EmailId", emailId);
  }

  Future<void> saveIsLogin(BuildContext context,String islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('IsLoginTrue', islogin);
  }


  Future<String> getMobile(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString("MobileNo")?? "0");
  }
  Future<String> getEmailId(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString("EmailId")?? "0");
  }

  Future<int> getUseId(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getInt("UserId")?? 0);
  }


  Future<String> getUsername(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString("UserName")?? "");
  }

  Future<String> getIslogin(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString("IsLogin")?? "0");
  }

  Future<String> getIsloginTrue(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString("IsLoginTrue")?? "0");
  }


  Future<void> saveIsPaid(BuildContext context,int pay) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('PAY', pay);
  }

  Future<int> getPaid(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getInt("PAY")?? 0);
  }



}