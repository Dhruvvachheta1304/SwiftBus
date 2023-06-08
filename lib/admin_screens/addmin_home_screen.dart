import 'package:bluebus/common_pages/commmon_icon_page.dart';
import 'package:bluebus/common_pages/common_textform_field_page.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/Login_singup_page.dart';
import 'package:bluebus/screen_pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'floating_container.dart';

class admin_home_page extends StatefulWidget {
  const admin_home_page({Key? key}) : super(key: key);

  @override
  State<admin_home_page> createState() => _admin_home_pageState();
}

class _admin_home_pageState extends State<admin_home_page> {

  TextEditingController add_data= TextEditingController();
  TextEditingController upd_data= TextEditingController();
  final _fauth=FirebaseAuth.instance;
  final _fstore=FirebaseFirestore.instance;

  adddata() async {
    await _fstore.collection("Locations").add({
          "loc":add_data.text
        }).then((value) {
          Get.back();
        });
    }

  alret_dilog_fun() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: SizeConfig.screenHeight*0.5,
            color: Colors.transparent,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: SizeConfig.screenWidth,
                  child: TextFormField(
                    autofocus: false,
                    controller: add_data,
                    style: textstyle.pickupstyle,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: (){
                            add_data.clear();
                          },
                          child: Icon(Icons.close, size: 15, color: Colors.white,)),

                      contentPadding: EdgeInsets.only(top: 10),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,)
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,)
                      ),
                      hintText: "Enter Location",
                      hintStyle: textstyle.pickupstyle,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.050,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    InkWell(
                      onTap: (){
                        if(add_data.text==""||add_data.text==null){
                          Get.back();
                        }else{
                          adddata();
                          add_data.clear();
                        }

                      },
                          child: Container(
                            alignment: Alignment.center,
                            height: SizeConfig.screenHeight*0.080,
                            width: SizeConfig.screenWidth*0.25,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Text("Save", style: textstyle.pickupstyle,),
                          ),
                        ),





                    // cancle container:
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: SizeConfig.screenHeight*0.080,
                        width: SizeConfig.screenWidth*0.25,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text("Cancle", style: textstyle.pickupstyle,),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },);
  }

  delete_fun(String index) async {
    await _fstore.collection("Locations").doc(index.toString()).delete();
  }

  update_fun( funcindx) async {
    print("UPDATE: ${upd_data.text}");
    await _fstore.collection("Locations").doc(funcindx.toString()).update(
        {'loc': upd_data.text}).then((value){
          print("loc");
          Navigator.pop(context);
        });
  }


  updated_data_fun(index){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: SizeConfig.screenHeight*0.5,
            color: Colors.transparent,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: SizeConfig.screenWidth,
                  child: TextFormField(
                    autofocus: false,
                    controller: upd_data,
                    style: textstyle.pickupstyle,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: (){
                            add_data.clear();
                          },
                          child: Icon(Icons.close, size: 15, color: Colors.white,)),

                      contentPadding: EdgeInsets.only(top: 10),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,)
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,)
                      ),
                      hintText: add_data.text,
                      hintStyle: textstyle.pickupstyle,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.050,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                      onTap: (){
                        if(upd_data.text==null ||upd_data.text==""){
                         setState(() {
                           Navigator.pop(context);
                         });
                        }
                        else{
                          update_fun(index);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: SizeConfig.screenHeight*0.080,
                        width: SizeConfig.screenWidth*0.25,
                        color: Colors.blueGrey,
                        child: Text("update", style: textstyle.pickupstyle,),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: SizeConfig.screenHeight*0.080,
                        width: SizeConfig.screenWidth*0.25,
                        color: Colors.blueGrey,
                        child: Text("Cancle", style: textstyle.pickupstyle,),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        gradient: theemecolor
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Admin login", style: textstyle.pickupstyle,),
          centerTitle: true,
          actions:[InkWell(
              onTap: (){
                setState(() {
                  _fauth.signOut().then((value) async {
                    var share_pre= await SharedPreferences.getInstance();
                    share_pre.clear();
                  }).then((value) {
                    Get.to(login_page());
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Icon(Icons.logout, size: 22,color: Colors.black,),
                    Text("Logout", style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black),)
                  ],
                ),
              )),],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),


        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                //loactionns list :
                Row(
                  children: [
                    Text("Location List :", style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 30, color: Colors.white,)
                  ],
                ),

                // listview from firebase:
                StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                  stream: _fstore.collection("Locations").snapshots(),
                  builder:(context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: Colors.black,));
                    }else{
                      return  ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: SizeConfig.screenWidth*0.8,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width:SizeConfig.screenWidth*0.8,
                                      color: Colors.blueGrey,
                                      child: InkWell(
                                          onTap: (){
                                            updated_data_fun(snapshot.data!.docs[index].id.toString());
                                          },
                                          child: Text("${snapshot.data!.docs[index].get("loc").toString()}",style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  GestureDetector(
                                      onTap: (){
                                        delete_fun(snapshot.data!.docs[index].id.toString());
                                      },
                                      child: Icon(Icons.delete, size: 20, color: Colors.black.withOpacity(0.8),)),
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 5,);
                        },
                      );
                    }


                  },
                )
              ],
            ),
          ),
        ),

        floatingActionButton: InkWell(
          onTap: (){
            setState(() {
              alret_dilog_fun();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Add Data ", style: textstyle.travelstyle,),
              floating_container(),
            ],
          ),
        ),


      ),
    );
  }
}
