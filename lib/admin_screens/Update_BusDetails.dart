import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import '../common_pages/height_width_page.dart';

class update_bus_details extends StatefulWidget {
  update_bus_details(
      {
        required this.realindex,
        required this.index,
        required this.udate,
        required this.utname,
        required this.ufrom,
        required this.uto,
        required this.uarrived,
        required this.udrop,
        required this.ucontact,
        required this.uvehicale,
        required this.price});


  String?realindex,index, udate, utname, ufrom, uto, uarrived, udrop, ucontact, uvehicale,price;

  @override
  State<update_bus_details> createState() => _update_bus_detailsState();
}

class _update_bus_detailsState extends State<update_bus_details> {

  final u_date = TextEditingController();
  final u_travel_name = TextEditingController();
  final u_from = TextEditingController();
  final u_to = TextEditingController();
  final u_depachar_time = TextEditingController();
  final u_arrive_time = TextEditingController();
  final u_contact_no = TextEditingController();
  final u_vehicale_no = TextEditingController();
  final u_price = TextEditingController();

  List boardingpoint=[];
  int totboarding=0;
  int totdroping=0;
  List dropingpoint=[];
  List addboard=[];
  List adddrop=[];
  List addboardtime=[];
  List adddroptime=[];
  var selectedValue3;
  var selectedValue4;
  final clock_time3 = TextEditingController();
  final clock_time4 = TextEditingController();
  List boardtimecont = [];
  List droptimecont = [];
  final dateController = TextEditingController();
  List<TextEditingController> _controller = [];
  List<TextEditingController> _controller1 = [];
  List<TextEditingController> _updboardtime = [];
  List<TextEditingController> _upddroptime = [];

