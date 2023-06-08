import 'dart:async';
import 'package:bluebus/main.dart';
import 'package:bluebus/screen_pages/Login_singup_page.dart';
import 'package:bluebus/Splash.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late final AnimationController _controller;
  String? umail;
  @override
  void initState() {
    super.initState();
    getumail();

    Timer(Duration(seconds:7), () {
      if( umail == "" || umail == null){
        Get.offAll(login_singup_page());
      }else{

     Get.offAll(home_page());
      }
      // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => login_singup_page(),));
    }
    );
  }
  getumail() async {
    SharedPreferences share_pre = await SharedPreferences.getInstance();

    setState(() {
      umail = share_pre.getString("user_share_pre");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFF00004f),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:h*0.5,
              width:w,
              child:Lottie.asset(
                'assets/image/136973-caravana-bus.json',
                // controller: _controller,
                // onLoaded: (composition) {
                //   _controller
                //     ..duration = composition.duration
                //     ..forward();
                // }

              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:60),
                  child: Text("SwiftBus",style: GoogleFonts.arimo(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}