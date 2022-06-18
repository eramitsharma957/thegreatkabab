import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:thegreatkabab/const/colors.dart';
import 'package:thegreatkabab/const/common.dart';
import 'package:thegreatkabab/dasboard.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

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

  @override
  void initState() {
    super.initState();
  }



  /* //////////////////  Get Class Link  //////////////////////
  Future<Null> signUp() async {
    // EasyLoading.show(status: 'Loading');
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .signUp(emailController.text,mobileController.text,nameController.text,passwordController.text)
        .then((result) {
      setState(() {
        // EasyLoading.dismiss();
        Navigator.of(context,rootNavigator: true).pop();
        if(result.loginId==0){
          commonAlert.messageAlertError(context,result.message,"Error");
        }else{
          sfdata.saveLoginDataToSF(context,result.loginId,nameController.text,"1",mobileController.text,emailController.text);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OTPSave(result)));

        }
      });
    }).catchError((error) {

      // EasyLoading.dismiss();
      print(error);
    });
  }
*/


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
              child: SingleChildScrollView(
                  child: Container(
                    color: colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(padding:const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                      Padding(padding:const EdgeInsets.all(10.0),
                      child: Text(
                        "Gallery",textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: colors.redthemenew,
                        ),
                      ),
                      ),

                            ],
                          ),

                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    restu=true;
                                    vegPic=false;
                                    nonvegPicfalse=false;
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
                                    restu=false;
                                    vegPic=true;
                                    nonvegPicfalse=false;
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
                                    restu=false;
                                    vegPic=false;
                                    nonvegPicfalse=true;
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
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                color: colors.purpals,
                                child: Text(
                                  "Gallery",textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: colors.redthemenew,
                                  ),
                                ),
                              ),
                            ],
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





}

