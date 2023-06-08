import 'package:bluebus/common_pages/commmon_icon_page.dart';
import 'package:bluebus/common_pages/common_list.dart';
import 'package:bluebus/common_pages/common_textform_field_page.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/ticket_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common_variable/common_var.dart';

class passanger_details_page extends StatefulWidget {
  String? docid,docindx;


  passanger_details_page({required this.docid,required this.docindx});

  @override
  State<passanger_details_page> createState() => _passanger_details_pageState();
}

class _passanger_details_pageState extends State<passanger_details_page> {

  // String?gender;
  // String? travname,from,to,deptime,arrtime,price;
  // List<TextEditingController> namecontroller = [];
  // List<TextEditingController> agecontroller1 = [];
  // List tot=[];
  // List lowseat=[];
  // List uppseat=[];
  // List allseats=[];

  getdata() async {

    print(widget.docindx.toString());
    namecontroller.clear();
    // passmail.clear();
    // passcont.clear();
    agecontroller1.clear();
    lowseat.clear();
    uppseat.clear();
    allseats.clear();
    tot.clear();

    CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    setState(() {
      travname=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["travel_name"];
      from=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["from"];
      to=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["to"];
      deptime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["depachar_time"];
      arrtime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["arrived_time"];
      price=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["price"];
      for(int a=0;a<commonlistindx1.length+commonlistindx.length;a++){
        namecontroller.add(TextEditingController());
        agecontroller1.add(TextEditingController());
        tot.add(a);
      }
      for(int a=0;a<commonlistindx.length;a++){
        lowseat.add(commonlistindx[a]);
        allseats.add(commonlistindx[a]);
      }
      for(int a=0;a<commonlistindx1.length;a++){
        uppseat.add(commonlistindx1[a]);
        allseats.add(commonlistindx1[a]);
      }
    });
    print(allseats);
    // print(uppseat);
  }

  // TextEditingController passmail=TextEditingController();
  // TextEditingController passcont=TextEditingController();

  @override
  void initState() {
    getdata();
    super.initState();
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

        appBar: AppBar(
            title: GestureDetector(
                onTap: (){
                  getdata();

                },
                child: Text("Passenger Information", style:textstyle.upperstyle,)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: iconstyle.back_icon)
        ),

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizeConfig.screenHeight*0.010,
                  width: SizeConfig.screenWidth,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),

