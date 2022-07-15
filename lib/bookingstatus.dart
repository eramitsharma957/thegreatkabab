import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:thegreatkabab/bookingcancel.dart';
import 'package:thegreatkabab/const/colors.dart';
import 'package:thegreatkabab/const/common.dart';
import 'package:thegreatkabab/dasboard.dart';
import 'package:thegreatkabab/models/bookingstatusdata.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

import 'network/api_service.dart';

class BookingStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingStatusState();
  }
}


class BookingStatusState extends State<BookingStatus> {
  static const colors= AppColors();
  TextStyle style = TextStyle(fontFamily: 'Poppins', fontSize: 14.0);
  bool _isObscure = true;
  bool isLoader = false;
  CommonAction commonAlert= CommonAction();
  late File selectedFile;
  var  _userID;
  String  _fileName="";
  List<String> attachments = [];
  SFData sfdata= SFData();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  List<BookingList> bookinglist =<BookingList> [];

  @override
  void initState() {
    Future<String> userid = sfdata.getUserId(context);
    userid.then((data) {
      setState(() {
        _userID=data;
        bookingList();
      });
    },onError: (e) {
      print(e);
    });

    super.initState();
  }



   //////////////////  Get Booking  //////////////////////
  Future<Null> bookingList() async {
     EasyLoading.show(status: 'Loading');
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getbookingStatus(colors.hotelId,_userID)
        .then((result) {
      setState(() {
         EasyLoading.dismiss();
        if(result.data.isNotEmpty){
          bookinglist=result.data.toList();
        }else{
          EasyLoading.dismiss();
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
                      child: Padding(padding:const EdgeInsets.all(10.0),
                       child: Column(
                         children: [
                           Text(
                             "Booking Status",maxLines: 2,textAlign: TextAlign.center,
                             style: TextStyle(
                               fontFamily: 'Poppins',
                               fontWeight: FontWeight.w600,
                               fontSize: 16.0,
                               color: colors.redtheme,
                             ),
                           ),
                           SizedBox(
                             height: 10.0,
                           ),
                           MediaQuery.removePadding(
                             context: context,
                             removeTop: true,
                             child:
                             bookinglist.isNotEmpty
                                 ? Container(
                               child: Expanded(
                                 child: ListView.builder(
                                   itemCount: bookinglist.length,
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
                             height: 50.0,
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
      child: Padding(padding:const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking ID- ${bookinglist[index].seatOrderId}",maxLines: 1,textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: colors.green,
                      ),
                    ),
                    Text(commonAlert.dateFormateSQLServer(context,bookinglist[index].bookingDate),
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: colors.redthemenew, fontWeight: FontWeight.w400,fontSize: 14.0)),

                    Text(commonAlert.dateFormate24to12hour(context,bookinglist[index].bookingTime),
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: colors.redthemenew, fontWeight: FontWeight.w400,fontSize: 12.0)),
                    Text("No. of Seats- ${bookinglist[index].noOfSeats}",
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: Colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                  ]) ,
            ),

            Expanded(
              flex: 1,
              child: SizedBox(
                height: 22,
                width: 22,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingCancel(bookinglist)),
                    );
                  },
                  child: Image.asset('assets/i_con.png'),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }


}

