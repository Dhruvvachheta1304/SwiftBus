
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class tiket_page extends StatefulWidget {
  const tiket_page({Key? key}) : super(key: key);

  @override
  State<tiket_page> createState() => _tiket_pageState();
}

class _tiket_pageState extends State<tiket_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40,),// Your Ticket:
              Container(
                height:30,
                width: MediaQuery.of(context).size.width*0.9,
                color: Colors.white10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black,size: 25,)),
                    SizedBox(width: 95,),
                    Text("Your Ticket ", style: TextStyle(color: Colors.black, fontSize: 20),),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              // 174 full  container :
              Container(
                // height: 500,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [

                      // 174-36 container:
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xff222A41),
                          borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10) )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("174-36-XXXX",style: TextStyle(color: Colors.white, fontSize: 13),),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      // 11:45 container:
                      Container(
                        // height: 100,
                        color: Colors.white10,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // height: 80,

                              color: Colors.white10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("11:45", style: TextStyle(color: Colors.black, fontSize: 15),),
                                  SizedBox(height: 5,),
                                  Text("457 Castel street", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize:15 ),),
                                ],
                              ),
                            ),
                            Container(
                              // height: 80,
                              color: Colors.white10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("10:30", style: TextStyle(color: Colors.black, fontSize: 15),),
                                  SizedBox(height: 5,),
                                  Text("Universal Airport", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize:15 ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      // orange and blue container:
                      Container(
                        height: 30,
                        color: Colors.white10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(width: 2,),

                            // dotteded line container:
                            Container(
                              child: Row(
                                children: [
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength: 125,
                                    lineThickness: 3.0,
                                    dashLength: 3.0,
                                    dashColor: Colors.blue,
                                    dashGradient: [Colors.orange, Colors.blue],
                                    dashRadius: 5.0,
                                    dashGapLength: 2.0,
                                    // dashGapColor: Colors.black,
                                    // dashGapGradient: [Colors.transparent, Colors.transparent],
                                    // dashGapRadius: 0.0,
                                  ),
                                ],
                              ),
                            ),

                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 2,),
                      //date Container:
                      Container(
                        width: MediaQuery.of(context).size.width*0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.1),
                        ),
                       padding: EdgeInsets.symmetric(vertical: 8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           SizedBox(width: 10,),
                           Container(
                             // height: 50,
                             // width: 100,
                             decoration: BoxDecoration(
                               color: Colors.white10,
                             ),
                             child: Padding(
                               padding: const EdgeInsets.symmetric(vertical: 5.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("Date",  style: TextStyle(color: Colors.black, fontSize: 15),),
                                   SizedBox(height: 5,),
                                   Text("22 March 2022",  style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15)
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           Spacer(),
                           Container(
                             // height: 50,
                             // width: 100,
                             color: Colors.white10,
                             child: Padding(
                               padding: const EdgeInsets.symmetric(vertical: 5.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: [
                                   Text("Bus No", style: TextStyle(color: Colors.black, fontSize: 15),),
                                   SizedBox(height: 5,),
                                   Text("4367",style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15))
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(width: 10,),
                         ],
                       ),
                      ),
                      SizedBox(height: 2,),
                      // passsanger container:
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              // height: 50,
                              // width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Passanger ",  style: TextStyle(color: Colors.black, fontSize: 15)),
                                    SizedBox(height: 5,),
                                    Text("Fleece Mariagold",  style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15))
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(width: 150,),
                            Spacer(),
                            Container(
                              // height: 50,
                              // width: 100,
                              color: Colors.white10,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("ID", style: TextStyle(color: Colors.black, fontSize: 15),),
                                    SizedBox(height: 5,),
                                    Text("246-87-XXXX",style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      //  dotted Container:
                      Container(
                        // width: MediaQuery.of(context).size.width*0.9,
                        // height: 50,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
                              ),
                            ),
                            // Container(
                            //   height: 1,
                            //   color: Colors.white10,
                            //   width: MediaQuery.of(context).size.width*0.816,
                            // ),

                            // SizedBox(width: 3,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.80,
                              child: DottedLine(
                                direction: Axis.horizontal,
                                // lineLength: 282,
                                lineThickness: 1.0,
                                dashLength: 5.0,
                                dashColor: Colors.black,
                                // dashGradient: [Colors.orange, Colors.blue],
                                dashRadius: 0.0,
                                dashGapLength: 5.0,
                                // dashGapColor: Colors.black,
                                // dashGapGradient: [Colors.transparent, Colors.transparent],
                                // dashGapRadius: 0.0,
                              ),
                            ),

                            Container(
                              height: 20,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomLeft: Radius.circular(50))
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3,),

                      //  barcode and number container:
                      Container(
                        // height: 100,
                        // width: MediaQuery.of(context).size.width*0.9,
                        color: Colors.white10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              // width: 300,
                              // color: Colors.white10,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/image/barcode img.png"),
                                )
                            ),
                        ),
                            SizedBox(height: 10,),
                            Container(
                              // height: 30,
                              // width: 300,
                              color: Colors.white10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("12345678901234567", style: TextStyle(color: Colors.black, fontSize: 15),),
                                ],
                              ),

                              ),
                            SizedBox(height: 10,),
                            ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // payment container
              Container(
                color: Colors.white10,
                width: MediaQuery.of(context).size.width*0.9,
                child:Row(
                  children: [
                    Container(
                      color: Colors.white10,
                      child: Text("Payment Pethod",style: TextStyle(color: Colors.black, fontSize: 18),),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 30,
                      // color: Colors.white10,
                      decoration: BoxDecoration(
                        // color: Colors.white10,
                        image: DecorationImage(
                          image: AssetImage("assets/image/pen-removebg-preview.png")
                        )
                      ),
                    ),
                    // SizedBox(width: 20,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              // green check full  container:
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),

                      // empty blure container:
                      child: Container(
                        height: 45,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),

                    // star number container:
                    SizedBox(width: 3,),
                    Container(
                      // alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: Colors.white10,

                      ),
                      height: 45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2,),
                          Text("**** **** **** 1234", style: TextStyle(color: Colors.black, fontSize: 15),),
                          Spacer(),
                          Text("Expire on 06/25", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),),
                        ],
                      ),
                    ),
                    SizedBox(width: 60,),
                    // green icon container:
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(Icons.check, size: 15, color: Colors.white,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),

              // Download ticket Container:
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                    color: Color(0xff222A41),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" Download Ticket", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
