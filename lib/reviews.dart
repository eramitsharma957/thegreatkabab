import 'dart:io';
import 'package:flutter/cupertino.dart';
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
import 'package:thegreatkabab/models/reviewdata.dart';
import 'package:thegreatkabab/network/api_service.dart';
import 'package:thegreatkabab/postreviews.dart';
import 'package:thegreatkabab/signup.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';


enum ConfirmAction { Cancel, Accept}

class Reviews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReviewsState();
  }
}


class ReviewsState extends State<Reviews> {
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
  List<ReviewList> reviewdata=<ReviewList>[];
  bool isLoader=false;
  int _islogin=0;


  @override
  void initState() {
    Future<int> ad = sfdata.getLogin(context);
    ad.then((data) {
      setState(() {
        _islogin=data;
      });
    },onError: (e) {
      print(e);
    });
    EasyLoading.show(status: 'Loading');
    reviews();
    super.initState();
  }



  //////////////////  Get Menus Description //////////////////////
  Future<Null> reviews() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getReviews(colors.hotelId)
        .then((result) {
      setState(() {
        EasyLoading.dismiss();
        if(result.data.isNotEmpty){
          reviewdata=result.data.toList();
        }
      });
    }).catchError((error) {
      EasyLoading.dismiss();
      print(error);
    });
  }



//////////////Logout dialog//////
  Future<Future<ConfirmAction?>> _asyncloginAlert(BuildContext context) async {

    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Login'),
          content: const Text(
              'Login for post review'),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            FlatButton(
              child: const Text('Yes',style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Accept);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => SignUp()),
                  ModalRoute.withName('/'),
                );
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
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: colors.redtheme,
      onPressed: () {
        setState(() {
          if(_islogin==1){
            Navigator.push(context,MaterialPageRoute(builder: (context) => PostReviews()),
            );
          }else{
            _asyncloginAlert(context);
          }
        });
      },
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
                             "Reviews",maxLines: 2,textAlign: TextAlign.center,
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
                             reviewdata.isNotEmpty
                                 ? Container(
                               child: Expanded(
                                 child: ListView.builder(
                                   itemCount: reviewdata.length,
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
    return Stack(
        //alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey)
                      ),
                      margin: const EdgeInsets.all(10),
                      child:Padding(padding:const EdgeInsets.all(25.0),
                        child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget>[
                              Row(
                                children: [
                                  Text(reviewdata[index].message,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 10.0,
                              ),
                              Text(reviewdata[index].reviewByName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                            ]),

                      ),
                    )
                ),

            Positioned(
              left: 30.0,
              top: 0,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 110.0,
                    decoration: BoxDecoration(
                        color:colors.purpals ,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: colors.redthemenew)

                    ),
                    child: Padding(padding:const EdgeInsets.all(4.0),
                      child: Text(commonAlert.dateFormateSQLServer(context,reviewdata[index].createdOn),textAlign: TextAlign.center,style:TextStyle(color: colors.redthemenew,fontSize: 14.0,fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600)),
                    ),



                  )
              ),

            ),
            Positioned(
              right: 30.0,
              top: 0,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 50.0,
                    child: Padding(padding:const EdgeInsets.all(1.0),
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/quote.png'),
                      ),
                    ),



                  )
              ),

            ),

          ]);
  }


}

