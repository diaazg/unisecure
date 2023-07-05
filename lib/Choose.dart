import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            height: 40,
            width: size.width*0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Scan',style: GoogleFonts.poppins(color:Color(0xFFB74848) ,fontSize: 13),),
                  Image.asset("images/scan.png",height: 15,width: 15,),

                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Container(
            height: 40,
            width: size.width*0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Scan',style: GoogleFonts.poppins(color:Color(0xFFB74848) ,fontSize: 13),),
                  Image.asset("images/scan.png",height: 15,width: 15,),

                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Container(
            height: 40,
            width: size.width*0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Scan',style: GoogleFonts.poppins(color:Color(0xFFB74848) ,fontSize: 13),),
                  Image.asset("images/scan.png",height: 15,width: 15,),

                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
