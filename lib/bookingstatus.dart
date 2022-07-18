import 'dart:convert';
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
  List<BookingList> uniquebookinglist =<BookingList> [];

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
          var seen = Set<String>();
          uniquebookinglist = bookinglist.where((student) => seen.add(student.seatOrderId.toString())).toList();
         // print("not ${uniquebookinglist.length}");
         // print("not ${jsonEncode(uniquebookinglist)}");
          /*for ( var item in bookinglist){
            // ignore: iterable_contains_unrelated_type
            if (!(uniquebookinglist.contains(item.seatOrderId))){
                 uniquebookinglist.add(BookingList(seatOrderIdPk: item.seatPriceIdFk, seatOrderId:item.seatOrderId, hotelIdFk:item.hotelIdFk, bookingDate:item.bookingDate, bookingTime:item.bookingTime, usersIdFk:item.usersIdFk, seatPriceIdFk: item.seatPriceIdFk, noOfSeats: item.noOfSeats, pricePerSeat: item.pricePerSeat, seatDiscount: item.seatDiscount, discountDetail: item.discountDetail, couponDiscountInTotal: item.couponDiscountInTotal, finalPrice: item.finalPrice, orderStatus: item.orderStatus, updatedOn: item.updatedOn, updatedBy: item.updatedBy, createdOn: item.createdOn, createdBy: item.createdBy));
              print("not ${uniquebookinglist.length}");
            }else{
              print("Yes");
            }
          }*/


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
                                   itemCount: uniquebookinglist.length,
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


  _navigateAndDisplaySelection(BuildContext context, BookingList bookingCancel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingCancel(bookingCancel)),
    );
    bookingList();
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
                      "Booking ID- ${uniquebookinglist[index].seatOrderId}",maxLines: 1,textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: colors.green,
                      ),
                    ),
                    Text(commonAlert.dateFormateSQLServer(context,uniquebookinglist[index].bookingDate),
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: colors.redthemenew, fontWeight: FontWeight.w400,fontSize: 14.0)),

                    Text(commonAlert.dateFormate24to12hour(context,uniquebookinglist[index].bookingTime),
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: colors.redthemenew, fontWeight: FontWeight.w400,fontSize: 12.0)),
                    Text("${uniquebookinglist[index].foodtimeName}",
                        textAlign: TextAlign.start,
                        style: style.copyWith(color: Colors.black, fontWeight: FontWeight.w400,fontSize: 14.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${uniquebookinglist[index].orderStatus}",
                            textAlign: TextAlign.end,
                            style: style.copyWith(color:uniquebookinglist[index].orderStatus=="Cancelled"?Colors.red:Colors.green,fontWeight: FontWeight.w400,fontSize: 10.0)),
                      ],
                    ),

                  ]) ,
            ),

            Expanded(
              flex: 1,
              child: SizedBox(
                height: 22,
                width: 22,
                child: GestureDetector(
                  onTap: (){
                    _navigateAndDisplaySelection(context,uniquebookinglist[index]);
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingCancel(uniquebookinglist[index])),
                    );*/
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

