

import 'package:bluebus/common_pages/common_list.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/screen_pages/passanger_details_page.dart';
import 'package:bluebus/screen_pages/thirdpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class pickup_drop_page extends StatefulWidget {
  String? docid,docindx;


  pickup_drop_page({required this.docid,required this.docindx});

  @override
  State<pickup_drop_page> createState() => _pickup_drop_pageState();
}

class _pickup_drop_pageState extends State<pickup_drop_page> with TickerProviderStateMixin{

  TabController?tabController;
  int?group_num;
  int?group_num1;

  List boardingpoint=[];
  List dropingpoint=[];
  getdropvoard() async {
    boardingpoint.clear();
    dropingpoint.clear();
    CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    for(int a=0;a<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["boardingpoint"].length;a++){
      setState(() {
        boardingpoint.add(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["boardingpoint"][a]);
      });
    }
    for(int a=0;a<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["dropingpoint"].length;a++){
      setState(() {
        dropingpoint.add(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["dropingpoint"][a]);
      });
    }
    print(boardingpoint);
    print(dropingpoint);
  }
  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getdropvoard();
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Container(
      height:SizeConfig.screenHeight ,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        gradient: theemecolor
      ),

      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: (){
                getdropvoard();
              },
              child: Text("Ahemdabad to Ankleshawar", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
              child: Icon(Icons.arrow_back, color: Colors.black, size: 25,)),
          bottom: PreferredSize(
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.white,
              isScrollable: false,
              tabs: [
                Text("PIckUp Point", style: textstyle.upperstyle),
                Text("Droping Point", style:textstyle.upperstyle ),
              ],
            ),
            preferredSize:Size.fromHeight(30.0),
          ),

        ),

        backgroundColor: Colors.transparent,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //listview of pickup & dropping point:
            Expanded(
              child: Container(
                width: SizeConfig.screenWidth,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      color:  Colors.transparent,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        physics:BouncingScrollPhysics(),
                        itemCount: boardingpoint.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.topCenter,
                            height: SizeConfig.screenHeight*0.080,
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Container(
                                 height: SizeConfig.screenHeight*0.1,
                                 width: SizeConfig.screenWidth*0.9,
                                 child: RadioListTile(
                                   activeColor: Colors.black,
                                   value: index,
                                   groupValue: group_num,
                                   onChanged: (value){
                                       setState(() {
                                         group_num=value;
                                       });
                                     },
                                   title: Container(
                                       color: Colors.transparent,
                                       child: Text(boardingpoint[index].toString(), style: textstyle.pickupstyle,)),

                                     ),
                               )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: SizeConfig.screenHeight*0.010,);
                        },

                      ),
                    ),

                    Container(
                      width: SizeConfig.screenWidth,
                      color:  Colors.transparent,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        physics:BouncingScrollPhysics(),
                        itemCount: dropingpoint.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index1) {
                          return Container(
                            alignment: Alignment.topCenter,
                            height: SizeConfig.screenHeight*0.080,
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: SizeConfig.screenHeight*0.1,
                                  width: SizeConfig.screenWidth*0.9,
                                  child: RadioListTile(
                                    activeColor: Colors.black,
                                    value: index1,
                                    groupValue: group_num1,
                                    onChanged: (value){
                                      setState(() {
                                        group_num1=value;
                                      });
                                    },
                                    title: Container(
                                        color: Colors.transparent,
                                        child: Text(dropingpoint[index1].toString(), style: textstyle.pickupstyle,)),

                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: SizeConfig.screenHeight*0.010,);
                        },

                      ),
                    ),



                  ],
                ),
              ),
            ),


            group_num!=null&&group_num1!=null?
                 Container(
                   child: Column(
                     children: [
                       Container(
                         height: SizeConfig.screenHeight*0.050,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             commonlistindx.isNotEmpty
                                 ?Text("Selected Seat:${commonlistindx.toString().replaceAll("[", "").replaceAll("]", "")}${commonlistindx1.isEmpty?"":", "}${commonlistindx1.toString().replaceAll("[", "").replaceAll("]", "")}", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),)
                                 :Text("Selected seat :", style:GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15), ),

                           ],
                         ),
                       ),
                       // process container:
                       InkWell(
                         onTap: (){
                           setState(() {
                             sfboardingpoint=group_num.toString();
                             sfdropingpoint=group_num1.toString();
                           });
                           Get.to(passanger_details_page(docindx: widget.docindx,docid: widget.docid,));
                         },
                         child: Container(
                           height: SizeConfig.screenHeight*0.060,
                           alignment: Alignment.center,
                           color: Colors.blue,
                           child:Text("PROCESS",style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),),
                         ),
                       )
                     ],
                   ),
                 ):Container()
          ],
        ),
      ),
    );
  }





}
