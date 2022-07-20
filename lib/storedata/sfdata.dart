import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SFData{


  Future<void> saveLoginDataToSF(BuildContext context,String userId,String userName,int loginas) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', userId);
    prefs.setString('UserName', userName);
    prefs.setInt('loginAs', loginas);
  }

/*
  Future<void> saveIsAddSchool(BuildContext context,int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('loginAs', loginas);
  }*/
  Future<int> getLogin(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getInt('loginAs')?? 0);
  }

  Future<String> getUserId(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('UserId')?? "");
  }
  Future<String> getUserName(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('UserName')?? "");
  }

  Future<void> saveHotelData(BuildContext context,String Name,String Logo,String Address,String PhoneNumber,String Email,double SeatDiscountInPercent,double ItemDiscountInPercent,double FirstTimeDiscountInPercent,String ContactPerson,int oneTimeBookingSeatNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Name', Name);
    prefs.setString('Logo', Logo);
    prefs.setString('Address', Address);
    prefs.setString('PhoneNumber', PhoneNumber);
    prefs.setString('Email', Email);
    prefs.setDouble('SeatDiscountInPercent', SeatDiscountInPercent);
    prefs.setDouble('ItemDiscountInPercent', ItemDiscountInPercent);
    prefs.setDouble('FirstTimeDiscountInPercent', FirstTimeDiscountInPercent);
    prefs.setString('ContactPerson', ContactPerson);
    prefs.setInt('OneTimeBookingSeatNo', oneTimeBookingSeatNo);
  }

  Future<int> getMaxSeat(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getInt('OneTimeBookingSeatNo')?? 0);
  }

  Future<double> getSeatDiscount(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getDouble('SeatDiscountInPercent')?? 0);
  }
  Future<String> getHotelName(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('Name')?? "");
  }
  Future<String> getLogo(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('Logo')?? "");
  }

  Future<String> getAddress(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('Address')?? "");
  }
  Future<String> getPhoneNumber(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('PhoneNumber')?? "");
  }
  Future<String> getEmail(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('Email')?? "");
  }
  Future<String> getContactPerson(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return (preferences.getString('ContactPerson')?? "");
  }
}