import 'package:bluebus/common_pages/common_list.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:bluebus/common_pages/common_theem_colour_page.dart';
import 'package:bluebus/common_pages/height_width_page.dart';
import 'package:bluebus/screen_pages/homepage.dart';
import 'package:bluebus/screen_pages/passanger_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drping_page.dart';

class buy_ticket_page extends StatefulWidget {
  String? docid,docindx;


  buy_ticket_page({required this.docid,required this.docindx});

  @override
  State<buy_ticket_page> createState() => _buy_ticket_pageState();
}

class _buy_ticket_pageState extends State<buy_ticket_page> with TickerProviderStateMixin {

  TabController? tabController;
  CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
  List getlowseat=[];
  List getuppseat=[];
  String? date,trvname;



  gettotseats() async {

    setState(() {
      getlowseat.clear();
      getuppseat.clear();
    });


    int count=0;
    int count1=0;

    // QuerySnapshot travel_collection =await FirebaseFirestore.instance.collection("Travels").doc(widget.docid).get();
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();



    setState(() {
      date=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["Date"];
      trvname=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["travel_name"];
      for(int a=0;a<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["lowerseats"].length;a++){
        if(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["lowerseats"][a]==true){
          getlowseat.add(
              a==0?0:
              a==1?2:
              a==2?3:
              a==3?4:
              a==4?6:
              a==5?7:
              a==6?8:
              a==7?10:
              a==8?11:
              a==9?12:
              a==10?14:
              a==11?15:
              a==12?16:
              a==13?18:
              a==14?19:
              a==15?20:
              a==16?22:
              a==17?23:
              a==18?24:
              a==19?25:
              a==20?26:
              a==21?27:
              50
          );
          count=count+1;
          print(count);
        }

      }

      for(int b=0;b<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["upperseats"].length;b++){
        if(_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["upperseats"][b]==true){
          getuppseat.add(
              b==0?0:
              b==1?2:
              b==2?3:
              b==3?4:
              b==4?6:
              b==5?7:
              b==6?8:
              b==7?10:
              b==8?11:
              b==9?12:
              b==10?14:
              b==11?15:
              b==12?16:
              b==13?18:
              b==14?19:
              b==15?20:
              b==16?22:
              b==17?23:
              b==18?24:
              b==19?25:
              b==20?26:
              b==21?27:
              50
          );
        }
      }
    });
    // print(getlowseat);
    print(getuppseat);
  }

