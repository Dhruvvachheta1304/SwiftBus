import 'dart:typed_data';
import 'dart:io';
import 'package:bluebus/screen_pages/pdf/pdf_invoice_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bluebus/common_pages/common_textstyle_page.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../common_pages/common_list.dart';
import '../../common_pages/height_width_page.dart';
import 'invoice.dart';

class paymentdone extends StatefulWidget {
  String? docid,docindx;


  paymentdone({required this.docid,required this.docindx});

  @override
  State<paymentdone> createState() => _paymentdoneState();
}

class _paymentdoneState extends State<paymentdone> {

  bool isvisible=false;
  String? travname,from,to,deptime,arrtime,price,date,boardpoint,droppoint;
  getdata() async {

    print(widget.docindx.toString());

    CollectionReference travel_collection = FirebaseFirestore.instance.collection("Travels");
    QuerySnapshot _search_qeurysnapshot = await travel_collection.get();
    setState(() {

      travname=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["travel_name"];
      from=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["from"];
      to=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["to"];
      // deptime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["depachar_time"];
      // arrtime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["arrived_time"];
      price=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["price"];
      date=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["Date"];
      for(int i=0;i<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["boardingpoint"].length;i++){
        boardpoint=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["boardingpoint"][int.parse(sfboardingpoint.toString())];
        deptime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["boardtime"][int.parse(sfboardingpoint.toString())];
      }
      for(int i=0;i<_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["dropingpoint"].length;i++){
        droppoint=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["dropingpoint"][int.parse(sfdropingpoint.toString())];
        arrtime=_search_qeurysnapshot.docs[int.parse(widget.docindx.toString())]["droptime"][int.parse(sfdropingpoint.toString())];
      }
    });

    // print(uppseat);
  }


  @override
  void initState() {
    getdata();
    super.initState();
  }

  // Future<void>_createPDF()async {
  //   PdfDocument document= PdfDocument();
  //   document.pages.add();
  //   File('TrueType.pdf').writeAsBytes(await document.save());
  //   // List<int> bytes = document.save();
  //   document.dispose();
  //   // savePdfFile(bytes,"Output.pdf");
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("HAVE A SAFE JOURNEY...",style: TextStyle(color: Colors.black,fontSize: 19),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [

            Center(
              child: Container(
                width: SizeConfig.screenWidth*0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                                color: Colors.black,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: SizeConfig.screenWidth*0.001,
                              color: Colors.black,
                            ),
                          ) ,
                          Container(
                            height: SizeConfig.screenHeight*0.030,
                            width: SizeConfig.screenWidth*0.030,
                            decoration: BoxDecoration(
                                color: Colors.black,
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
                    ),
                    SizedBox(height: SizeConfig.screenHeight*0.010,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () async {

              // final data = await service.createHelloWorld();
              // service.savePdfFile("invoice_", data);

              // _createPDF();


              final PdfDocument document = PdfDocument();
              document.pages.add().graphics.drawString(
                  'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
                  brush: PdfSolidBrush(PdfColor(0, 0, 0)),
                  bounds: const Rect.fromLTWH(0, 0, 150, 20));
              File('HelloWorld.pdf').writeAsBytes(await document.save());
              document.dispose();
              // final date = DateTime.now();
              // final dueDate = date.add(Duration(days: 7));
              // final invoice = Invoice(
              //
              //   info: InvoiceInfo(
              //     date: date,
              //     dueDate: dueDate,
              //     description: 'My description...',
              //     number: '${DateTime.now().year}-9999',
              //   ),
              //   items: [
              //     InvoiceItem(
              //       description: 'Coffee',
              //       date: DateTime.now(),
              //       quantity: 3,
              //       vat: 0.19,
              //       unitPrice: 5.99,
              //     ),
              //     InvoiceItem(
              //       description: 'Water',
              //       date: DateTime.now(),
              //       quantity: 8,
              //       vat: 0.19,
              //       unitPrice: 0.99,
              //     ),
              //     InvoiceItem(
              //       description: 'Orange',
              //       date: DateTime.now(),
              //       quantity: 3,
              //       vat: 0.19,
              //       unitPrice: 2.99,
              //     ),
              //     InvoiceItem(
              //       description: 'Apple',
              //       date: DateTime.now(),
              //       quantity: 8,
              //       vat: 0.19,
              //       unitPrice: 3.99,
              //     ),
              //     InvoiceItem(
              //       description: 'Mango',
              //       date: DateTime.now(),
              //       quantity: 1,
              //       vat: 0.19,
              //       unitPrice: 1.59,
              //     ),
              //     InvoiceItem(
              //       description: 'Blue Berries',
              //       date: DateTime.now(),
              //       quantity: 5,
              //       vat: 0.19,
              //       unitPrice: 0.99,
              //     ),
              //     InvoiceItem(
              //       description: 'Lemon',
              //       date: DateTime.now(),
              //       quantity: 4,
              //       vat: 0.19,
              //       unitPrice: 1.29,
              //     ),
              //   ],
              // );
              //
              // final pdfFile = await PdfInvoiceApi.generate(invoice);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

              child: Text("GENERATE PDF",style: TextStyle(
                color: Colors.white,fontSize: 18),),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
