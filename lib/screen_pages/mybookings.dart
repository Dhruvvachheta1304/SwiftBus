import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class mybookings extends StatefulWidget {
  const mybookings({Key? key}) : super(key: key);

  @override
  State<mybookings> createState() => _mybookingsState();
}

class _mybookingsState extends State<mybookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: SizeConfig.screenHeight*0.1,
                      width: SizeConfig.screenWidth*0.9,
                      color: Colors.black,
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
    );
  }
}