                //Mahasagar travelles
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: Row(
                    children: [
                      iconstyle.bus_icon,
                      SizedBox(width: SizeConfig.screenWidth*0.050,),
                      Text(travname.toString(), style: passangerstyle.contactstyle,),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),


                //ankleshawar:
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: SizeConfig.screenHeight*0.040,
                              width:SizeConfig.screenWidth*0.4,
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(from.toString(), style: passangerstyle.ankleshawstyle,))),
                          Text(deptime.toString(), style: passangerstyle.emailstyle,),
                        ],
                      ),
                      Icon(Icons.arrow_forward, size: 20,color: Colors.white.withOpacity(0.5),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: SizeConfig.screenHeight*0.040,
                              width:SizeConfig.screenWidth*0.4,
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(to.toString(), style: passangerstyle.ankleshawstyle,textAlign: TextAlign.center,))),
                          Text(arrtime.toString(), style: passangerstyle.emailstyle,),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),


                Container(
                  height: SizeConfig.screenHeight*0.010,
                  width: SizeConfig.screenWidth,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),

                //Contect details:
                Container(
                  width: SizeConfig.screenWidth*.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.contact_mail, size: 15,color: Colors.white,),
                      SizedBox(width: SizeConfig.screenWidth*0.050,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contact Details", style: passangerstyle.contactstyle,),
                          Text("Your ticket and Bus details will be sent here", style: passangerstyle.emailstyle,)

                        ],
                      )
                    ],

                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),


                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: Text("Email Id", style: passangerstyle.emailstyle,),
                ),


                //email container: TXTFORM
                Container(
                  color: Colors.transparent,
                  width: SizeConfig.screenWidth*0.90,
                  child: TextFormField(
                    style: passangerstyle.emailstyle,
                    controller: passmail,
                    autofocus: false,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,)
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,)
                      ),
                      hintText:  "Enter Email",
                      hintStyle: passangerstyle.emailstyle,
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.screenHeight*0.020,),

                //phone No text:
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: Text("Phone No", style: passangerstyle.emailstyle,),
                ),

                //phone No: TXTFORM
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("+91", style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w500),),
                      Container(
                        color: Colors.transparent,
                        width: SizeConfig.screenWidth*0.80,
                        child: TextFormField(
                          style: passangerstyle.emailstyle,
                          controller: passcont,
                          autofocus: false,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,)
                            ),
                            hintText:  "Enter Phone No",
                            hintStyle: passangerstyle.emailstyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),



                Container(
                  height: SizeConfig.screenHeight*0.010,
                  width: SizeConfig.screenWidth,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(height: SizeConfig.screenHeight*0.020,),

                //add Passanger:
                Container(
                  width: SizeConfig.screenWidth*0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      iconstyle.add_person_icon,
                      SizedBox(width: SizeConfig.screenWidth*0.050,),
                      Text("Add Passangers", style: passangerstyle.contactstyle,)
                    ],
                  ),
                ),

                //listviews:
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    width: SizeConfig.screenWidth*0.9,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.white.withOpacity(0.5)),
                    //   borderRadius: BorderRadius.circular(15)
                    // ),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: commonlistindx.length+commonlistindx1.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          height: SizeConfig.screenHeight*0.5,

                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Passsanger", style: passangerstyle.contactstyle,),
                              Text("Seat No: ${allseats[index]}", style: passangerstyle.emailstyle,),
                              Text('Name', style: passangerstyle.emailstyle,),
                              Container(
                                color: Colors.transparent,
                                width: SizeConfig.screenWidth*0.80,
                                child: TextFormField(
                                  controller: namecontroller[index],
                                  autofocus: false,
                                  style: GoogleFonts.poppins(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w600),
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,)
                                    ),
                                    hintText:  "Enter Name",
                                    hintStyle:  GoogleFonts.poppins(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight*0.020,),

                              Text('Age', style: passangerstyle.emailstyle,),
                              Container(
                                color: Colors.transparent,
                                width: SizeConfig.screenWidth*0.80,
                                child: TextFormField(
                                  controller: agecontroller1[index],
                                  style: GoogleFonts.poppins(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w600),

                                  autofocus: false,
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,)
                                    ),
                                    hintText:  "Age",
                                    hintStyle:  GoogleFonts.poppins(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight*0.020,),

                              Text('Gender', style: passangerstyle.emailstyle,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      activeColor: Colors.white,
                                      value: 1,
                                      groupValue: tot[index],
                                      onChanged: (value){
                                        setState(() {
                                          tot[index]=value!;
                                        });
                                      },
                                      title: Text('Male', style: passangerstyle.ankleshawstyle,),
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      activeColor: Colors.white,
                                      value: 2,
                                      groupValue: tot[index],
                                      onChanged: (value){
                                        setState(() {
                                          tot[index]=value!;
                                        });
                                      },
                                      title: Text('Famale', style: passangerstyle.ankleshawstyle,),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: SizeConfig.screenHeight*0.050,);
                      },

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        bottomNavigationBar: Container(
          height: SizeConfig.screenHeight*0.13,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.centerLeft,
                  // child: Text("Amount : 150\₹", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                  child: Text("Amount : \₹${(commonlistindx1.length+commonlistindx.length)*int.parse(price.toString())}", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                ),
              ),

              Expanded(
                  child: InkWell(
                    onTap: (){
                      List allpasname=[];
                      List allpasage=[];
                      List allpasgender=[];
                      sfpassname.clear();
                      sfpassage.clear();
                      sfpassgender.clear();
                      setState(() {

                        for(int i=0;i<namecontroller.length;i++){
                          print(namecontroller[i].text);
                          print(agecontroller1[i].text);
                          // allpasname.add(_namecontroller[i].text);
                          // allpasage.add(_agecontroller1[i].text);
                          sfpassname.add(namecontroller[i].text);
                          sfpassage.add(agecontroller1[i].text);
                          sfpassgender.add(tot[i]);
                          sfpassseat.add(allseats[i]);

                        }

                        sfpasscontactno=passcont.text;
                        sfpassmail=passmail.text;
                      });
                      print(tot);
                      print(passcont.text);
                      print(passmail.text);


                      if(sfpassname.isEmpty||passmail.text.isEmpty||passcont.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter All Details");
                      }
                      else{
                        Get.to(ticket_page(docid: widget.docid,docindx: widget.docindx,));
                      }
                    },
                    child: Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text("PROCESS",style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),),
                    ),
                  )
              )
            ],
          ),

        ),
      ),
    );
  }
}
