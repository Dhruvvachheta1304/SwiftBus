import 'package:bluebus/admin_screens/travel_add_details.dart';
import 'package:bluebus/common_pages/common_list.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/common_variable/common_var.dart';
import 'package:bluebus/screen_pages/Login_singup_page.dart';
import 'package:bluebus/screen_pages/buy_ticket_page.dart';
import 'package:bluebus/screen_pages/search_location_page.dart';
import 'package:bluebus/screen_pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_pages/common_theem_colour_page.dart';
import 'mybookings.dart';


class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  TextEditingController dateController_home= TextEditingController();


  var selected_date;
  var today_date;

  date_fun() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000))
        .then((pickedDate) {

      if(pickedDate != null ){
        print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
        print(formattedDate); //formatted date output using intl package =>  2022-07-04
        //You can format date as per your need



        setState(() {
             selected_date = formattedDate;
        });
      }else{
        Fluttertoast.showToast(msg: "Date is not Selected");
        print("Date is not selected");
      }

    });
  }
  
  time_fun() async {
    TimeOfDay? pickedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context
    ); //context of current state// );

    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);

      setState(() {
        dateController_home.text = formattedTime;

      });

      print(formattedTime);
    } else {
      Fluttertoast.showToast(
          msg: "time is not selected!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  List travel_date_list= [];
  List travel_name_list= [];
  List travel_from_list = [];
  List travel_to_list = [];
  List travel_depachartime_list= [];
  List travel_arrivedtime_list= [];
  List travel_contactno_list= [];
  List travel_vehicaleno_list= [];

  CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");

  travel_get_deatails()async {
    QuerySnapshot travel_querysnapshot = await travel_collection.get();
    travel_querysnapshot.docs!.forEach((element) {

      travel_date_list.add(element.get("Date"));
      travel_name_list.add(element.get("travel_name"));

      travel_depachartime_list.add(element.get("depachar_time"));
      travel_arrivedtime_list.add(element.get("arrived_time"));

      travel_from_list.add(element.get("from"));
      travel_to_list.add(element.get("to"));

      travel_contactno_list.add(element.get("contact_no"));
      travel_vehicaleno_list.add(element.get("vehicale_no"));

    });
  print(travel_name_list);
  print(travel_date_list);
  print(travel_from_list);
  print(travel_to_list);
  print(travel_depachartime_list);
  print(travel_arrivedtime_list);
  print(travel_contactno_list);
  print(travel_vehicaleno_list);
  }

  List tra_list= [];
  fun_travel_name_filtter() async {
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    final suggestions = _search_qeurysnapshot.docs.where((element) {
      final exname=element.get("loc").toString();
      final input = selected_value.toString();
      return exname.contains(input);
    }).toList();
    setState(() => tra_list = suggestions);
    print(tra_list);
  }
  
  List indxss=[];
  bool busfound=true;
  
  getselecteddata() async {
    setState(() {
      indxss.clear();
    });

    // CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    for(int i=0;i<_search_qeurysnapshot.docs.length;i++){
      if(_search_qeurysnapshot.docs[i].get("Date")==selected_date.toString()&&_search_qeurysnapshot.docs[i].get("from")==selected_value&&_search_qeurysnapshot.docs[i].get("to")==selected_value2){
        setState(() {
          busfound=true;
          indxss.add(i);
          print(i);
        });
      }
    }
    if(indxss.isEmpty){
      setState(() {
        busfound=false;
      });
    }
  }
  List totseat=[];

  gettotseats() async {
    setState(() {
      totseat.clear();
    });

    int count=0;
    // CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    for(int i=0;i<_search_qeurysnapshot.docs.length;i++){
      setState(() {
        count=0;
        for(int a=0;a<_search_qeurysnapshot.docs[i]["lowerseats"].length;a++){
          if(_search_qeurysnapshot.docs[i]["lowerseats"][a]==false){
            count=count+1;
            print(count);
          }
        }
        for(int a=0;a<_search_qeurysnapshot.docs[i]["upperseats"].length;a++){
          if(_search_qeurysnapshot.docs[i]["upperseats"][a]==false){
            count=count+1;
            print(count);
          }
        }

        totseat.add(count);
      });
    }
    print(totseat);
  }

  @override
  void initState() {
    travel_get_deatails();
    fun_travel_name_filtter();
    gettotseats();
    if(selected_date==""||selected_date==null){
      setState((){
        selected_date=DateFormat("dd/MM/yyyy").format(DateTime.now());
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final h= MediaQuery.of(context).size.height;
    final w= MediaQuery.of(context).size.width;

    SizeConfig().init(context);

    return SafeArea(
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          gradient: theemecolor
        ),
        child: Scaffold(

          backgroundColor: Colors.transparent,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: GestureDetector(
                onTap: (){
                  gettotseats();
                  print(totseat);
                },
                child: Text("Blue Bus")),
            centerTitle: true,
            actions: [
              Center(child: Padding(
                padding: EdgeInsets.only(right: SizeConfig.screenWidth*0.05),
                child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selected_date="";
                        selected_value="";
                        selected_value2="";
                        indxss.clear();
                      });
                    },
                    child: Text("Clear")),
              ))
            ],
            // leading: Icon(Icons.menu, size: 25,color: Colors.white,),

          ),

          //drawer
          drawer: Drawer(
              child: ListView(
                children: [

                  //image container:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: theemecolor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: h*0.030,),

                          //Hello
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: h*0.100,
                                width: w*0.190,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              ),
                              SizedBox(width: w*0.050,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name", style:GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                                  SizedBox(height: h*0.008,),
                                  Container(
                                     height: h*0.04,
                                      width: w*0.4,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text("chaudharyvijaykumar1010@gmail.com", style:GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),))),
                                ],
                              ),
                              SizedBox(width: w*0.050,),

                            ],
                          ),
                          SizedBox(height: h*0.030,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(gradient: theemcolor2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //My profile
                        GestureDetector(
                          onTap: (){
                          },
                          child: GestureDetector(
                            onTap: (){
                              Get.to(profile_page());
                            },
                            child: ListTile(
                              leading: Icon(Icons.person, size: 20,color: Colors.black.withOpacity(0.5),),
                              title:Text("My profile", style: textstyle.drawerstyle),
                            ),
                          ),
                        ),



                        // My Booking
                        ListTile(
                          onTap: (){
                            Get.to(mybookings());
                          },
                          leading: Icon(Icons.book_outlined, size: 20,color: Colors.black.withOpacity(0.5),),
                          title:Text("My Booking",style: textstyle.drawerstyle),
                        ),


                        //Contect Us
                        ListTile(
                          leading: Icon(Icons.contact_page_outlined, size: 20,color: Colors.black.withOpacity(0.5),),
                          title:Text("Contect Us", style: textstyle.drawerstyle),
                        ),

                        //About Us
                        ListTile(
                          leading: Icon(Icons.laptop_chromebook, size: 20,color: Colors.black.withOpacity(0.5),),
                          title:Text("About Us", style: textstyle.drawerstyle),
                        ),

                        //Setting Us
                        ListTile(
                          leading: Icon(Icons.settings, size: 20,color: Colors.black.withOpacity(0.5),),
                          title:Text("Settings", style:textstyle.drawerstyle),
                        ),

                        //Delete Acccount:
                        ListTile(
                          leading: Icon(Icons.delete, size: 15,color: Colors.black.withOpacity(0.5),),
                          title:Text(" Delete Account", style: textstyle.drawerstyle),
                        ),

                        //Logout:
                        InkWell(
                          onTap: () async {
                            FirebaseAuth.instance.signOut().then((value) async {
                              var share_pre= await SharedPreferences.getInstance();
                              await share_pre.clear().then((value) {
                              Get.to(login_singup_page());
                            });
                            });
                          },
                          child: ListTile(
                            leading: Icon(Icons.logout, size: 20,color:Colors.black.withOpacity(0.5) ,),
                            title: Text("Logout", style:textstyle.drawerstyle),
                          ),
                        )

                      ],
                    ),
                  )

                ],
              ),
            ),

          //body:
          body: WillPopScope(
            onWillPop: (){
              SystemNavigator.pop();
              return Future.value(false);
            },
            child: Center(
              child: Column(
                children: [

                  // first  your location container:
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: h*0.008),
                      width: MediaQuery.of(context).size.width*0.9,

                      decoration:BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15)
                      ) ,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              // orang and blue line container:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE18E42),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(0xffE8C29E),width: 3)
                                    ),
                                  ),
                                  DottedLine(
                                    dashLength: 1.0,
                                    lineLength: h*0.06,
                                    lineThickness: 2.0,
                                    dashGapRadius: 1.0,
                                    dashRadius: 2.0,
                                    dashColor: Colors.transparent,
                                    dashGapLength: 1.0,
                                    direction: Axis.vertical,
                                    dashGapGradient: [Colors.orangeAccent, Colors.blue],
                                  ),

                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        color: Color(0xff3672D2),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white.withOpacity(0.4),width: 3)
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(width: h*0.010,),


                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("From", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),),
                                    SizedBox(height: h*0.002,),

                                    //Start Location container:
                                    InkWell(
                                        onTap: (){
                                          Get.to(search_location(frompage: "from",));
                                        },
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: h*0.040,
                                            width: w*0.5,
                                            // color: Colors.blue,
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(selected_value==""||selected_value==null?"Start Location ":selected_value, style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),)))),



                                    Container(
                                      height: 1,
                                      width: w*0.8,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    SizedBox(height: h*0.008,),

                                    Text("To", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),),
                                    SizedBox(height: 2,),

                                    //End Location:
                                    InkWell(
                                        onTap: (){
                                          Get.to(search_location(frompage: "to",));
                                        },
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: h*0.040,
                                            width: w*0.5,
                                            // color: Colors.blue,
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(selected_value2==""||selected_value2==null?"End Location ":selected_value2, style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 16),)))),


                                  ],
                                ),
                              ),


                            ],
                          ),

                          //updown Icons:
                          Positioned(
                            right: w*0.1,
                            child: Container(
                              alignment: Alignment.center,
                              height: h*0.07,
                              width: w*0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                    offset: Offset(
                                      0.0, // Move to right 5  horizontally
                                      0.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Container(
                                height: h*0.04,
                                width: w*0.1,
                                child: SvgPicture.asset("assets/image/up-down-arrow.svg",
                                ),
                              ),
                            ),
                          )
                        ]
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  //CALENDER & GO
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        GestureDetector(
                          onTap: (){
                            date_fun();
                          },
                          child: Container(
                            height: SizeConfig.screenHeight*0.060,
                            width: SizeConfig.screenWidth*0.600,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child:GestureDetector(
                              onTap: (){
                                date_fun();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.calendar_today, color: Colors.black,size: 18,),
                                  Text("Depart At: ", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500,),),
                                  Text("${selected_date==""|| selected_date == null ?  DateFormat("dd/MM/yyyy").format(DateTime.now()):selected_date }", style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),),

                                ],
                              ),
                            ) ,
                          ),
                        ),


                        GestureDetector(
                          onTap: (){


                            getselecteddata();
                          },
                          child: Container(
                            height: 50,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text("Go", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                  // LISTVIEW
                  Expanded(

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),

                      ),
                      child: busfound==false?
                          Center(child: Text("No Buses Found")):
                      StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                        stream: FirebaseFirestore.instance.collection("Travels").snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return ListView.separated(
                            itemCount: indxss.isEmpty?snapshot.data!.docs.length:indxss.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),

                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                  width: w*0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.purple,width: 0.5)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //first container:
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //TRAVELS,TIME
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                //Mahasagar Travels full container:
                                                Container(
                                                  width: w*0.85,
                                                  // color: Colors.grey,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: w*0.45,
                                                        // color: Colors.green,
                                                        child: Text(snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].get("travel_name").toString(),style: textstyle.travelstyle),),
                                                      //ac image:
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 5),
                                                        child: Container(
                                                            height: h*0.035,
                                                            width: w*0.080,
                                                            // color: Colors.black,
                                                            child: SvgPicture.asset("assets/image/air-conditioner-svgrepo-com.svg")),
                                                      ),
                                                      SizedBox(width: w*0.080,),
                                                      Text("\₹ ${snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].get("price")}",style: TextStyle(fontSize: 18,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w700),),

                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                //TRAVEL TIME
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("TRAVEL TIME: ",style: TextStyle(color: Colors.grey.withOpacity(0.8),fontWeight: FontWeight.w600),),
                                                    Text("2 hr ",style: TextStyle(color: Colors.purple.withOpacity(0.8),fontWeight: FontWeight.w600),),
                                                  ],
                                                ),
                                                //TIMING
                                                Row(
                                                  children: [
                                                    Icon(Icons.directions_bus,size: 15,),
                                                    Text(snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].get("depachar_time").toString(),style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w700),),
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.directions_bus,size: 15,),
                                                    Text(snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].get("arrived_time").toString(),style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w700),),
                                                  ],
                                                ),

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),



                                      //Second Container:
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            //DOTTED LINE
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffE18E42),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Color(0xffE8C29E),width: 3)
                                                  ),
                                                ),
                                                DottedLine(
                                                  dashLength: 1.0,
                                                  lineLength: h*0.06,
                                                  lineThickness: 2.0,
                                                  dashGapRadius: 1.0,
                                                  dashRadius: 2.0,
                                                  dashColor: Colors.transparent,
                                                  dashGapLength: 1.0,
                                                  direction: Axis.vertical,
                                                  dashGapGradient: [Colors.orangeAccent, Colors.blue],
                                                ),

                                                Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff3672D2),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.white.withOpacity(0.4),width: 3)
                                                  ),
                                                ),

                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            //DESTINATION
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [
                                                Text("From",style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.35),fontWeight: FontWeight.w600),),
                                                Container(
                                                    width: w*0.45,
                                                    // color: Colors.grey,
                                                    child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Text(snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].get("from"),style: textstyle.locationstyle,))),
                                                SizedBox(height:h*0.015),
                                                Text("To",style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.35),fontWeight: FontWeight.w600),),
                                                Container(
                                                    width: w*0.45,
                                                    // color: Colors.grey,
                                                    child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Text(snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].get("to"),style:textstyle.locationstyle,))),
                                              ],
                                            ),


                                            Container(
                                              padding: EdgeInsets.only(top: 20),
                                              // color: Colors.blue,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Available ", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),),
                                                      Text("seat : ${totseat[indxss.isEmpty?index:indxss[index]]} ",style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600) ),
                                                    ],
                                                  ),

                                                  SizedBox(height:h*0.010,),


                                                  //buy ticket full container:
                                                  InkWell(

                                                    onTap: (){
                                                      Get.to(buy_ticket_page(
                                                        docid: snapshot.data!.docs[indxss.isEmpty?index:indxss[index]].id,
                                                        docindx: indxss.isEmpty?index.toString():indxss[index].toString(),
                                                      ));
                                                      commonlistindx.clear();
                                                      commonlistindx1.clear();
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                                      height: h*0.05,
                                                      decoration: BoxDecoration(
                                                          gradient: theemecolor,
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height:h*0.03,
                                                            width: w*0.06,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),

                                                            child: Icon(Icons.airplane_ticket,size: 18,),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text("BUY TICKET",style: TextStyle(color: Colors.white),)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                              );
                            },

                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: h*0.03,);
                            },

                          );
                        },
                      )

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
