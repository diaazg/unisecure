import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class attentList extends StatefulWidget {
  const attentList({Key? key}) : super(key: key);

  @override
  State<attentList> createState() => _attentListState();
}

class _attentListState extends State<attentList> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/agentBack.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Attent list',style: GoogleFonts.poppins(fontSize: 30,color: Colors.white),),
                GestureDetector(onTap: (){},child: Text('view all',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),))
              ],
            ),
            Container(
              height: size.height*0.7,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                          width: size.width*0.7,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                    color: Colors.red
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Zellagui diaa',style: GoogleFonts.poppins(fontSize: 20),),
                                  Text('walk',style: GoogleFonts.poppins(fontSize: 15,color: Colors.black),),
                                ],
                              ),
                              Center(child: Text('Student',style: GoogleFonts.poppins(fontSize: 14,color: Colors.black54),)),

                            ],
                          ),
                        ),
                        Image.asset("images/walkred.png",height: 40,width: 40,)
                      ],
                    );
                  }),
            ),

          ],
        ),
      ),
    ));
  }
}
