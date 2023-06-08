import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
// import 'package:bluebus/screen_pages/razorpay%20demo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:bluebus/common_pages/commmon_icon_page.dart';
import 'package:bluebus/common_pages/common_list.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:bluebus/screen_pages/pdf/paymentdone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../common_variable/common_var.dart';

class ticket_page extends StatefulWidget {
  String? docid,docindx;

  ticket_page({required this.docid,required this.docindx});

  @override
  State<ticket_page> createState() => _ticket_pageState();
}

class _ticket_pageState extends State<ticket_page> {



  final GlobalKey _container = GlobalKey();

  bool isvisible=false;
  String? travname,from,to,deptime,arrtime,price,date,boardpoint,droppoint;
  getdata() async {
    print(widget.docindx.toString());

    CollectionReference travel_collection = FirebaseFirestore.instance
        .collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    setState(() {
      travname = _search_qeurysnapshot.docs[int.parse(
          widget.docindx.toString())]["travel_name"];
      from =
      _search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["from"];
      to =
      _search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["to"];
      // deptime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["depachar_time"];
      // arrtime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["arrived_time"];
      price =
      _search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["price"];
      date =
      _search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["Date"];
      for (int i = 0; i < _search_qeurysnapshot.docs[int.parse(
          widget.docindx.toString())]["boardingpoint"].length; i++) {
        boardpoint = _search_qeurysnapshot.docs[int.parse(
            widget.docindx.toString())]["boardingpoint"][int.parse(
            sfboardingpoint.toString())];
        deptime = _search_qeurysnapshot.docs[int.parse(
            widget.docindx.toString())]["boardtime"][int.parse(
            sfboardingpoint.toString())];
      }
      for (int i = 0; i < _search_qeurysnapshot.docs[int.parse(
          widget.docindx.toString())]["dropingpoint"].length; i++) {
        droppoint = _search_qeurysnapshot.docs[int.parse(
            widget.docindx.toString())]["dropingpoint"][int.parse(
            sfdropingpoint.toString())];
        arrtime = _search_qeurysnapshot.docs[int.parse(
            widget.docindx.toString())]["droptime"][int.parse(
            sfdropingpoint.toString())];
      }
    });
  }