  date_fun(selected_date_value) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(3000),)
        .then((pickedDate) {
      if(pickedDate != null ){
        print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
        print(formattedDate); //formatted date output using intl package =>  2022-07-04
        //You can format date as per your need

        setState(() {
          if(selected_date_value =="add_selected_date"){
            setState(() {
              dateController.text= formattedDate;
            });

          }
          if(selected_date_value == "upadte_selected_date"){
            setState(() {
              u_date.text=formattedDate;
            });

          }
        });
      }else{
        Fluttertoast.showToast(msg: "Date is not Selected");
        print("Date is not selected");
      }

    });
  }

  time_fun(String timestore) async {
    TimeOfDay? pickedTime = await   showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget!);
        });

    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      setState(() {
        if (timestore == "admin_udtime") {
          setState(() {
            clock_time3.text = formattedTime;
          });

        }
        if (timestore == "admin_uatime") {
          setState(() {
            clock_time4.text = formattedTime;
          });

        }

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

  List location_list = [];
  var Locations_var;
  CollectionReference _collectionReference = FirebaseFirestore.instance.collection("Locations");

  setdata() async {
    CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    QuerySnapshot querysnapshot = await _collectionReference.get();

    setState(() {
      Locations_var = querysnapshot.docs.map((e) => e.get("loc")).toList();
      print(Locations_var);
      location_list.clear();
      boardingpoint.clear();
      dropingpoint.clear();
      _controller.clear();
      _controller1.clear();

      boardtimecont.clear();
      droptimecont.clear();
      _updboardtime.clear();
      _upddroptime.clear();

      location_list.addAll(Locations_var);
      selectedValue3=widget.ufrom;
      selectedValue4=widget.uto;


      u_date.text=widget.udate!;
      u_travel_name.text =widget.utname!;
      u_from.text = widget.ufrom!;
      u_to.text = widget.uto!;
      clock_time3.text = widget.uarrived!;
      clock_time4.text = widget.udrop!;
      u_contact_no.text = widget.ucontact!;
      u_vehicale_no.text = widget.uvehicale!;
      u_price.text = widget.price!;

      totboarding=_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["boardingpoint"].length;
      totdroping=_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["dropingpoint"].length;

      for(int a=0;a<_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["boardingpoint"].length;a++){
        boardingpoint.add(_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["boardingpoint"][a]);
        boardtimecont.add(_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["boardtime"][a]);
      }

      for(int a=0;a<_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["dropingpoint"].length;a++){
        dropingpoint.add(_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["dropingpoint"][a]);
        droptimecont.add(_search_qeurysnapshot.docs[int.parse(widget.realindex.toString())]["droptime"][a]);
      }

      for(int a=0;a<totboarding;a++){
        var textEditingController = new TextEditingController(text:boardingpoint[a].toString());
        _controller.add(textEditingController);
        var textEditingController1 = new TextEditingController(text:boardtimecont[a].toString());
        _updboardtime.add(textEditingController1);
      }
      for(int a=0;a<totdroping;a++){
        var textEditingController = new TextEditingController(text:dropingpoint[a].toString());
        _controller1.add(textEditingController);
        var textEditingController1 = new TextEditingController(text:droptimecont[a].toString());
        _upddroptime.add(textEditingController1);
      }
      print("BOARING ${totboarding} ${_controller.length}");
      print("DROPING ${totdroping} ${_controller1.length}");
    });
  }

  final _fstore_travel = FirebaseFirestore.instance;

  upadte_data_fun(List board,List drop,List addboardtime,List adddroptime) async {
    print("hello1");
    setState(() {
      isload=true;
    });
    await _fstore_travel.collection("Travels").doc(widget.index.toString()).update(  {
      "Date" :u_date.text,
      "travel_name": u_travel_name.text,
      "from": selectedValue3,
      "to": selectedValue4,
      "depachar_time": clock_time3.text==""|| clock_time3.text==null ? u_depachar_time.text:clock_time3.text,
      "arrived_time":clock_time4.text==""|| clock_time4.text==null ? u_arrive_time.text:clock_time4.text,
      "contact_no": u_contact_no.text,
      "vehicale_no": u_vehicale_no.text,
      "price":u_price.text,
      "boardingpoint":board,
      "dropingpoint":drop,
      "boardtime":addboardtime,
      "droptime":adddroptime

    }).then((value) {
      setState(() {
        isload=true;
      });
    });
  }
  bool isload=false;

  @override
  void initState() {

    setdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,)),
        title:Text("Update Details",style: TextStyle(color: Colors.black,fontSize: 20),),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //date Container:
              SizedBox(height: 10,),

              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),),
                child: TextFormField(
                  autofocus: false,
                  controller:u_date,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: u_date.text,
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            u_date.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                  onTap: (){
                    date_fun("upadte_selected_date");
                  },
                ),
              ),
              SizedBox(height: 10,),

              //travel container:
              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),),
                child: TextFormField(
                  controller: u_travel_name,
                  autofocus: false,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: u_travel_name.text,
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            u_travel_name.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              //from
              Container(
                width: SizeConfig.screenWidth * 0.9,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                             "${selectedValue3}",
                            // style: font_style.white_400_16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: location_list
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedValue3,
                    onChanged: (value) {
                      setState(() {
                        selectedValue3 = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      padding: EdgeInsets.only(left: 5),
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black),
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      iconSize: 20,
                      iconEnabledColor: Colors.yellow.withOpacity(0.2),
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: SizeConfig.screenWidth * 0.9,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.blueAccent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14)),
                          border: Border.all(color: Colors.black),
                        ),
                        elevation: 0,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility:
                          MaterialStateProperty.all(true),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              //To container:
              Container(
                width: SizeConfig.screenWidth * 0.9,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                           "${selectedValue4}",
                            // style: font_style.white_400_16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: location_list
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedValue4,
                    onChanged: (value) {
                      setState(() {
                        selectedValue4 = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      padding: EdgeInsets.only(left: 5),
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.black),
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      iconSize: 20,
                      iconEnabledColor: Colors.yellow.withOpacity(0.2),
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: SizeConfig.screenWidth * 0.9,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.blueAccent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14)),
                          border: Border.all(color: Colors.black),
                        ),
                        elevation: 0,
                        scrollbarTheme: ScrollbarThemeData(
                          radius: Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility:
                          MaterialStateProperty.all(true),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              //depachartime
              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: clock_time3,
                  autofocus: false,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  onTap: (){
                    time_fun("admin_udtime");
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),

                      hintText:  u_depachar_time.text,
                      hintStyle:  GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            clock_time3.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              //arrvired time Container:
              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: clock_time4,
                  autofocus: false,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  onTap: (){
                    time_fun("admin_uatime");
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      hintText:  u_arrive_time.text ,
                      hintStyle:  GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            clock_time4.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              //Contact Details:
              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: u_contact_no,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  autofocus: false,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    counterText: "",
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: u_contact_no.text,
                      hintStyle:  GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500),

                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            u_contact_no.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              //Vehicale no:
              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: u_vehicale_no,
                  autofocus: false,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: u_vehicale_no.text,
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            u_vehicale_no.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              //PRICE
              Container(
                height: SizeConfig.screenHeight * 0.050,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: u_price,
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: u_price.text,
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            u_price.clear();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10,),

              //FROM BOARDING
              Container(
                width: SizeConfig.screenWidth*0.9,
                child: Row(
                  children: [
                    Text("Boarding Point",),
                    Spacer(),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            setState(() {
                              print(totboarding);
                              totboarding=totboarding+1;
                              _controller.add(TextEditingController());
                              _updboardtime.add(TextEditingController());
                              print(totboarding);
                            });
                          });
                        },
                        child: Icon(Icons.add,color: Colors.black,)),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: SizeConfig.screenWidth*0.9,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: totboarding,
                  itemBuilder: (context, index) {
                    return  Container(
                      height: SizeConfig.screenHeight * 0.050,
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _controller[index],
                        autofocus: false,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15.0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("Boarding Point"),
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    setState(() {
                                      totboarding=totboarding-1;
                                      _controller.removeAt(index);
                                      _updboardtime.removeAt(index);
                                    });
                                  });

                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10,);
                  },

                ),
              ),
              SizedBox(height: 10,),

              //TO DROPING
              Container(
                width: SizeConfig.screenWidth*0.9,
                child: Row(
                  children: [
                    Text("Droping Point",),
                    Spacer(),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            setState(() {
                              print(totdroping);
                              totdroping=totdroping+1;
                              _controller1.add(TextEditingController());
                              _upddroptime.add(TextEditingController());
                              print(totdroping);
                            });
                          });
                        },
                        child: Icon(Icons.add,color: Colors.black,)),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: SizeConfig.screenWidth*0.9,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: totdroping,
                  itemBuilder: (context, index) {
                    return  Container(
                      height: SizeConfig.screenHeight * 0.050,
                      width: SizeConfig.screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _controller1[index],
                        autofocus: false,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15.0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("Droping Point"),
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    setState(() {
                                      totdroping=totdroping-1;
                                      _controller1.removeAt(index);
                                      _upddroptime.removeAt(index);
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10,);
                  },

                ),
              ),
              SizedBox(height: 10,),

              //BOARDING POINT TIME
              _controller.isEmpty?Container():
              Column(
                children: [

                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: Text("Select Boarding Point Time",),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _updboardtime.length,
                      itemBuilder: (context, index) {
                        return  Row(
                          children: [
                            Container(
                                width:_controller[index].text.length<=19?null: SizeConfig.screenWidth*0.4,
                                // child: Text("12345678901234567890",)
                                child: Text("${_controller[index].text}: ",)
                            ),

                            Container(
                              height: SizeConfig.screenHeight * 0.050,
                              width: SizeConfig.screenWidth * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, childWidget) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(
                                              // Using 24-Hour format
                                                alwaysUse24HourFormat: true),
                                            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
                                            child: childWidget!);
                                      });//context of current state// );
                                  if (pickedTime != null) {
                                    print(pickedTime.format(context));
                                    DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                    String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                    setState(() {
                                      _updboardtime[index].text=formattedTime;

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
                                },
                                controller: _updboardtime[index],
                                autofocus: false,
                                cursorColor: Colors.black,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    label: Text("Select Time"),
                                    labelStyle: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            setState(() {
                                              totboarding=totboarding-1;
                                              _controller.removeAt(index);
                                              _updboardtime.removeAt(index);
                                            });
                                          });

                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10,);
                      },

                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),

              //DROPING POINT TIME
              _controller1.isEmpty?Container():
              Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: Text("Select Droping Point Time",),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: SizeConfig.screenWidth*0.9,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _upddroptime.length,
                      itemBuilder: (context, index) {
                        return  Row(
                          children: [
                            Container(
                                width:_controller1[index].text.length<=19?null: SizeConfig.screenWidth*0.4,
                                child: Text("${_controller1[index].text}: ",)
                            ),

                            Container(
                              height: SizeConfig.screenHeight * 0.050,
                              width: SizeConfig.screenWidth * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                readOnly: true,
                                onTap: () async {

                                  TimeOfDay? pickedTime = await  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, childWidget) {
                                        return MediaQuery(
                                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                            child: childWidget!);
                                      });
                                  if (pickedTime != null) {
                                    print(pickedTime.format(context));
                                    DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                    String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                    setState(() {
                                      _upddroptime[index].text=formattedTime;
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
                                },
                                controller: _upddroptime[index],
                                autofocus: false,
                                cursorColor: Colors.black,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    label: Text("Select Time"),
                                    labelStyle: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            setState(() {
                                              totdroping=totdroping-1;
                                              _controller1.removeAt(index);
                                              _upddroptime.removeAt(index);
                                            });
                                          });

                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10,);
                      },

                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),

              SizedBox(height: 10,),

              SizedBox(height: 10,),

            ],
          ),

        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          Container(
            width: SizeConfig.screenWidth*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //upadate container:
                InkWell(
                  onTap: () {
                    setState(() {
                      addboardtime=[];
                      adddroptime=[];
                      addboard.clear();
                      adddrop.clear();
                      _controller.forEach((element) {
                        addboard.add(element.text);
                      });
                      _controller1.forEach((element) {
                        adddrop.add(element.text);
                      });
                      _updboardtime.forEach((element) {
                        addboardtime.add(element.text);
                      });
                      _upddroptime.forEach((element) {
                        adddroptime.add(element.text);
                      });
                      print(addboardtime);
                      print(adddroptime);

                      if (addboard.isEmpty||adddrop.isEmpty||addboardtime.isEmpty||adddroptime.isEmpty||
                          u_date.text.isEmpty|| u_travel_name.text.isEmpty|| u_from.text.isEmpty||
                          u_to.text.isEmpty|| clock_time3.text.isEmpty|| clock_time4.text.isEmpty||
                          u_contact_no.text.isEmpty|| u_vehicale_no.text.isEmpty|| u_price.text.isEmpty
                      )
                      {
                        Fluttertoast.showToast(msg: "Fill all Details");
                      } else {
                        Fluttertoast.showToast(msg: "UPDATED");
                        upadte_data_fun(addboard,adddrop,addboardtime,adddroptime);
                        Get.back();
                      }
                    });
                  },
                  child: Container(
                    height: SizeConfig.screenHeight * 0.050,
                    width: SizeConfig.screenWidth * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    child: isload==true?Center(child: CircularProgressIndicator(),):
                    Text(
                      "Update",
                      style: textstyle.locationstyle,
                    ),
                  ),
                ),

                //cancle Container:
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: SizeConfig.screenHeight * 0.050,
                    width: SizeConfig.screenWidth * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Cancle",
                      style: textstyle.locationstyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
