import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../common_pages/common_theem_colour_page.dart';
import 'dart:ui';

class mybookings extends StatefulWidget {
  const mybookings({Key? key}) : super(key: key);

  @override
  State<mybookings> createState() => _mybookingsState();
}

class _mybookingsState extends State<mybookings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          gradient: theemecolor
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("My Bookings",style: TextStyle(color: Colors.black,fontSize: 18),),
        ),
        body:Container(

          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,

          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Tickets").where("usermail",isEqualTo: FirebaseAuth.instance.currentUser!.email.toString()).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              else{
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                        height: SizeConfig.screenHeight*0.38,
                        width: SizeConfig.screenWidth*0.9,
                        // color: Colors.blue,
                        child:Column(
                          children: [
                            Container(
                        padding: EdgeInsets.all(1.0),
                              height: SizeConfig.screenHeight*0.03,
                              color: Colors.black12,
                              child: Row(
                                children: [
                                  Text('Confirmed, ',style: TextStyle(fontSize: 18,color:Colors.black,fontWeight:FontWeight.bold ),),
                                  // Text('${snapshot.data!.docs[index].get('dateofbooking')}', style: TextStyle(fontSize: 12),),
                                  // Text('Travels Name:'+'${snapshot.data!.docs[index].get('travelName')}'),
                                ],
                              ),
                            ),
                           // Divider(
                           //   color: Colors.black54,
                           //   thickness: 2,
                           // ),

                            Container(
                              padding: EdgeInsets.all(1.0),
                              color: Colors.black12,
                              height: SizeConfig.screenHeight*0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ///from
                                  Container(
                                    height: SizeConfig.screenHeight*0.05,
                                    width: SizeConfig.screenWidth*0.4,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(
                                          "FROM",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text('${snapshot.data!.docs[index].get('from')}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ),
                                  ///icon
                                  Icon(Icons.arrow_circle_right_outlined,color: Colors.blueGrey,),
                                  //to
                                  Container(
                                    height: SizeConfig.screenHeight*0.05,
                                    width: SizeConfig.screenWidth*0.4,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(
                                          "TO",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text('${snapshot.data!.docs[index].get('to')}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Divider(
                            //   color: Colors.black54,
                            //   thickness: 1,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  height: SizeConfig.screenHeight*0.05,
                                  width: SizeConfig.screenWidth*0.4,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Text(
                                        "BOARDS",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text('${snapshot.data!.docs[index].get('arTime')}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: SizeConfig.screenHeight*0.05,
                                  width: SizeConfig.screenWidth*0.4,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children:  [
                                      Text(
                                        "BOARDING POINTS",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text('${snapshot.data!.docs[index].get('boardinpoint')}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///from
                                Container(
                                  height: SizeConfig.screenHeight*0.05,
                                  width: SizeConfig.screenWidth*0.4,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Text(
                                        "TRAVEL NAME",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text('${snapshot.data!.docs[index].get('travelName')}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///from
                                Container(
                                  height: SizeConfig.screenHeight*0.06,
                                  width: SizeConfig.screenWidth*0.4,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Text(
                                        "SEAT NO.",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text('${snapshot.data!.docs[index].get('seatno')}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///from
                                Container(
                                  height: SizeConfig.screenHeight*0.05,
                                  width: SizeConfig.screenWidth*0.4,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Text(
                                        "TICKET PRICE",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text('${snapshot.data!.docs[index].get('price')}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10,);
                  },
                );
              }

            },
          ),
        )
      ),
    );
  }
}
