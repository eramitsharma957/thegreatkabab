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

class GalleryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GalleryViewState();
  }
}


class GalleryViewState extends State<GalleryView> {
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

  List<GalleryList> topCategories=<GalleryList>[];
  int _photoGalleryCategoryIdPk=0;
  int selectedIndex=0;
 // final mediaQuery = MediaQuery.of(context);

  @override
  void initState() {
    gallery();
    super.initState();
  }




  //////////////////  Get Menus Description //////////////////////
  Future<Null> gallery() async {
    gallerydata=[];
    EasyLoading.show(status: 'Loading');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getGallery(colors.hotelId)
        .then((result) {
      setState(() {
        EasyLoading.dismiss();
        if(result.data.isNotEmpty){
          gallerydata=result.data.toList();
          var seen = Set<String>();
          topCategories = gallerydata.where((item) => seen.add(item.catName.toString())).toList();

          for(int i=0;i<gallerydata.length;i++){
            if(topCategories[0].photoGalleryCategoryIdPk==gallerydata[i].photoGalleryCategoryIdPk){
              vegdata.add(GalleryList(photoGalleryIdPk: result.data[i].photoGalleryIdPk, name: result.data[i].name, description: result.data[i].description, url: result.data[i].url, photoGalleryCategoryIdPk: result.data[i].photoGalleryCategoryIdPk, catName: result.data[i].catName, catDescription: result.data[i].catDescription));
            }
          }
          /*for(int i=0;i<result.data.length;i++){
            if(result.data[i].photoGalleryCategoryIdPk==1){
              vegdata.add(GalleryList(photoGalleryIdPk: result.data[i].photoGalleryIdPk, name: result.data[i].name, description: result.data[i].description, url: result.data[i].url, photoGalleryCategoryIdPk: result.data[i].photoGalleryCategoryIdPk, catName: result.data[i].catName, catDescription: result.data[i].catDescription));
            }
            if(result.data[i].photoGalleryCategoryIdPk==2){
              nonvegdata.add(GalleryList(photoGalleryIdPk: result.data[i].photoGalleryIdPk, name: result.data[i].name, description: result.data[i].description, url: result.data[i].url, photoGalleryCategoryIdPk: result.data[i].photoGalleryCategoryIdPk, catName: result.data[i].catName, catDescription: result.data[i].catDescription));
            }
            if(result.data[i].photoGalleryCategoryIdPk==3){
              restdata.add(GalleryList(photoGalleryIdPk: result.data[i].photoGalleryIdPk, name: result.data[i].name, description: result.data[i].description, url: result.data[i].url, photoGalleryCategoryIdPk: result.data[i].photoGalleryCategoryIdPk, catName: result.data[i].catName, catDescription: result.data[i].catDescription));
            }
          }
          gallerydata=restdata.toList();*/
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
        backgroundColor: colors.greylight,

      ),
      body: Builder(
        builder: (context) =>
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child:SingleChildScrollView(
               child:Container(
                   color: colors.white,
                   child:  Column(
                     children: [
                       SizedBox(height: 5),
                       Text(
                         "Gallery",maxLines: 2,textAlign: TextAlign.center,
                         style: TextStyle(
                           fontFamily: 'Poppins',
                           fontWeight: FontWeight.w600,
                           fontSize: 16.0,
                           color: colors.redthemenew,
                         ),
                       ),

                       SizedBox(height: 10),

                       SizedBox(
                         height: 45.0,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Expanded(
                               child: ListView.builder(
                                 shrinkWrap: true,
                                 scrollDirection: Axis.horizontal,
                                 itemCount: topCategories.length,
                                 itemBuilder: _buildRowOptions,
                               ),
                             ),
                           ],
                         ),
                       ),

                       /*Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 gallerydata=[];
                                 restu=true;
                                 vegPic=false;
                                 nonvegPicfalse=false;
                                 gallerydata=restdata.toList();
                               });


                             },
                             child:Container(
                               margin: EdgeInsets.all(0.0),
                               decoration: BoxDecoration(
                                 color:restu==true?colors.purpals:colors.greylight,
                                 borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(10.0),
                                   topLeft: Radius.circular(10.0),
                                 ),
                               ),
                               child: Padding(padding:const EdgeInsets.all(10.0),
                                 child:  Text(
                                   "Restaurant",maxLines: 2,textAlign: TextAlign.center,
                                   style: TextStyle(
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w500,
                                     fontSize: 14.0,
                                     color: restu==true?colors.redthemenew:colors.grey,
                                   ),
                                 ),
                               ),



                             ),
                           ),
                           SizedBox(width: 5.0,),
                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 gallerydata=[];
                                 restu=false;
                                 vegPic=true;
                                 nonvegPicfalse=false;
                                 gallerydata=vegdata.toList();
                               });

                             },
                             child:Container(
                               margin: EdgeInsets.all(0.0),
                               decoration: BoxDecoration(
                                 color: vegPic==true?colors.purpals:colors.greylight,
                                 borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(10.0),
                                   topLeft: Radius.circular(10.0),
                                 ),
                               ),
                               child: Padding(padding:const EdgeInsets.all(10.0),
                                 child:  Text(
                                   "Veg Food",maxLines: 2,textAlign: TextAlign.center,
                                   style: TextStyle(
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w500,
                                     fontSize: 14.0,
                                     color: vegPic==true?colors.redthemenew:colors.grey,
                                   ),
                                 ),
                               ),



                             ),
                           ),
                           SizedBox(width: 5.0,),
                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 gallerydata=[];
                                 restu=false;
                                 vegPic=false;
                                 nonvegPicfalse=true;
                                 gallerydata=nonvegdata.toList();
                               });

                             },
                             child: Container(
                               margin: EdgeInsets.all(0.0),
                               decoration: BoxDecoration(
                                 color: nonvegPicfalse==true?colors.purpals:colors.greylight,
                                 borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(10.0),
                                   topLeft: Radius.circular(10.0),
                                 ),
                               ),
                               child: Padding(padding:const EdgeInsets.all(10.0),
                                 child:  Text(
                                   "Non Veg Food",maxLines: 2,textAlign: TextAlign.center,
                                   style: TextStyle(
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w500,
                                     fontSize: 14.0,
                                     color: nonvegPicfalse==true?colors.redthemenew:colors.grey,
                                   ),
                                 ),
                               ),



                             ),
                           ),


                         ],
                       ),*/

                       Container(
                         // width: MediaQuery.of(context).size.width,
                         // height: MediaQuery.of(context).size.height,
                         color: colors.purpals,
                         child: Column(
                           children: [
                             _gallerylayout(context),
                           ],
                         ),
                       ),
                     ],
                   ),
               ),
              ),
            ),
      ),

    );
  }


