
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/common_variable/common_var.dart';
import 'package:bluebus/screen_pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class singup_page extends StatefulWidget {
  const singup_page({Key? key}) : super(key: key);

  @override
  State<singup_page> createState() => _singup_pageState();
}

class _singup_pageState extends State<singup_page> {

  final email=TextEditingController();
  final password=TextEditingController();
  final name= TextEditingController();
  final _fauth= FirebaseAuth.instance;





  singup_fun()  async {
    try{
        await  _fauth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) async {
          var share_prex= await SharedPreferences.getInstance();
          share_prex.setString("passwordx", password.text);

          Get.to(login_page());
          print("hello");
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


                // Spacer(),

                Text("SingUp", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 35),),
                SizedBox(height: SizeConfig.screenHeight*0.050,),


                // name textform field:
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: name,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Name",
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
                SizedBox(height: SizeConfig.screenHeight*0.030,),
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
                SizedBox(height: SizeConfig.screenHeight*0.030,),

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
                SizedBox(height: SizeConfig.screenHeight*0.050,),



                //   save button container:
                InkWell(
                  onTap: (){
                   singup_fun();
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
                    child: Text("Save", style: GoogleFonts.poppins(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w600 ),),
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
