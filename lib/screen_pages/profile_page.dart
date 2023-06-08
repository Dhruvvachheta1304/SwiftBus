import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common_pages/common_theem_colour_page.dart';

class profile_page extends StatefulWidget {
  const profile_page({Key? key}) : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  String? username;
  String? pno;
  String? email;
  String? img;

  getdata() async {
    DocumentSnapshot qs = await FirebaseFirestore.instance.collection('user data').doc(FirebaseAuth.instance.currentUser!.email.toString()).get();
    setState(() {
      username = qs.get('name');
      email = qs.get('email');
      pno = qs.get('number');
      img = qs.get('photo');
    });
    
  }
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final h= MediaQuery.of(context).size.height;
    final w= MediaQuery.of(context).size.width;

    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        gradient: theemecolor
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 20),),

          centerTitle: true,
          leading: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back, size: 25,color: Colors.black.withOpacity(0.7),)),
        ),

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: w,
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // image contaainer:
                    Container(
                      height: h*0.150,
                      width: w*0.285,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                        color: Colors.transparent,
                          image:DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(img.toString()),
                          )
                      ),
                    ),

                    // name text:
                    // Text("Name", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),),
                    Text(username.toString(), style: TextStyle(color:Colors.white54,fontSize: 20,fontWeight: FontWeight.w600),),

                    SizedBox(height: h*0.050,),

                    Container(
                      width: w*0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          //UserName row:
                          Row(
                            children: [
                              Text("UserName", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 18),),
                            ],
                          ),
                          Text(username.toString(),style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontSize: 16),),
                          SizedBox(height: h*0.030,),

                          //UserName container:
                          // Container(
                          //   height: h*0.050,
                          //   width: w*0.9,
                          //   alignment: FractionalOffset.centerLeft,
                          //   // color: Colors.grey,
                          //   child: TextFormField(
                          //     textAlign: TextAlign.start,
                          //     cursorColor: Colors.black,
                          //
                          //     decoration: InputDecoration(
                          //       suffixIcon: Icon(Icons.check, size: 25,color: Colors.white,),
                          //       hintText: username.toString(),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: Colors.black.withOpacity(0.5)
                          //         ),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.black
                          //         ),
                          //     ),
                          //     )
                          //   ),
                          // ),
                          // SizedBox(height: h*0.020,),

                          //Email row
                          Row(
                            children: [
                              Text("Email", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 18),),
                            ],
                          ),

                          //Email container:
                          Text(email.toString(),style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontSize: 16),),
                          SizedBox(height: h*0.030,),

                          //Phone Mo:
                          Row(
                            children: [
                              Text("Phone No", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 18),),
                            ],
                          ),
                          Text(pno.toString(),style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontSize: 16),),
                          SizedBox(height: h*0.030,),

                          //Phone No container:
                          // Container(
                          //   height: h*0.050,
                          //   width: w*0.9,
                          //   alignment: FractionalOffset.centerLeft,
                          //   // color: Colors.grey,
                          //   child: TextFormField(
                          //       textAlign: TextAlign.start,
                          //       cursorColor: Colors.black,
                          //
                          //       decoration: InputDecoration(
                          //         suffixIcon: Icon(Icons.check, size: 25,color: Colors.white,),
                          //         hintText: pno.toString(),
                          //         enabledBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black.withOpacity(0.3)
                          //           ),
                          //         ),
                          //         focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black
                          //           ),
                          //         ),
                          //       )
                          //   ),
                          // ),
                          // SizedBox(height: h*0.030,),




                          //Gender
                          // Row(
                          //   children: [
                          //     Text("Gender", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 18),),
                          //   ],
                          // ),

                          //Gender container:
                          // Container(
                          //   height: h*0.050,
                          //   width: w*0.9,
                          //   alignment: FractionalOffset.centerLeft,
                          //   // color: Colors.grey,
                          //   child: TextFormField(
                          //       textAlign: TextAlign.start,
                          //       cursorColor: Colors.black,
                          //
                          //       decoration: InputDecoration(
                          //         suffixIcon: Icon(Icons.check, size: 25,color: Colors.white,),
                          //         hintText: "Enter Gender",
                          //         enabledBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black.withOpacity(0.3)
                          //           ),
                          //         ),
                          //         focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black
                          //           ),
                          //         ),
                          //       )
                          //   ),
                          // ),
                          // SizedBox(height: h*0.030,),


                          //Date fo Birth
                          // Row(
                          //   children: [
                          //     Text("Date fo Birth", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 12),),
                          //   ],
                          // ),
                          //
                          //
                          // //Date fo Birth container:
                          // Container(
                          //   height: h*0.050,
                          //   width: w*0.9,
                          //   alignment: FractionalOffset.centerLeft,
                          //   // color: Colors.grey,
                          //   child: TextFormField(
                          //       textAlign: TextAlign.start,
                          //       cursorColor: Colors.black,
                          //
                          //       decoration: InputDecoration(
                          //         suffixIcon: Icon(Icons.check, size: 25,color: Colors.white,),
                          //         hintText: "Enter Date fo Birth",
                          //         enabledBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black.withOpacity(0.3)
                          //           ),
                          //         ),
                          //         focusedBorder: UnderlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black
                          //           ),
                          //         ),
                          //       )
                          //   ),
                          // ),
                          // SizedBox(height: h*0.030,),
                          //




                        ]
                            ,
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
