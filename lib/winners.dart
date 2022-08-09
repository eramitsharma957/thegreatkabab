import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thegreatkabab/const/colors.dart';
import 'package:thegreatkabab/const/common.dart';
import 'package:thegreatkabab/dasboard.dart';
import 'package:thegreatkabab/gallery_view.dart';
import 'package:thegreatkabab/models/gallerydata.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

import 'models/winnerdata.dart';
import 'network/api_service.dart';

class Winners extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WinnersState();
  }
}


class WinnersState extends State<Winners> {
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
  bool _isVisible=false;
  bool restu=true,vegPic=false,nonvegPicfalse=false;
  List<WinnerList> list=<WinnerList>[];
  int _youareWinner=1;
  bool isLoader = false;
  var _UserID;
  var _Name="",_WinnerRank="",_title="",_descp="";


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
    winnersList();
    super.initState();
  }


  //////////////////  Class API //////////////////////
  Future<Null> winnersList() async {
    EasyLoading.show(status: 'loading...');
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getWinners(colors.hotelId)
        .then((result) {
      if(result.data.isNotEmpty){
        EasyLoading.dismiss();
        setState(() {
          list=result.data.toList();
          for(int i=0;i<list.length;i++){
            if(list[i].userTypeIdFk==int.parse(_UserID)){
              _isVisible=true;
               _Name=list[i].name;
              _WinnerRank=list[i].winnerRank;
              _title=list[i].title;
              _descp=list[i].description;
            }
          }
        });
      }else{
        EasyLoading.dismiss();
      }
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
        backgroundColor: colors.greylight,

      ),
      body: Builder(
        builder: (context) =>
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child:Container(
               color: Colors.white,
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
                child:  Column(
                  children: [
                    Visibility(
                      visible: _isVisible,
                      child:
                      Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child:  Container(
                            // height: 500,
                            width: double.infinity,
                            child:Center(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10.0),
                                  Text("Congratulations!!",
                                      textAlign: TextAlign.start,
                                      style: style.copyWith(color: colors.redtheme, fontWeight: FontWeight.w600,fontSize: 25.0)),

                                  Image.asset(
                                    "assets/win.png",
                                    height: 75.0,
                                    width: 75.0,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(_Name,
                                      textAlign: TextAlign.start,
                                      style: style.copyWith(color: colors.black, fontWeight: FontWeight.w600,fontSize: 28.0)),
                                  Text("You Won!! ${_WinnerRank} Prize",
                                      textAlign: TextAlign.start,
                                      style: style.copyWith(color: colors.black, fontWeight: FontWeight.w600,fontSize: 25.0)),
                                  Text(_title,
                                      textAlign: TextAlign.start,
                                      style: style.copyWith(color: colors.black, fontWeight: FontWeight.w600,fontSize: 20.0)),
                                  Text(_descp,
                                      textAlign: TextAlign.start,
                                      style: style.copyWith(color: colors.black, fontWeight: FontWeight.w600,fontSize: 15.0)),
                                  const SizedBox(height: 50.0),
                                ],
                              ),
                            ),
                          )
                      ),

                    ),
                    Visibility(
                      visible: _isVisible==false?true:false,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child:Expanded(
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: _buildRow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),









            ),
      ),



    );
  }





  Widget _buildRow(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: InkWell(
      //  onTap: () => onEdit(index),
        child: Column(
          children: <Widget>[
            Row(
              // mainAxisSize: MainAxisSize.max,
              //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      color: colors.redtheme,
                      width: 100.0,
                      height: 140.0,
                      child: Center(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/win.png",
                                width: 35.0,
                                height: 35.0,
                              ),
                              const SizedBox(height: 10.0),
                              RotatedBox(
                                quarterTurns: 4,
                                child: RichText(
                                  text: TextSpan(
                                    text:list[index].winnerRank,
                                    style: TextStyle(color: colors.white,fontSize: 18.0,fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              RotatedBox(
                                quarterTurns: 4,
                                child: RichText(
                                  text: TextSpan(
                                    text:"Winner",
                                    style: TextStyle(color: colors.white,fontSize: 14.0,fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )


                            ],
                          ),



                      )
                  ),

                  Expanded(
                      child:Padding(padding:const EdgeInsets.all(0.0),
                          child:  Container(
                              height: 140.0,
                              padding: const EdgeInsets.all(5.0),
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //  mainAxisAlignment: MainAxisAlignment.start,
                                  children:<Widget>[
                                    const SizedBox(height: 15.0),
                                    Text(list[index].name,
                                        maxLines: 2,
                                        //textAlign: TextAlign.justify,
                                        style: TextStyle(color: colors.black,fontSize: 15.0,fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 5.0),
                                    Text(list[index].title,
                                        maxLines: 2,
                                        //textAlign: TextAlign.justify,
                                        style: TextStyle(color: colors.black,fontSize: 14.0,fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 2.0),

                                    Text(list[index].description,
                                        // textAlign: TextAlign.justify,
                                        maxLines: 5,
                                        style:TextStyle(color: colors.greydark,fontSize: 11.0,fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700)),

                                  ])

                          )
                      ),



                  ),



                ])

          ],
        ),
      ),
    );
  }




/*
  Widget _gallerylayout(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      // scrollDirection: Axis.vertical,
      // physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.height / 700,
      children: List<Widget>.generate(gallerydata.length, (index) {
        return GridTile(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(8),
            child:InkWell(
              onTap: () => onEditGrid(index,context),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Image.network(
                      gallerydata[index].url,
                      width: double.infinity,
                      fit: BoxFit.cover),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child:Container(
                      alignment: Alignment.center,
                      width: 300,
                      color: Colors.black54,
                      padding: const EdgeInsets.all(5),
                      child:Row(
                        children: [
                          Text(
                            gallerydata[index].name==null?"":gallerydata[index].name,textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

              ),



            ),

          ),
        );
      }),
    );


  }

  Widget _buildPopupDialog(BuildContext context, String url) {
    return new AlertDialog(
      title: const Text('Hiiiii'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PhotoView(
            imageProvider: NetworkImage(
              "http://tgkfexpresspatna.com/images/Gallery/rest1.jpg",
            ),
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.8,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: true,
            // Set the background color to the "classic white"
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            *//*loadingChild: Center(
          child: CircularProgressIndicator(),
        ),*//*
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }*/


}

