import 'package:bluebus/admin_screens/Update_BusDetails.dart';
import 'package:bluebus/admin_screens/floating_container.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class travell_add_details extends StatefulWidget {
  const travell_add_details({Key? key}) : super(key: key);

  @override
  State<travell_add_details> createState() => _travell_add_detailsState();
}

class _travell_add_detailsState extends State<travell_add_details> {

  final dateController = TextEditingController();
  final travel_name = TextEditingController();
  final from = TextEditingController();
  final to = TextEditingController();
  final contact_no = TextEditingController();
  final vehicale_no = TextEditingController();
  final price = TextEditingController();

  final u_date = TextEditingController();
  final u_travel_name = TextEditingController();
  final u_from = TextEditingController();
  final u_to = TextEditingController();
  final u_depachar_time = TextEditingController();
  final u_arrive_time = TextEditingController();
  final u_contact_no = TextEditingController();
  final u_vehicale_no = TextEditingController();
  final u_price = TextEditingController();

  final clock_time1 = TextEditingController();
  final clock_time2 = TextEditingController();
  final clock_time3 = TextEditingController();
  final clock_time4 = TextEditingController();

  var selectedValue1;
  var selectedValue2;
  var selectedValue3;
  var selectedValue4;
  bool samedata=false;



  final _fstore_travel = FirebaseFirestore.instance;




  CollectionReference _collectionReference = FirebaseFirestore.instance.collection("Locations");
  CollectionReference _collectionReference1 = FirebaseFirestore.instance.collection("Travels");

  var Locations_var;
  int tottrav=0;
  gettottrav() async {
    QuerySnapshot querysnapshot = await _collectionReference1.get();
    setState(() {
      tottrav=querysnapshot.docs.length;
    });
  }
  getloc_fun() async {
    QuerySnapshot querysnapshot = await _collectionReference.get();
    Locations_var = querysnapshot.docs.map((e) => e.get("loc")).toList();
    print(Locations_var);
  }

