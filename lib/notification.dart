import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thegreatkabab/const/colors.dart';
import 'package:thegreatkabab/const/common.dart';
import 'package:thegreatkabab/dasboard.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

import 'models/notificatiodata.dart';
import 'network/api_service.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationsState();
  }
}


class NotificationsState extends State<Notifications> {
  static const colors= AppColors();
  TextStyle style = TextStyle(fontFamily: 'Poppins', fontSize: 14.0);
  bool _isObscure = true;
  CommonAction commonAlert= CommonAction();
  late File selectedFile;
  String  _filePath="";
  String  _fileName="";
  List<String> attachments = [];
  SFData sfdata= SFData();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  OtpFieldController otpController = OtpFieldController();
  var _Otp;
  bool _layoutlogin=true;
  var _UserID;
  List<Datum> datalist=<Datum>[];
  bool isLoader = false;

  @override
  void initState() {

    Future<String> getpay = sfdata.getUserId(context);
    getpay.then((data) {
      setState(() {
        _UserID=data;
      });
    },onError: (e) {
      print(e);
    });
    EasyLoading.show(status: 'Loading');
    notificationList();
    super.initState();
  }



   //////////////////  Get Class Link  //////////////////////
  Future<Null> notificationList() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getnotification(_UserID,colors.hotelId)
        .then((result) {
      setState(() {
        EasyLoading.dismiss();
        if(result.data.isNotEmpty){
          datalist=result.data.toList();
        }
      });
    }).catchError((error) {

       EasyLoading.dismiss();
      print(error);
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: colors.yellowlight,
    appBar: AppBar(
     title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        SizedBox(height: 28.0,)
        // Your widgets here
      ],
    ),
    /*leading: IconButton(
          // icon: Text('Back', textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed:() {
              Navigator.pop(context,'Yep!');
            }),*/
    elevation: 0,
    toolbarHeight: 85, // default is 56
    toolbarOpacity: 1.0,
    automaticallyImplyLeading: false,
    centerTitle: false,
    flexibleSpace: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/imgappbar.png'),
    fit: BoxFit.cover,
    ),
    ),
    ),
    backgroundColor: Colors.transparent,

    ),
      body: Builder(
        builder: (context) =>
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(padding:const EdgeInsets.all(10.0),
                       child: Column(
                         children: [
                           Text(
                             "Notification",maxLines: 2,textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'Poppins',
                               fontWeight: FontWeight.w600,
                               fontSize: 16.0,
                               color: colors.redtheme,
                             ),
                           ),

                           SizedBox(
                             height: 5.0,
                           ),
                           MediaQuery.removePadding(
                             context: context,
                             removeTop: true,
                             child:
                             datalist.isNotEmpty
                                 ? Container(
                               child: Expanded(
                                 child: ListView.builder(
                                   itemCount: datalist.length,
                                   itemBuilder: _buildRow,
                                 ),
                               ),
                             )
                                 : isLoader == true
                                 ? Container(
                                 margin: const EdgeInsets.all(180.0),
                                 child: const Center(child: CircularProgressIndicator()))
                                 : Container(
                               margin: const EdgeInsets.all(160.0),
                               child: Text("",style: TextStyle(color: colors.redtheme),),
                             ),
                           ),
                           SizedBox(
                             height: 150.0,
                           ),

                         ],
                       ),
                      ),


                  )


              ),
            ),
       ),



    );
  }



  Widget _buildRow(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(padding:const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 35,
                width: 35,
                child: Image.asset('assets/bell_icon.png'),
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              flex: 5,
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(commonAlert.dateFormateSQLServer(context,datalist[index].createdOn),
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                    Text(datalist[index].notificationsMessage,
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: Colors.black54, fontWeight: FontWeight.w400,fontSize: 13.0)),
                  ]) ,
            ),

            Expanded(
              flex: 1,
              child: SizedBox(
                height: 0,
                width: 0,
                child: Image.asset('assets/down_arrow.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

