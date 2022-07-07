import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:thegreatkabab/dasboard.dart';
import 'package:thegreatkabab/network/api_service.dart';
import 'package:thegreatkabab/signup.dart';
import 'package:thegreatkabab/storedata/sfdata.dart';

import 'const/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Phoenix(
      child: MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  static const colors= AppColors();
  final navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child:MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: colors.redthemenew,
          accentColor: colors.redthemenew,
          textSelectionColor:colors.redthemenew ,
          accentColorBrightness: Brightness.dark,
          buttonColor: colors.redthemenew,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: colors.redthemenew,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: colors.redthemenew,
              ),
            ),
          ),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        builder: EasyLoading.init(),
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;
  static const colors= AppColors();
  SFData sfdata= SFData();
  var _IsLogin;

  @override
  void initState() {
    super.initState();
    Future<int> getpay = sfdata.getLogin(context);
    getpay.then((data) {
      setState(() {
        _IsLogin=data;
      });
    },onError: (e) {
      print(e);
    });
    /*animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();*/
    startTime();
  }


  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    if(_IsLogin==1){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    }


    /*Future<String> authToken = sfdata.getIsloginTrue(context);
    authToken.then((data) {
      if (data == '1') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      }
    },onError: (e) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUp()));
      print(e);
    });*/




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),





      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
