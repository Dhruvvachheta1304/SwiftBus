import 'package:bluebus/admin_screens/addmin_home_screen.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin_screens/bottom_navbar.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {

  final email=TextEditingController();
  late  final password=TextEditingController();
  final _fauth=FirebaseAuth.instance;

  String? pass;
  var x;



  pass_check_fun() async {
    if(pass== null || pass=="null"){
    x= Text("");
    }
    else if(pass != password.text){
    x =Text("wrong password");
    }
    else{
     x= Text("enter password first");
    }
  }


  //login function:
  login_fun() async {
    try{
      await _fauth.signInWithEmailAndPassword(email: email.text, password: password.text)
          .then((value) async {
              var share_pre= await SharedPreferences.getInstance();
              share_pre.setString("user_share_pre", email.text);
              email.text=="admin@gmail.com"?Get.to(bottm_navbar_page()):Get.to(home_page());

              pass = share_pre.getString("passwordx");



      })
          .onError(( FirebaseAuthException error, stackTrace){
              Fluttertoast.showToast(msg: error.message.toString());
            });
         } on FirebaseAuthException catch(error){
          Fluttertoast.showToast(msg: error.message.toString());
         }
  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        gradient: theemecolor
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text("Login", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 35),),
                SizedBox(height: SizeConfig.screenHeight*0.050,),
                //email textform field
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: email,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      labelText: "Email",
                      labelStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.5))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.5))
                      )
                    ),

                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.050,),
                //password textform field:
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: password,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Password",
                        labelStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.5))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.5))
                        )
                    ),

                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),

                //? Text("enter Password"): pass != password.text ?Text("wrong password"):Text("");
                SizedBox(height: SizeConfig.screenHeight*0.050,),





              //login button container:
                InkWell(
                  onTap: (){
                        setState(() {
                          login_fun();
                      });
                  },
                  child: Container(

                    alignment: Alignment.center,
                    height: SizeConfig.screenHeight*0.060,
                    width: SizeConfig.screenWidth*0.3,
                    decoration: BoxDecoration(
                      gradient: theemecolor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)
                    ),
                    child: Text("Login", style: GoogleFonts.poppins(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w600 ),),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.2,)

              ],
            ),
          ),
        ),

      ),


    );
  }
}
