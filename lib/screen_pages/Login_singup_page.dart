import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:bluebus/screen_pages/reset_password_page.dart';
import 'package:bluebus/screen_pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';


class login_singup_page extends StatefulWidget {
  const login_singup_page({Key? key}) : super(key: key);

  @override
  State<login_singup_page> createState() => _login_singup_pageState();
}

class _login_singup_pageState extends State<login_singup_page> {

  final email=TextEditingController();
  final password=TextEditingController();
  final _fauth=FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.blue.withOpacity(0.3),


          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height:MediaQuery.of(context).size.height*0.3,),

                  //Bus logo containerr:
                  Container(
                    height: MediaQuery.of(context).size.height*0.28 ,
                    width:MediaQuery.of(context).size.width*0.8 ,


                      child: Lottie.asset('assets/image/114462-bus-transport.json'),

                  ),


                  SizedBox(height: SizeConfig.screenHeight*0.16,),

                  // Text container :
                  Container(
                      height: 50,
                      width:MediaQuery.of(context).size.width*0.8 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text("Booking Your preffered bus ticket is just a few steps away", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 15, ))),
                  SizedBox(height: 10,),


                  //  container:
                  InkWell(
                    onTap: (){
                      Get.to(login_page());



                    },
                    child: Container(
                      height: 50,
                      width:MediaQuery.of(context).size.width*0.8 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text("Login", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold ,),),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.010,),


                  //Singup Container :
                  InkWell(
                    onTap: (){
                      Get.to(singup_page());
                    },
                    child: Container(
                      height: 50,
                      width:MediaQuery.of(context).size.width*0.8 ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white.withOpacity(0.5))
                      ),
                      alignment: Alignment.center,
                      child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold ,),),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.020,),
                  InkWell(
                      onTap: (){
                        Get.to(reset_passwordPage());
                      },
                      child: Text("Forgot password ?", style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),)),
                  SizedBox(height: SizeConfig.screenHeight*0.070,),
                ],
              ),
            ),
          )
      ),
    );
  }
}