  List vehicle_var=[];
  List depchar_time_var=[];
  List arrvied_time_var=[];
  List vehicle_time_list = [];
  List date_list_var=[];


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
            dateController.text= formattedDate;
          }
          if(selected_date_value == "upadte_selected_date"){
            u_date.text=formattedDate;
          }
        });
      }else{
        Fluttertoast.showToast(msg: "Date is not Selected");
        print("Date is not selected");
      }

    });
  }

  List location_list = [];
  List from_list_var = [];
  List to_list_var = [];
  get_vehicale_time_fun() async {

    QuerySnapshot _querySnapshot1 = await _collectionReference1.get();
    setState(() {
      date_list_var = _querySnapshot1.docs.map((e) => e.get(("Date"))).toList();
      from_list_var = _querySnapshot1.docs.map((e) => e.get(("from"))).toList();
      to_list_var = _querySnapshot1.docs.map((e) => e.get(("to"))).toList();

      vehicle_var =
          _querySnapshot1.docs.map((e) => e.get("vehicale_no")).toList();
      depchar_time_var =
          _querySnapshot1.docs.map((e) => e.get("depachar_time")).toList();
      arrvied_time_var =
          _querySnapshot1.docs.map((e) => e.get("arrived_time")).toList();
    });

    setState(() {
      vehicle_time_list.addAll([vehicle_var.toString().replaceAll("[", "").replaceAll("]", ""),depchar_time_var.toString().replaceAll("[", "").replaceAll("]", ""),arrvied_time_var.toString().replaceAll("[", "").replaceAll("]", "")]);
    });

    print("veh:${vehicle_var}");
    print("Start${depchar_time_var}");
    print("stop${arrvied_time_var}");
    print(vehicle_time_list);
    print(from_list_var);
    print(to_list_var);
  }

  add_controller_clear() {
    dateController.clear();
    travel_name.clear();
    from.clear();
    to.clear();
    contact_no.clear();
    vehicale_no.clear();

    clock_time1.clear();
    clock_time2.clear();
  }

  update_controller_cleaner() {

    u_date.clear();
    u_travel_name.clear();
    u_from.clear();
    u_to.clear();
    u_depachar_time.clear();
    u_arrive_time.clear();
    u_contact_no.clear();
    u_vehicale_no.clear();

    clock_time3.clear();
    clock_time4.clear();
  }

  time_fun(String timestore) async {
    TimeOfDay? pickedTime = await   showTimePicker(
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
        if (timestore == "admin_dtime") {
          clock_time1.text = formattedTime;
        }
        if (timestore == "admin_atime") {
          clock_time2.text = formattedTime;
        }
        if (timestore == "admin_udtime") {
          clock_time3.text = formattedTime;
        }
        if (timestore == "admin_uatime") {
          clock_time4.text = formattedTime;
        }

        print(clock_time1.text); //output 14:59:00
        print(clock_time2.text); //output 14:59:00
        print(clock_time3.text); //output 14:59:00
        print(clock_time4.text);
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

  travel_alret_adddata_fun() {
    List boardingpoint=[];
    int totboarding=0;
    int totdroping=0;
    List dropingpoint=[];

    List addboard=[];
    List adddrop=[];
    List addboardtime=[];
    List adddroptime=[];


    date_list_var.clear();
    vehicle_var.clear();
    depchar_time_var.clear();
    arrvied_time_var.clear();
    boardingpoint.clear();
    dropingpoint.clear();
    totdroping=0;
    totboarding=0;
    get_vehicale_time_fun();
    setState(() {
      location_list.clear();
      location_list.addAll(Locations_var);
    });


    List<TextEditingController> _controller = [];
    List<TextEditingController> _controller1 = [];
    List<TextEditingController> _boardtime = [];
    List<TextEditingController> _droptime = [];

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, seState) {
              return Padding(
                padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: SizeConfig.screenHeight*0.87,
                  width: SizeConfig.screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: SizeConfig.screenWidth*0.3,
                          color: Colors.black,
                        ),
                       SizedBox(height: 10,),

                        Text("FILL DETAILS",style: TextStyle(color: Colors.black,fontSize: 20),),
                       SizedBox(height: 10,),

                        //date Container:
                        Container(
                          height: SizeConfig.screenHeight * 0.050,
                          width: SizeConfig.screenWidth * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),),
                          child: TextFormField(
                            autofocus: false,
                            controller: dateController,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            onTap: (){
                              date_fun("add_selected_date");
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15.0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: dateController.text==""|| dateController.text==null?DateFormat("dd/MM/yyyy").format(DateTime.now()):dateController.text,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      dateController.clear();
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

                        //travel container:
                        Container(
                          height: SizeConfig.screenHeight * 0.050,
                          width: SizeConfig.screenWidth * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              ),
                          child: TextFormField(
                            controller: travel_name,
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
                                label: Text("Travle Name"),
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      travel_name.clear();
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

                        //from container:
                        Container(
                          width: SizeConfig.screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedValue1 == "" || selectedValue1 == null ? 'From*' : selectedValue1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: location_list.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                ),)).toList(),
                              value: selectedValue1,
                              onChanged: (value) {
                                seState(() {
                                  selectedValue1 = value.toString();
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                padding: EdgeInsets.only(left: 5),
                                width: SizeConfig.screenWidth * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
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

                        //to container:
                        Container(
                          width: SizeConfig.screenWidth * 0.9,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedValue2 == "" ||
                                          selectedValue2 == null
                                          ? 'To*'
                                          : selectedValue2,
                                      // style: font_style.white_400_16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: location_list
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item, overflow: TextOverflow.ellipsis,),)).toList(),
                              value: selectedValue2,
                              onChanged: (valuex) {
                                seState(() {
                                  selectedValue2 = valuex.toString();
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                padding: EdgeInsets.only(left: 5),
                                width: SizeConfig.screenWidth * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(14),
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


                        // admin_dtime
                        Container(
                          height: SizeConfig.screenHeight * 0.050,
                          width: SizeConfig.screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),

                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: clock_time1,
                            autofocus: false,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            onTap: () {
                              time_fun("admin_dtime");
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15.0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: clock_time1.text == "" ||
                                    clock_time1.text == null
                                    ? "00:00:AM/PM"
                                    : clock_time1.text,
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      clock_time1.clear();
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

                        //admin atime Container:
                        Container(
                          height: SizeConfig.screenHeight * 0.050,
                          width: SizeConfig.screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),

                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: clock_time2,
                            autofocus: false,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            onTap: () {
                              time_fun("admin_atime");
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15.0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: clock_time2.text == "" ||
                                    clock_time2.text == null
                                    ? "00:00:AM/PM"
                                    : clock_time2.text,
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      clock_time2.clear();
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
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: contact_no,
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
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: contact_no.text.isEmpty ||
                                    contact_no.text == null ||
                                    contact_no.text == "" ||
                                    contact_no.text.length == 10
                                    ? "Please Enter valide number"
                                    : contact_no.text,
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      contact_no.clear();
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
                            controller: vehicale_no,
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
                                label: Text("Vehicale No"),
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      vehicale_no.clear();
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
                            keyboardType: TextInputType.phone,
                            controller: price,
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
                                label: Text("Price"),
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      price.clear();
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
                                      seState(() {
                                        totboarding=totboarding+1;
                                        _controller.add(TextEditingController());
                                        _boardtime.add(TextEditingController());
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
                                        label: Text("Add Boarding Point"),
                                        labelStyle: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(top: 0.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                seState(() {
                                                  totboarding=totboarding-1;
                                                  _controller.removeAt(index);
                                                  _boardtime.removeAt(index);
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
                                      seState(() {
                                        totdroping=totdroping+1;
                                         _controller1.add(TextEditingController());
                                        _droptime.add(TextEditingController());
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
                                      label: Text("Add Dropping Point"),
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(top: 0.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              seState(() {
                                                totdroping=totdroping-1;
                                                _controller1.removeAt(index);
                                                _droptime.removeAt(index);
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
                                shrinkWrap: true,
                                itemCount: _boardtime.length,
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
                                                _boardtime[index].text=formattedTime;

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
                                          controller: _boardtime[index],
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
                                                      seState(() {
                                                        totboarding=totboarding-1;
                                                        _controller.removeAt(index);
                                                        _boardtime.removeAt(index);
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
                                shrinkWrap: true,
                                itemCount: _droptime.length,
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
                                                _droptime[index].text=formattedTime;
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
                                          controller: _droptime[index],
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
                                                      seState(() {
                                                        totdroping=totdroping-1;
                                                        _controller1.removeAt(index);
                                                        _droptime.removeAt(index);
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

                        //ROW BUTTON
                        Center(
                          child: Container(
                            width: SizeConfig.screenWidth*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //save container:
                                InkWell(
                                  onTap: () async {
                                    addboard.clear();
                                    adddrop.clear();
                                    addboardtime.clear();
                                    adddroptime.clear();
                                    _controller.forEach((element) {
                                      addboard.add(element.text);
                                    });
                                    _controller1.forEach((element) {
                                      adddrop.add(element.text);
                                    });
                                    _boardtime.forEach((element) {
                                      addboardtime.add(element.text);
                                    });
                                    _droptime.forEach((element) {
                                      adddroptime.add(element.text);
                                    });
                                    print(addboardtime);
                                    print(adddroptime);


                                    if (travel_name.text.isEmpty||dateController.text.isEmpty
                                    || selectedValue1.toString()==""||selectedValue2.toString()==""||
                                        clock_time1.text.isEmpty||clock_time2.text.isEmpty||contact_no.text.isEmpty||
                                        vehicale_no.text.isEmpty||price.text.isEmpty||addboard.isEmpty||adddrop.isEmpty||
                                        adddroptime.isEmpty||addboardtime.isEmpty
                                    ){
                                      Fluttertoast.showToast( msg: "Fill All data...");
                                    }
                                    else {

                                      travel_add_data_fun(addboard,adddrop,addboardtime,adddroptime);
                                    }
                                  },
                                  //save conatainer:
                                  child: Container(
                                    height: SizeConfig.screenHeight * 0.050,
                                    width: SizeConfig.screenWidth * 0.4,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Text(
                                      "Save",
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
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
    );
  }


  Future<void>travel_add_data_fun(List board,List drop,List addboardtime,List adddroptime) async {
    await _fstore_travel.collection("Travels").add({
      "Date" :dateController.text==""|| dateController.text==null ?DateFormat("dd/MM/yyyy").format(DateTime.now()):dateController.text,
      "travel_name": travel_name.text,
      "from": selectedValue1.toString(),
      "to": selectedValue2.toString(),
      "depachar_time": clock_time1.text,
      "arrived_time": clock_time2.text,
      "contact_no": contact_no.text,
      "vehicale_no": vehicale_no.text,
      "price":price.text,
      "boardingpoint":board,
      "boardtime":addboardtime,
      "dropingpoint":drop,
      "droptime":adddroptime,
      "lowerseats":List.generate(22, (index) => false),
      "upperseats":List.generate(22, (index) => false),
    }).then((value) {
      dateController.clear();
      travel_name.clear();
      clock_time1.clear();
      clock_time2.clear();
      contact_no.clear();
      vehicale_no.clear();
      price.clear();
      selectedValue1.toString()=="";
      selectedValue2.toString()=="";
      Get.back();
    });
  }


  delete_fun(index) async {
    await _fstore_travel.collection("Travels").doc(index.toString()).delete();
  }

  showdata(docid) async {



  }

  @override
  void initState() {
    getloc_fun();
    gettottrav();
    get_vehicale_time_fun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(gradient: theemecolor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Travel details",
            style: textstyle.travelstyle,
          ),

        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total Travel: ${ tottrav.toString()}",
                  style: textstyle.travelstyle,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.020,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _fstore_travel.collection("Travels").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(update_bus_details(
                                realindex: index.toString(),
                                index:snapshot.data!.docs[index].id.toString(),
                                udate:snapshot.data!.docs[index].get("Date").toString(),
                                utname:snapshot.data!.docs[index].get("travel_name").toString(),
                                ufrom:snapshot.data!.docs[index].get("from").toString(),
                                uto:snapshot.data!.docs[index].get("to").toString(),
                                uarrived:snapshot.data!.docs[index].get("arrived_time").toString(),
                                udrop:snapshot.data!.docs[index].get("depachar_time").toString(),
                                ucontact:snapshot.data!.docs[index].get("contact_no").toString(),
                                uvehicale:snapshot.data!.docs[index].get("vehicale_no").toString(),
                                price:snapshot.data!.docs[index].get("price").toString(),
                              ));
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                width: SizeConfig.screenWidth * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.5))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    //DELETE
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              delete_fun(snapshot
                                                  .data!.docs[index].id
                                                  .toString());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                decoration: BoxDecoration(

                                                  shape: BoxShape.circle,
                                                  color: Colors.black.withOpacity(0.4)
                                                ),
                                                child: Icon(Icons.delete,color: Colors.white,size: 15,))),
                                      ],
                                    ),

                                    //Date Container;:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Date :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("Date").toString()}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //travel Container;:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Travle Name :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("travel_name").toString()}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //from Container:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "From :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index].get("from").toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //to container:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "To :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index].get("to").toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    //start time
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "depachar time :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("depachar_time")}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //stop  time container:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "arrived time :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("arrived_time")}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //  contact deatails:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Contact No :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("contact_no").toString()}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //  vehical No:
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Vehical No :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("vehicale_no").toString()}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    //PRICE
                                    Container(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Price :",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[index].get("price").toString()}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: SizeConfig.screenHeight * 0.030,
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.020,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            travel_alret_adddata_fun();
          },
          child: floating_container(),
        ),
      ),
    );
  }


}
