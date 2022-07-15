import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:thegreatkabab/const/colors.dart';
import 'package:thegreatkabab/const/common.dart';
import 'package:thegreatkabab/dasboard.dart';
import 'package:thegreatkabab/models/bookingstatusdata.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

import 'network/api_service.dart';


class BookingCancel extends StatefulWidget {
  BookingCancel(this.bookinglist);

  List<BookingList> bookinglist;

  @override
  State<StatefulWidget> createState() {
    return BookingCancelState();
  }
}


class BookingCancelState extends State<BookingCancel> {
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


  ////////////// Approve Dialog //////
  Future<Future<ConfirmAction?>> _updateDialogCancel(BuildContext context, String message) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Alert'),
          content:Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            FlatButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.pop(context);
                setState(() {

                });

              },
            )
          ],
        );
      },
    );
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
                             "Booking Details",maxLines: 2,textAlign: TextAlign.center,
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
                           Container(
                             child: MediaQuery.removePadding(
                               context: context,
                               removeTop: true,
                               child:SingleChildScrollView(
                                 physics: ScrollPhysics(),
                                 child: Column(
                                   children: <Widget>[
                                     // Text('Hey'),
                                     ListView.builder(
                                         physics: NeverScrollableScrollPhysics(),
                                         shrinkWrap: true,
                                         itemCount:widget.bookinglist.length,
                                         itemBuilder: _buildRow
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ),


                           SizedBox(
                             height:5.0,
                           ),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   _updateDialogCancel(context,"Do you really want to cancel booking?");
                                 },
                                 child: Container(
                                   margin: const EdgeInsets.all(5.0),
                                   padding: const EdgeInsets.all(3.0),
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black26),
                                     borderRadius: BorderRadius.circular(15.0),
                                   ),
                                   child:Padding(padding:const EdgeInsets.all(10.0),
                                     child: const Text("CANCEL BOOKING",textAlign: TextAlign.center,style: TextStyle(
                                       fontFamily: 'Poppins',
                                       fontWeight: FontWeight.w600,
                                       color: Colors.red,
                                       fontSize: 14.0,
                                     ),),

                                   ),

                                 ),






                               ),

                             ],
                           )




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
              flex: 1,
              child:Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${widget.bookinglist[index].seatPriceIdFk}",style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12.0,
                      ),),

                      Text("₹ ${widget.bookinglist[index].pricePerSeat}",textAlign: TextAlign.center,style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 11.0,
                      ),),
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colors.white),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('${widget.bookinglist[index].noOfSeats}',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 12.0,
                      ),),
                      Text('No. of Seats',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.black38,
                        fontSize: 12.0,
                      ),),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/orange_menu_icon.png",
                    width: 20.0,
                    height: 20.0,
                  ),
                  Text("₹ ${widget.bookinglist[index].finalPrice}",style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


}

