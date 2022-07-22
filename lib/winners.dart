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
  bool _layoutlogin=true;
  bool restu=true,vegPic=false,nonvegPicfalse=false;
  List<GalleryList> gallerydata=<GalleryList>[];
  List<GalleryList> restdata=<GalleryList>[];
  List<GalleryList> vegdata=<GalleryList>[];
  List<GalleryList> nonvegdata=<GalleryList>[];
  int _youareWinner=0;

  @override
  void initState() {

    super.initState();
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
              child:SingleChildScrollView(
                child:Column(
                  children: [
                    Container(
                      color: colors.white,
                      height: 80.0,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding:const EdgeInsets.all(10.0),
                            child: Text( _youareWinner==0? "Winner announced on\n25 August 2022":"Whooo!! Congratulations!!"
                              ,textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: colors.green,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      color: _youareWinner==0?colors.white:colors.black,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(_youareWinner==0?
                              "assets/waiting.gif":"assets/congratulations.gif",
                                height: 400.0,
                                width: 300.0,
                              ),

                              Padding(padding:const EdgeInsets.all(10.0),
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( _youareWinner==0? "":"Mr/Mrs Amit Sharma\nYou Won dinner with us"
                                      ,textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                        color: Colors.lime,
                                      ),
                                    ),
                                  ]),

                              ),



                            ],
                          ),
                        ],
                      ),
                    ),

                  ]),




              ),




            ),
      ),



    );
  }


  onEditGrid(index,BuildContext context) async{
    print("GRIDDD");
    var rowData = gallerydata[index];
    // _buildPopupDialog(context,rowData.url);
    setState(() {
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GalleryViewPage(rowData.url)),
    );


  }

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
            /*loadingChild: Center(
          child: CircularProgressIndicator(),
        ),*/
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
  }


}