  onEditGrid(index,BuildContext context) async{
    var rowData = vegdata[index];
   //_buildPopupDialog(context,rowData.url);
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
      children: List<Widget>.generate(vegdata.length, (index) {
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
                      vegdata[index].url,
                      width: double.infinity,
                      fit: BoxFit.cover),
                  Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width/2,
                          // width: 180,
                          color: Colors.black54,
                          padding: const EdgeInsets.all(5),
                          child:IntrinsicWidth(
                            child:Text(
                              vegdata[index].name==null?"":vegdata[index].name,textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
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


  onEditClass(index){
    var rowData = topCategories[index];
    setState(() {
      vegdata=[];
      selectedIndex = index;
      _photoGalleryCategoryIdPk=rowData.photoGalleryCategoryIdPk;
      for(int i=0;i<gallerydata.length;i++){
        if(_photoGalleryCategoryIdPk==gallerydata[i].photoGalleryCategoryIdPk){
          vegdata.add(GalleryList(photoGalleryIdPk: gallerydata[i].photoGalleryIdPk, name:gallerydata[i].name, description:gallerydata[i].description, url:gallerydata[i].url, photoGalleryCategoryIdPk:gallerydata[i].photoGalleryCategoryIdPk, catName:gallerydata[i].catName, catDescription:gallerydata[i].catDescription));
        }
      }
    });
  }

  Widget _buildRowOptions(BuildContext context, int index){
    return  Padding(padding:const EdgeInsets.symmetric(vertical: 0.0,horizontal: 2.0),
        child: GestureDetector(
          onTap: (){
            setState(() {
              onEditClass(index);
            });
          },
          child:Container(
            width: 100.0,
            margin: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color:selectedIndex==index?colors.purpals:colors.greylight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            child: Padding(padding:const EdgeInsets.all(10.0),
              child:  Text(
                topCategories[index].catName,maxLines: 2,textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: selectedIndex==index?colors.redthemenew:colors.grey,
                ),
              ),
            ),



          ),
        ),

    );


  }


}

