import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class reset_passwordPage extends StatefulWidget {
  const reset_passwordPage({Key? key}) : super(key: key);

  @override
  State<reset_passwordPage> createState() => _reset_passwordPageState();
}

class _reset_passwordPageState extends State<reset_passwordPage> {

  final email =TextEditingController();
  final _fauth= FirebaseAuth.instance;

  reset_password_fun() async {
    try{
      await _fauth.sendPasswordResetEmail(email: email.text).then((value) {
        Get.to(login_page());
      }).onError((FirebaseAuthException error, stackTrace) {
        Fluttertoast.showToast(msg: error.message.toString());
      });

    }on FirebaseAuthException catch(error){
      Fluttertoast.showToast(msg: error.message.toString());
    }
  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Container(
      height:SizeConfig.screenHeight ,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        gradient: theemecolor
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Reset Password", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600 ),),
          centerTitle: true,
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back, size: 25, color: Colors.black,)),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // text
                Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: Text("Here you can reset your password!", style: GoogleFonts.poppins(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w400),)),
                SizedBox(height: SizeConfig.screenHeight*0.040,),


                // Email textform fild
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: email,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Enter Email",
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


                //reset button
                InkWell(
                  onTap: (){
                    reset_password_fun();
                  },
                  child: Container(
                    height: SizeConfig.screenHeight*0.050,
                    width: SizeConfig.screenWidth*0.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                    ),
                    child: Text("Reset password", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),),
                  ),
                )
              ],


            ),
          ),
        ),
      ),
    );
  }
}
