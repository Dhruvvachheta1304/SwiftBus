
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/common_variable/common_var.dart';
import 'package:bluebus/screen_pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class singup_page extends StatefulWidget {
  const singup_page({Key? key}) : super(key: key);

  @override
  State<singup_page> createState() => _singup_pageState();
}

class _singup_pageState extends State<singup_page> {

  final PhoneNum=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final name= TextEditingController();
  final _fauth= FirebaseAuth.instance;
  bool _isvisble = false;
  File?therapist_photo;





  singup_fun()  async {
    try{
        await  _fauth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) async {
          var share_prex= await SharedPreferences.getInstance();
          share_prex.setString("passwordx", password.text);

          Get.to(login_page());
          print("hello");
        }).onError((FirebaseAuthException error, stackTrace) {
          Fluttertoast.showToast(msg: error.message.toString());
        }).then((value) async{
          FirebaseStorage storage = FirebaseStorage.instance;
          Reference ref = storage.ref().child("${FirebaseAuth.instance.currentUser!.email.toString()}spa").child("images/${name.text}");
          UploadTask uploadTask = ref.putFile(therapist_photo!);
          await uploadTask.whenComplete(() => print('Image uploaded to Firebase Storage'));
          String spaURL = await ref.getDownloadURL();
          print('Download URL: $spaURL');



          FirebaseFirestore.instance.collection('user data').doc(FirebaseAuth.instance.currentUser!.email.toString()).set({
            'name':name.text,
            'number':PhoneNum.text,
            'email':email.text,
            'photo':spaURL.toString()
          });

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

              GestureDetector(
                onTap: (){
                  Future<void> profile_image() async {
                    XFile? xf = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (xf != null) {
                      setState(() {
                        therapist_photo=File(xf.path);
                      });
                    }
                  }
                  profile_image();

                },
                child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  image: DecorationImage(image: therapist_photo!=null ? FileImage(therapist_photo!):AssetImage("assets/image/addimg.png")as ImageProvider),
                  borderRadius: BorderRadius.circular(140),
                  color: Colors.transparent,
                ),
            ),
              ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),



            // Spacer(),

                Text("SignUp", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 35),),
                SizedBox(height: SizeConfig.screenHeight*0.040,),
                ///phone numbewr
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: PhoneNum,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,color: Colors.white,),
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: "Number",
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


                // name textform field:
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: name,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded,color: Colors.white,),
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
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: email,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.white,),
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
                    obscureText: _isvisble,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: password,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,color: Colors.white,),
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
                        ),
                      suffixIcon:_isvisble  ? IconButton(
                          color: Colors.white,
                          focusColor: Colors.transparent,
                          onPressed: (){
                            setState(() {
                              _isvisble = !_isvisble;
                            });
                          }, icon: Icon(Icons.visibility)):
                      IconButton(
                          focusColor: Colors.transparent,
                          color: Colors.white,
                          onPressed: (){
                            setState(() {
                              _isvisble = !_isvisble;
                            });

                          }, icon: Icon(Icons.visibility_off)),
                      hintStyle: TextStyle(color: Colors.white),
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
                    child: Text("Save", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600 ),),
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
