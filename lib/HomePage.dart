import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'screens/affiche.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _scan()async{

    await FlutterBarcodeScanner.scanBarcode("#000000", "Cencel", true, ScanMode.BARCODE).then((value) =>setState(()=>_userID=value));

  }
  String _userID = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: ()=>_scan(),
          child: Container(
            height: size.height * 0.2,
            width: size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child:
              Text(_userID,
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                  )),
            ),
          ),
        ),
      ),
    ));
  }
}