  Future <void> _savepdf() async{
    try {
      RenderRepaintBoundary boundary = _container.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 10.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Create a PDF document
      final pdf = pw.Document();
      // Add a page with the image
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              dpi: 300,
              pw.MemoryImage(pngBytes),
            ),
          );
        },
      ));

      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save()
      );
    } catch (e) {
      print(e.toString());
}

  }
  var _razorpay =Razorpay();

    // print(uppseat);
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getdata();
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
    Get.to(paymentdone(docid: widget.docid, docindx: widget.docindx));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
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


      child:Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Select Your Payment", style: textstyle.upperstyle,),
          centerTitle: true,
          leading: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(180),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //Mahesagar Travelles:
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: Row(
                      children: [
                        iconstyle.bus_icon,
                        SizedBox(width: SizeConfig.screenWidth*0.050,),
                        Text(travname.toString(), style: passangerstyle.contactstyle,)
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.020,),

                  Container(
                      width: SizeConfig.screenWidth*0.9,
                      child: Text('Date: ${date.toString()}', style: passangerstyle.emailstyle,)),
                  SizedBox(height: SizeConfig.screenHeight*0.020,),

                  //ankleshawar:

                  Container(
                    width: SizeConfig.screenWidth*0.9,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: SizeConfig.screenHeight*0.040,
                                width:SizeConfig.screenWidth*0.35,
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(from.toString(), style: passangerstyle.ankleshawstyle,))),
                            Text(deptime.toString(), style: passangerstyle.emailstyle,),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_forward, size: 20,color: Colors.white.withOpacity(0.5),),
                            Text("2hr 54m", style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 10),),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: SizeConfig.screenHeight*0.040,
                                width:SizeConfig.screenWidth*0.35,
                                alignment: Alignment.centerLeft,
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(to.toString(), style: passangerstyle.ankleshawstyle,))),
                            Text(arrtime.toString(), style: passangerstyle.emailstyle,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.020,),



                  //pay 1800
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        InkWell(
                          onTap: (){
                            setState(() {
                              isvisible=!isvisible;
                            });
                          },
                          child: isvisible==false
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  width: SizeConfig.screenWidth*0.4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("View Ticket", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                                      Icon(Icons.keyboard_arrow_down, size: 30,color: Colors.white,)
                                    ],
                                  ),
                              )
                              :Container(
                                  padding: EdgeInsets.only(right: 10),
                                  width: SizeConfig.screenWidth*0.4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Hide Ticket", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),
                                      Icon(Icons.keyboard_arrow_up, size: 30,color: Colors.white,)
                                    ],
                                  ),
                                ),
                        ),

                        isvisible==false?Text("Pay:\₹${(commonlistindx.length+commonlistindx1.length)*int.parse(price.toString())}", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),):Text("", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),


                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight*0.020,),

                  //your ticket full container:


                ],
            ),
          ),
        ),


        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: isvisible==false
              ?Expanded(

                //payment container:
                child: Container(
                  width: SizeConfig.screenWidth,
                  color: Colors.white,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading:Icon(Icons.money_off) ,
                          title: Text("Google Pay", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),
                          trailing:Icon(Icons.send) ,
                        ),
                        ListTile(
                          leading:Icon(Icons.money_off,) ,
                          title: Text("Paytm Pay", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),
                          trailing:Icon(Icons.send, ) ,
                        ),
                        InkWell(
                          onTap: (){

                          },
                          child: ListTile(
                            leading:Icon(Icons.money_off, ) ,
                            title: Text("Phone Pay", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),
                            trailing:Icon(Icons.send) ,
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            //UPDATE LOWERSEAT LIST
                            List addlowseat=[];
                            List getlowerseat=[];
                            List updatelowerseat=[];
                            List getlowerseatsindx=[];

                            //UPDATE UPPERSEAT LIST
                            List adduppseat=[];
                            List updateupseat=[];
                            List getuppperseats=[];
                            List getuppperseatsindx=[];

                            addlowseat.clear();
                            getlowerseat.clear();
                            getlowerseatsindx.clear();
                            updatelowerseat.clear();

                            adduppseat.clear();
                            getuppperseats.clear();
                            updateupseat.clear();
                            getuppperseatsindx.clear();

                            commonlistindx.forEach((element) {
                              switch(element){
                                case "L-1":
                                  addlowseat.add(0);
                                  break;
                                case "L-2":
                                  addlowseat.add(1);
                                  break;
                                case "L-3":
                                  addlowseat.add(2);
                                  break;
                                case "L-4":
                                  addlowseat.add(3);
                                  break;
                                case "L-5":
                                  addlowseat.add(4);
                                  break;
                                case "L-6":
                                  addlowseat.add(5);
                                  break;
                                case "L-7":
                                  addlowseat.add(6);
                                  break;
                                case "L-8":
                                  addlowseat.add(7);
                                  break;
                                case "L-9":
                                  addlowseat.add(8);
                                  break;
                                case "L-10":
                                  addlowseat.add(9);
                                  break;
                                case "L-11":
                                  addlowseat.add(10);
                                  break;
                                case "L-12":
                                  addlowseat.add(11);
                                  break;
                                case "L-13":
                                  addlowseat.add(12);
                                  break;
                                case "L-14":
                                  addlowseat.add(13);
                                  break;
                                case "L-15":
                                  addlowseat.add(14);
                                  break;
                                case "L-16":
                                  addlowseat.add(15);
                                  break;
                                case "L-17":
                                  addlowseat.add(16);
                                  break;
                                case "L-18":
                                  addlowseat.add(17);
                                  break;
                                case "L-19":
                                  addlowseat.add(18);
                                  break;
                                case "L-20":
                                  addlowseat.add(19);
                                  break;
                                case "L-21":
                                  addlowseat.add(20);
                                  break;
                                case "L-22":
                                  addlowseat.add(21);
                                  break;
                              }
                            });

                            commonlistindx1.forEach((element) {
                              switch(element){
                                case "U-1":
                                  adduppseat.add(0);
                                  break;
                                case "U-2":
                                  adduppseat.add(1);
                                  break;
                                case "U-3":
                                  adduppseat.add(2);
                                  break;
                                case "U-4":
                                  adduppseat.add(3);
                                  break;
                                case "U-5":
                                  adduppseat.add(4);
                                  break;
                                case "U-6":
                                  adduppseat.add(5);
                                  break;
                                case "U-7":
                                  adduppseat.add(6);
                                  break;
                                case "U-8":
                                  adduppseat.add(7);
                                  break;
                                case "U-9":
                                  adduppseat.add(8);
                                  break;
                                case "U-10":
                                  adduppseat.add(9);
                                  break;
                                case "U-11":
                                  adduppseat.add(10);
                                  break;
                                case "U-12":
                                  adduppseat.add(11);
                                  break;
                                case "U-13":
                                  adduppseat.add(12);
                                  break;
                                case "U-14":
                                  adduppseat.add(13);
                                  break;
                                case "U-15":
                                  adduppseat.add(14);
                                  break;
                                case "U-16":
                                  adduppseat.add(15);
                                  break;
                                case "U-17":
                                  adduppseat.add(16);
                                  break;
                                case "U-18":
                                  adduppseat.add(17);
                                  break;
                                case "U-19":
                                  adduppseat.add(18);
                                  break;
                                case "U-20":
                                  adduppseat.add(19);
                                  break;
                                case "U-21":
                                  adduppseat.add(20);
                                  break;
                                case "U-22":
                                  adduppseat.add(21);
                                  break;
                              }
                            });

                            print(addlowseat);
                            print(adduppseat);
                            CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
                            QuerySnapshot _search_qeurysnapshot = await travel_collection.get();

                            //LOWER SEATS
                            for(int b=0;b<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["lowerseats"].length;b++){
                              getlowerseat.add(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["lowerseats"][b]);
                              if(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["lowerseats"][b]==true){
                                getlowerseatsindx.add(b);
                              }
                            }

                            for(int b=0;b<getlowerseat.length;b++){
                              if(addlowseat.contains(b)||getlowerseatsindx.contains(b)){
                                updatelowerseat.add(true);
                              }
                              else{
                                updatelowerseat.add(false);
                              }
                            }

                            //UPPER SEATS
                            for(int b=0;b<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["upperseats"].length;b++){
                              getuppperseats.add(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["upperseats"][b]);
                              if(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["upperseats"][b]==true){
                                getuppperseatsindx.add(b);
                              }
                            }
                            for(int b=0;b<getuppperseats.length;b++){
                              if(adduppseat.contains(b)||getuppperseatsindx.contains(b)){
                                updateupseat.add(true);
                              }
                              else{
                                updateupseat.add(false);
                              }
                            }
                            print(getuppperseats);
                            // print();

                            print(widget.docid);
                            List gender=[];
                            gender.clear();
                            for(int i=0;i<sfpassgender.length;i++){
                              if(sfpassgender[i]==1){
                                gender.add("Male");
                              }
                              else{
                                gender.add("Female");
                              }
                            }
                            print(sfpassseat);
                            // Get.to(paymentdone(docindx: widget.docindx,docid: widget.docid,));
                            QuerySnapshot snap=await FirebaseFirestore.instance.collection("Tickets").get();
                            FirebaseFirestore.instance.collection("Tickets").doc(snap.docs.length.toString()).set({
                              "id":snap.docs.length.toString(),
                              "usermail":FirebaseAuth.instance.currentUser!.email.toString(),
                              "dateofbooking":DateTime.now(),
                              "travelName":travname.toString(),
                              "from":from.toString(),
                              "to":to.toString(),
                              "deapTime":deptime.toString(),
                              "arTime":arrtime.toString(),
                              "bookeddat":date.toString(),
                              "boardinpoint":boardpoint.toString(),
                              "droppoint":droppoint.toString(),
                              "passcontact":sfpasscontactno.toString(),
                              "passmail":sfpassmail.toString(),
                              "passname":sfpassname,
                              "passage":sfpassage,
                              "passgender":gender,
                              "price":price.toString()*(commonlistindx1.length+commonlistindx.length),
                              "seatno":sfpassseat,
                            }).then((value) async {
                              await travel_collection.doc(widget.docid).update({
                                "upperseats":updateupseat
                              });
                              await travel_collection.doc(widget.docid).update({
                                "lowerseats":updatelowerseat
                              });
                              namecontroller.clear();
                              agecontroller1.clear();
                              lowseat.clear();
                              uppseat.clear();
                              allseats.clear();
                              tot.clear();
                              // Fluttertoast.showToast(msg: "Succesfully Booked");
                              // Get.offAll(());
                            });
                            var options = {
                              'key': "rzp_test_MbjZZSEhieeDhy",
                              // amount will be multiple of 100
                              'amount': (int.parse("${(commonlistindx.length+commonlistindx1.length)*int.parse(price.toString())}") * 100)
                                  .toString(), //So its pay 500
                              'name': 'joe goldberg',
                              'description': 'Demo',
                              'timeout': 300, // in seconds
                              'prefill': {
                                'contact': '9157299925',
                                'email': 'jgoldberg786@gmail.com'
                              }
                            };
                            _razorpay.open(options);

                          },
                          leading:Icon(Icons.attach_money),
                          title: Text("Razor Pay", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),
                          trailing:Icon(Icons.send) ,
                        ),

                      ],
                    ),
                  ) ,
                ),
          )

              //Your Ticket
              :Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: SizeConfig.screenWidth*0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    // border: Border.all(color: Colors.white)
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: RepaintBoundary(
                      key: _container,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Your Ticket
                          Container(
                            alignment: Alignment.center,
                            height: SizeConfig.screenHeight*0.050,
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                color: Colors.black
                            ),
                            child: Text("Your Ticket", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                          ),

                          Container(
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  // Mahesagar Travelles
                                  Container(
                                    width: SizeConfig.screenWidth*0.8,
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          color: Colors.transparent,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(travname.toString(), style: GoogleFonts.poppins(fontSize: 17,fontWeight:FontWeight.w400, color: Colors.black ),),
                                              Text("A/C Sleeper", style: GoogleFonts.poppins(fontSize: 14,fontWeight:FontWeight.w400, color: Colors.black.withOpacity(0.5) ),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.screenHeight*0.010,),


                                        //14:00:
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          color: Colors.transparent,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(deptime.toString(), style: ticketstyle.emailstyle,),
                                                  Container(
                                                    // height: SizeConfig.screenHeight*0.030,
                                                      width:SizeConfig.screenWidth*0.3,
                                                      alignment: Alignment.center,
                                                      color: Colors.transparent,
                                                      child: SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Text(boardpoint.toString(), style: ticketstyle.ankleshawstyle,))),

                                                ],
                                              ),
                                              Icon(Icons.arrow_forward, size: 15,color: Colors.black.withOpacity(0.5),),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [

                                                  Text(arrtime.toString(), style: ticketstyle.emailstyle,),
                                                  Container(
                                                    // height: SizeConfig.screenHeight*0.020,
                                                      width:SizeConfig.screenWidth*0.3,
                                                      alignment: Alignment.center,
                                                      color: Colors.transparent,
                                                      child: SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Text(droppoint.toString(), style: ticketstyle.ankleshawstyle,))),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        //orang containe:
                                        Container(
                                          width: SizeConfig.screenWidth*0.8,
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Spacer(),
                                              Container(
                                                height: SizeConfig.screenHeight*0.030,
                                                width: SizeConfig.screenWidth*0.030,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.deepOrange,
                                                    border: Border.all(color:Colors.orangeAccent, width: 2 )
                                                ),
                                              ),
                                              Container(
                                                height: SizeConfig.screenHeight*0.001,
                                                width: SizeConfig.screenWidth*0.46,
                                                color: Colors.black,
                                              ),
                                              Container(
                                                height: SizeConfig.screenHeight*0.030,
                                                width: SizeConfig.screenWidth*0.030,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue,
                                                    border: Border.all(color:Colors.lightBlueAccent, width: 2 )
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.screenHeight*0.010,),

                                        //date duration container;
                                        Container(

                                          width: SizeConfig.screenWidth*0.80,
                                          decoration:BoxDecoration(
                                              color: Colors.grey.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Date", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),),
                                                    Text(date.toString(), style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 13),),

                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Duration", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),),
                                                    Text("2hr 54min", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 13),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.screenHeight*0.010,),

                                        // /passanger container
                                        Container(
                                          width: SizeConfig.screenWidth*0.8,
                                          color: Colors.transparent,
                                          child: ListView.separated(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: sfpassname.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                width: SizeConfig.screenWidth,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Seat No", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),),
                                                        Container(
                                                            width: SizeConfig.screenWidth*0.1,
                                                            color: Colors.transparent,
                                                            child: SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child: Text(sfpassseat[index].toString(), style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 13),))),

                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Passanger", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),),
                                                        Container(
                                                            width: SizeConfig.screenWidth*0.2,
                                                            color: Colors.transparent,
                                                            child: SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child: Text(sfpassname[index].toString(), style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 13),))),

                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Age", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),),
                                                        Text(sfpassage[index].toString(), style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 13),),

                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Gender", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),),
                                                        Text(sfpassgender[index].toString()=="1"?"Male":"Female", style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 13),),

                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },

                                            separatorBuilder: (BuildContext context, int index) {
                                              return SizedBox(height: SizeConfig.screenHeight*0.010,);
                                            },

                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.screenHeight*0.010,),
                                      ],
                                    ),
                                  ),

                                  //black line container;
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: SizeConfig.screenHeight*0.030,
                                          width: SizeConfig.screenWidth*0.030,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: SizeConfig.screenWidth*0.001,
                                            color: Colors.blue,
                                          ),
                                        ) ,
                                        Container(
                                          height: SizeConfig.screenHeight*0.030,
                                          width: SizeConfig.screenWidth*0.030,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight*0.010,),


                                  Container(
                                    width: SizeConfig.screenWidth*0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("TOTAL PAYABLE", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),),
                                        Text("\₹${(commonlistindx.length+commonlistindx1.length)*int.parse(price.toString())}", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),)
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                          // Center(child: ElevatedButton(onPressed: (){
                          //   _savepdf();
                          // },
                          //     child: Text("Download",style: TextStyle(fontSize: 22),)))


                        ],
                      ),
                    ),
                  ),

                ),
          ),
        ),
      ),
    );
  }
}



