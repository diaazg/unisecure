import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginPage.dart';
import 'WalOrDrv.dart';

class UnivOrRes extends StatefulWidget {
  const UnivOrRes({Key? key}) : super(key: key);

  @override
  State<UnivOrRes> createState() => _UnivOrResState();
}

class _UnivOrResState extends State<UnivOrRes> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SafeArea(child: Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(height: size.height*0.51,top: 0,right: 0,left: 0,child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: size.height*0.5,width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/Group 14.png"),
                        fit: BoxFit.cover),
                  ),
                  // Foreground widget here
                ),
              ),),
             Positioned(
               height: size.height*0.5
             ,bottom: 0,left: 0,right:0,child:  GestureDetector(
               onTap: (){

               },
               child: Container(
                 decoration: const BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage("images/Group 131.png"),
                       fit: BoxFit.cover),
                 ),
                 // Foreground widget here
               ),
             )),

              Center(
                child: GestureDetector(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Where do you want to enter',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    height: 60,
                    width: size.width*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                        color: Color(0xFFB74848)
                    ),
                  ),
                ),
              )



            ],
          ),
        ),
      ),
    ));
  }
}
