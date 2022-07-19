import 'dart:io';
import 'dart:typed_data';
import 'package:cool_alert/cool_alert.dart';
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
  BookingCancel(this.bookingdata);

  BookingList bookingdata;

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
  double totalpricepfbooking=0.0;
  double totalfinalpricepfbooking=0.0;
  bool isCancel=false;
//  ScreenshotController screenshotController = ScreenshotController();
  late File _imageFile;
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
          for(int i=0;i<result.data.length;i++){
            if(result.data[i].seatOrderId==widget.bookingdata.seatOrderId){
              bookinglist.add(BookingList(seatOrderIdPk: result.data[i].seatPriceIdFk, seatOrderId:result.data[i].seatOrderId, hotelIdFk:result.data[i].hotelIdFk, bookingDate:result.data[i].bookingDate, bookingTime:result.data[i].bookingTime, usersIdFk:result.data[i].usersIdFk, seatPriceIdFk: result.data[i].seatPriceIdFk, noOfSeats: result.data[i].noOfSeats, pricePerSeat: result.data[i].pricePerSeat, seatDiscount: result.data[i].seatDiscount, discountDetail: result.data[i].discountDetail, couponDiscountInTotal: result.data[i].couponDiscountInTotal, finalPrice: result.data[i].finalPrice, orderStatus: result.data[i].orderStatus, updatedOn: result.data[i].updatedOn, updatedBy: result.data[i].updatedBy, createdOn: result.data[i].createdOn, createdBy: result.data[i].createdBy,seattimename: result.data[i].seattimename,foodtimeName: result.data[i].foodtimeName,totaltax:result.data[i].totaltax));
             // bookinglist=result.data[i];
              totalpricepfbooking+=result.data[i].finalPrice;
              if(result.data[i].orderStatus=="Booked"){
                isCancel=true;
              }else{
                isCancel=false;
              }
             // double tFinalpricepfbooking=totalpricepfbooking-result.data[i].couponDiscountInTotal;
             // totalfinalpricepfbooking=tFinalpricepfbooking+result.data[i].totaltax;
            }
          }



        }else{
          EasyLoading.dismiss();
        }
      });
    }).catchError((error) {
       EasyLoading.dismiss();
      print(error);
    });
  }

  //////////////////  Get Booking  //////////////////////
  Future<Null> bookingCancel() async {
    EasyLoading.show(status: 'Loading');
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getbookingCancel(_userID,widget.bookingdata.seatOrderId)
        .then((result) {
      setState(() {
        EasyLoading.dismiss();
        if(result.header.isNotEmpty){
          if(result.header[0].success=="True"){
            CoolAlert.show(
              barrierDismissible: false,
              context: context,
              type: CoolAlertType.success,
              backgroundColor: colors.redtheme,
              text: result.header[0].message,
              // autoCloseDuration: Duration(seconds: 2),
              onConfirmBtnTap: () {
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
              confirmBtnText: 'Done',
            );
          }else{
            CoolAlert.show(
              barrierDismissible: false,
              context: context,
              type: CoolAlertType.error,
              backgroundColor: colors.redtheme,
              text: "Process not completed.Please try again!",
              // autoCloseDuration: Duration(seconds: 2),
              onConfirmBtnTap: () {
                Navigator.pop(context);
              },
              confirmBtnText: 'Done',
            );
          }
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
                bookingCancel();

              },
            )
          ],
        );
      },
    );
  }


 /* _takeScreenshotandShare() async {
    //_imageFile=null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('booking', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }*/


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: colors.yellowlight,
      /*floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _takeScreenshotandShare();
        },
        tooltip: 'Increment',
        child: Icon(Icons.share),
      ),*/
     appBar: AppBar(
     title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pop(context, 'Yep!'),
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
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  elevation: 5,
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        "Booking ID- ${widget.bookingdata.seatOrderId}",maxLines: 1,textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                          color: colors.green,
                                        ),
                                      ),
                                      Text(
                                        "${widget.bookingdata.foodtimeName}",maxLines: 1,textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                          color: colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
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
                                                    itemCount:bookinglist.length,
                                                    itemBuilder: _buildRow
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(padding:const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total",maxLines: 1,textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: colors.black,
                                                    ),
                                                  ),

                                                  Text(
                                                    "(Tax included)",maxLines: 1,textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 9.0,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "₹ ${totalpricepfbooking.toStringAsFixed(2)}",maxLines: 1,textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.0,
                                                  color: colors.black,
                                                ),
                                              ),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),


                                ),


                                SizedBox(
                                  height:10.0,
                                ),

                                Visibility(
                                    visible: isCancel,
                                    child: Row(
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
        borderRadius: BorderRadius.circular(10.0),
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
                      Text("${bookinglist[index].seattimename}",style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12.0,
                      ),),

                      Text("₹ ${bookinglist[index].pricePerSeat}",textAlign: TextAlign.center,style: TextStyle(
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
                      Text('${bookinglist[index].noOfSeats}',style: TextStyle(
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
                  /*Image.asset("assets/orange_menu_icon.png",
                    width: 20.0,
                    height: 20.0,
                  ),*/
                  Text("₹ ${bookinglist[index].finalPrice.toStringAsFixed(2)}",style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 14.0,
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