  @override
  void initState() {
    gettotseats();
    tabController=TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    final h= MediaQuery.of(context).size.height;
    final w= MediaQuery.of(context).size.width;


    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          gradient: theemecolor
      ),
      child:  Scaffold(
        backgroundColor:Colors.white10,

        appBar: AppBar(
          title: GestureDetector(
              onTap: (){
                gettotseats();
              },
              child: Text(trvname.toString(), style: textstyle.travelstyle,)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: (){
                Get.offAll(home_page());
              },
              child: Icon(Icons.arrow_back, size: 25,color: Colors.black,)),

          bottom: PreferredSize(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text("Date: ${date.toString()}", style: textstyle.seat_text,),
                TabBar(
                  controller: tabController,
                  indicatorColor: Colors.white,
                  isScrollable: false,

                  tabs: [
                    Text("Lower", style: textstyle.upperstyle,),
                    Text("Upper", style: textstyle.upperstyle),
                  ],
                )
              ],
            ),
            preferredSize: Size.fromHeight(30.0),
          ),

        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h*0.010,),

            Expanded(
                child: Container(
                  width: w,
                  color: Colors.transparent,
                  child: TabBarView(
                    controller: tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: h*0.9,
                            width: w*0.5,
                            color: Colors.transparent,

                            child: GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 10,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                childAspectRatio: 0.55,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                children: List.generate(28, (index){
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {

                                        if(getlowseat.contains(index)){

                                        }
                                        else {
// l-1:
                                          if (index == 0) {
                                            if (commonlistindx.contains("L-1")) {
                                              commonlistindx.remove("L-1");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-1");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

// l-2
                                          if (index == 2) {
                                            if (commonlistindx.contains(
                                                "L-2")) {
                                              commonlistindx.remove("L-2");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-2");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-3:
                                          if (index == 3) {
                                            if (commonlistindx.contains(
                                                "L-3")) {
                                              commonlistindx.remove("L-3");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-3");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-4:
                                          if (index == 4) {
                                            if (commonlistindx.contains(
                                                "L-4")) {
                                              commonlistindx.remove("L-4");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-4");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-5:
                                          if (index == 6) {
                                            if (commonlistindx.contains(
                                                "L-5")) {
                                              commonlistindx.remove("L-5");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-5");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-6:
                                          if (index == 7) {
                                            if (commonlistindx.contains(
                                                "L-6")) {
                                              commonlistindx.remove("L-6");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-6");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-7:
                                          if (index == 8) {
                                            if (commonlistindx.contains(
                                                "L-7")) {
                                              commonlistindx.remove("L-7");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-7");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-8:
                                          if (index == 10) {
                                            if (commonlistindx.contains(
                                                "L-8")) {
                                              commonlistindx.remove("L-8");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-8");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-9:
                                          if (index == 11) {
                                            if (commonlistindx.contains(
                                                "L-9")) {
                                              commonlistindx.remove("L-9");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-9");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-10:
                                          if (index == 12) {
                                            if (commonlistindx.contains(
                                                "L-10")) {
                                              commonlistindx.remove("L-10");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-10");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-11:
                                          if (index == 14) {
                                            if (commonlistindx.contains(
                                                "L-11")) {
                                              commonlistindx.remove("L-11");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-11");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-12:
                                          if (index == 15) {
                                            if (commonlistindx.contains(
                                                "L-12")) {
                                              commonlistindx.remove("L-12");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-12");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-13:
                                          if (index == 16) {
                                            if (commonlistindx.contains(
                                                "L-13")) {
                                              commonlistindx.remove("L-13");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-13");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-14:
                                          if (index == 18) {
                                            if (commonlistindx.contains(
                                                "L-14")) {
                                              commonlistindx.remove("L-14");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-14");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-15:
                                          if (index == 19) {
                                            if (commonlistindx.contains(
                                                "L-15")) {
                                              commonlistindx.remove("L-15");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-15");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }

//  l-16:
                                          if (index == 20) {
                                            if (commonlistindx.contains(
                                                "L-16")) {
                                              commonlistindx.remove("L-16");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-16");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-17:
                                          if (index == 22) {
                                            if (commonlistindx.contains(
                                                "L-17")) {
                                              commonlistindx.remove("L-17");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-17");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-18:
                                          if (index == 23) {
                                            if (commonlistindx.contains(
                                                "L-18")) {
                                              commonlistindx.remove("L-18");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-18");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-19:
                                          if (index == 24) {
                                            if (commonlistindx.contains(
                                                "L-19")) {
                                              commonlistindx.remove("L-19");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-19");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-20:
                                          if (index == 25) {
                                            if (commonlistindx.contains(
                                                "L-20")) {
                                              commonlistindx.remove("L-20");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-20");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
//  l-21:
                                          if (index == 26) {
                                            if (commonlistindx.contains(
                                                "L-21")) {
                                              commonlistindx.remove("L-21");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-21");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }


                                          if (index == 27) {
                                            if (commonlistindx.contains(
                                                "L-22")) {
                                              commonlistindx.remove("L-22");
                                            } else {
                                              if (commonlistindx1.length+commonlistindx.length<= 3) {
                                                commonlistindx.add("L-22");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "you can only book 4 seat",
                                                    toastLength: Toast
                                                        .LENGTH_SHORT,
                                                    gravity: ToastGravity
                                                        .BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors
                                                        .red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );
                                              }
                                            }
                                          }
                                        }

                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                          getlowseat.contains(index)?Colors.red:
                                          commonlistindx.contains("L-1")&&index==0 ||
                                              commonlistindx.contains("L-2")&&index==2 ||
                                              commonlistindx.contains("L-3")&&index==3 ||
                                              commonlistindx.contains("L-4")&&index==4 ||
                                              commonlistindx.contains("L-5")&&index==6 ||
                                              commonlistindx.contains("L-6")&&index==7 ||
                                              commonlistindx.contains("L-7")&&index==8 ||
                                              commonlistindx.contains("L-8")&&index==10 ||
                                              commonlistindx.contains("L-9")&&index==11 ||
                                              commonlistindx.contains("L-10")&&index==12 ||
                                              commonlistindx.contains("L-11")&&index==14 ||
                                              commonlistindx.contains("L-12")&&index==15 ||
                                              commonlistindx.contains("L-13")&&index==16 ||
                                              commonlistindx.contains("L-14")&&index==18 ||
                                              commonlistindx.contains("L-15")&&index==19 ||
                                              commonlistindx.contains("L-16")&&index==20||
                                              commonlistindx.contains("L-17")&&index==22 ||
                                              commonlistindx.contains("L-18")&&index==23 ||
                                              commonlistindx.contains("L-19")&&index==24 ||
                                              commonlistindx.contains("L-20")&&index==25||
                                              commonlistindx.contains("L-21")&&index==26 ||
                                              commonlistindx.contains("L-22")&&index==27
                                              ? Colors.green
                                              : index==1 || index==5|| index==9|| index==13|| index==17|| index==21?Colors.transparent:

                                          Colors.white,

                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: index==1 || index==5|| index==9|| index==13|| index==17|| index==21?Colors.transparent:Colors.black)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: h*0.010,
                                            width: w*0.060,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(color: index==1 || index==5|| index==9|| index==13|| index==17|| index==21?Colors.transparent:Colors.black),
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                          ),
                                          SizedBox(height: h*0.010,)
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            ),
                          ),

//text booked
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: h*0.020,
                                    width: w*0.040,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(color: Colors.white)
                                    ),
                                  ),
                                  SizedBox(width: w*0.020,),
                                  Text("Selected",style: textstyle.seat_text, )
                                ],
                              ),

                              SizedBox(height: h*0.020,),
                              Row(
                                children: [
                                  Container(
                                    height: h*0.020,
                                    width: w*0.040,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.white)
                                    ),
                                  ),
                                  SizedBox(width: w*0.020,),
                                  Text("Available",style: textstyle.seat_text, )
                                ],
                              ),

                              SizedBox(height: h*0.020,),
                              Row(
                                children: [
                                  Container(
                                    height: h*0.020,
                                    width: w*0.040,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(color: Colors.white)
                                    ),
                                  ),
                                  SizedBox(width: w*0.020,),
                                  Text("Booked",style: textstyle.seat_text, )
                                ],
                              ),
                            ],
                          ),
                          Container(),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: h*0.9,
                            width: w*0.5,
                            color: Colors.transparent,

                            child: GridView.count(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              childAspectRatio: 0.55,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              children: List.generate(28, (index1){
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {

                                      if(getuppseat.contains(index1)){

                                      }
                                      else{

                                      // l-1:
                                      if(index1==0){
                                        if(commonlistindx1.contains("U-1")){
                                          commonlistindx1.remove("U-1");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-1");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      // l-2
                                      if(index1==2){
                                        if(commonlistindx1.contains("U-2")){
                                          commonlistindx1.remove("U-2");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-2");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-3:
                                      if(index1==3){
                                        if(commonlistindx1.contains("U-3")){
                                          commonlistindx1.remove("U-3");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-3");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-4:
                                      if(index1==4){
                                        if(commonlistindx1.contains("U-4")){
                                          commonlistindx1.remove("U-4");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-4");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-5:
                                      if(index1==6){
                                        if(commonlistindx1.contains("U-5")){
                                          commonlistindx1.remove("U-5");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-5");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-6:
                                      if(index1==7){
                                        if(commonlistindx1.contains("U-6")){
                                          commonlistindx1.remove("U-6");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-6");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-7:
                                      if(index1==8){
                                        if(commonlistindx1.contains("U-7")){
                                          commonlistindx1.remove("U-7");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-7");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-8:
                                      if(index1==10){
                                        if(commonlistindx1.contains("U-8")){
                                          commonlistindx1.remove("U-8");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-8");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-9:
                                      if(index1==11){
                                        if(commonlistindx1.contains("U-9")){
                                          commonlistindx1.remove("U-9");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-9");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-10:
                                      if(index1==12){
                                        if(commonlistindx1.contains("U-10")){
                                          commonlistindx1.remove("U-10");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-10");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-11:
                                      if(index1==14){
                                        if(commonlistindx1.contains("U-11")){
                                          commonlistindx1.remove("U-11");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-11");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-12:
                                      if(index1==15){
                                        if(commonlistindx1.contains("U-12")){
                                          commonlistindx1.remove("U-12");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-12");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-13:
                                      if(index1==16){
                                        if(commonlistindx1.contains("U-13")){
                                          commonlistindx1.remove("U-13");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-13");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-14:
                                      if(index1==18){
                                        if(commonlistindx1.contains("U-14")){
                                          commonlistindx1.remove("U-14");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-14");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-15:
                                      if(index1==19){
                                        if(commonlistindx1.contains("U-15")){
                                          commonlistindx1.remove("U-15");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-15");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-16:
                                      if(index1==20){
                                        if(commonlistindx1.contains("U-16")){
                                          commonlistindx1.remove("U-16");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-16");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-17:
                                      if(index1==22){
                                        if(commonlistindx1.contains("U-17")){
                                          commonlistindx1.remove("U-17");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-17");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-18:
                                      if(index1==23){
                                        if(commonlistindx1.contains("U-18")){
                                          commonlistindx1.remove("U-18");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-18");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-19:
                                      if(index1==24){
                                        if(commonlistindx1.contains("U-19")){
                                          commonlistindx1.remove("U-19");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-19");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-20:
                                      if(index1==25){
                                        if(commonlistindx1.contains("U-20")){
                                          commonlistindx1.remove("U-20");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-20");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      //  l-21:
                                      if(index1==26){
                                        if(commonlistindx1.contains("U-21")){
                                          commonlistindx1.remove("U-21");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-21");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }

                                      //  l-22:
                                      if(index1==27){
                                        if(commonlistindx1.contains("U-22")){
                                          commonlistindx1.remove("U-22");
                                        }else{
                                          if(commonlistindx1.length+commonlistindx.length<= 3){
                                            commonlistindx1.add("U-22");
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "you can only book 4 seat",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        }
                                      }
                                      }

                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            getuppseat.contains(index1)?Colors.red:
                                        commonlistindx1.contains("U-1")&&index1==0 ||
                                            commonlistindx1.contains("U-2")&&index1==2 ||
                                            commonlistindx1.contains("U-3")&&index1==3 ||
                                            commonlistindx1.contains("U-4")&&index1==4 ||
                                            commonlistindx1.contains("U-5")&&index1==6 ||
                                            commonlistindx1.contains("U-6")&&index1==7 ||
                                            commonlistindx1.contains("U-7")&&index1==8 ||
                                            commonlistindx1.contains("U-8")&&index1==10 ||
                                            commonlistindx1.contains("U-9")&&index1==11 ||
                                            commonlistindx1.contains("U-10")&&index1==12 ||
                                            commonlistindx1.contains("U-11")&&index1==14 ||
                                            commonlistindx1.contains("U-12")&&index1==15 ||
                                            commonlistindx1.contains("U-13")&&index1==16 ||
                                            commonlistindx1.contains("U-14")&&index1==18 ||
                                            commonlistindx1.contains("U-15")&&index1==19 ||
                                            commonlistindx1.contains("U-16")&&index1==20||
                                            commonlistindx1.contains("U-17")&&index1==22 ||
                                            commonlistindx1.contains("U-18")&&index1==23 ||
                                            commonlistindx1.contains("U-19")&&index1==24 ||
                                            commonlistindx1.contains("U-20")&&index1==25||
                                            commonlistindx1.contains("U-21")&&index1==26 ||
                                            commonlistindx1.contains("U-22")&&index1==27
                                            ? Colors.green
                                            : index1==1 || index1==5|| index1==9|| index1==13|| index1==17|| index1==21?Colors.transparent:Colors.white,

                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: index1==1 || index1==5|| index1==9|| index1==13|| index1==17|| index1==21?Colors.transparent:Colors.black)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: h*0.010,
                                          width: w*0.060,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(color: index1==1 || index1==5|| index1==9|| index1==13|| index1==17|| index1==21?Colors.transparent:Colors.black),
                                              borderRadius: BorderRadius.circular(12)
                                          ),
                                        ),
                                        SizedBox(height: h*0.010,)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),

                          //text booked
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: h*0.020,
                                    width: w*0.040,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(color: Colors.white)
                                    ),
                                  ),
                                  SizedBox(width: w*0.020,),
                                  Text("Selected",style: textstyle.seat_text, )
                                ],
                              ),

                              SizedBox(height: h*0.020,),
                              Row(
                                children: [
                                  Container(
                                    height: h*0.020,
                                    width: w*0.040,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.white)
                                    ),
                                  ),
                                  SizedBox(width: w*0.020,),
                                  Text("Available",style: textstyle.seat_text, )
                                ],
                              ),

                              SizedBox(height: h*0.020,),
                              Row(
                                children: [
                                  Container(
                                    height: h*0.020,
                                    width: w*0.040,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(color: Colors.white)
                                    ),
                                  ),
                                  SizedBox(width: w*0.020,),
                                  Text("Booked",style: textstyle.seat_text, )
                                ],
                              ),
                            ],
                          ),
                          Container(),
                        ],
                      ),
                    ],
                  ),
                )),

            commonlistindx.isEmpty&&commonlistindx1.isEmpty
                ?Container()
                :Container(
              height: h*0.1,
              width: w,
              color: Colors.blue.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                              Text("Selected Seat:${commonlistindx.toString().replaceAll("[", "").replaceAll("]", "")}${commonlistindx1.isEmpty?"":", "}${commonlistindx1.toString().replaceAll("[", "").replaceAll("]", "")}", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),)
                              // :Text("Selected seat :", style:GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15), ),

                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: () async {



                        // print(updateupseat);
                        Get.to(pickup_drop_page(docid: widget.docid,docindx: widget.docindx,));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: Text("SELECTED BORDING & DROPPING PAGE"),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }
}

