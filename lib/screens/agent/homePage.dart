import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mastercoding/controller/crud_controller.dart';
import 'package:searchfield/searchfield.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mastercoding/controller/auth_controller.dart';
import 'package:mastercoding/Models/Excel Models.dart';

class homePageAgent extends StatefulWidget {
  const homePageAgent({Key? key}) : super(key: key);

  @override
  State<homePageAgent> createState() => _homePageAgentState();
}

class _homePageAgentState extends State<homePageAgent> {
  late Timer _timer;
  int _fin = 166;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    DateTime timeNow = DateTime.now();
    print(timeNow.hour);
    print(timeNow.minute);
    print("hhhhhhhhhhhhhhhhh");
    int cmp = timeNow.minute * 3 + timeNow.hour * 5;
    print("thissssssssssssssss $cmp");
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          timeNow = DateTime.now();
          cmp = timeNow.minute * 3 + timeNow.hour * 5;
          print(cmp);
          if (cmp == _fin || cmp >= _fin) {
            print("maaaaaaaaaaaaax");
          } else {
            print("miiiiiiiiiiiiiiiiiin");
          }
        },
      ),
    );
  }

  String _userID = "";
  String nature = "not find";
  String start = "";
  String end = "";

  String? nom;
  String? error;
  String? state;


  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cencel", true, ScanMode.BARCODE)
        .then((value) => setState(() => _userID = value));
    Get.put(CrudController());
    List permList = CrudController.insController.getterPerm;
    List tempoList = CrudController.insController.getterTempo;
    int tempoInd;
    int permInd;
    bool find = false;
    permList.forEach((e) async {
      if (e.id == _userID.toString()) {
        find = true;

        print(e.id.toString());
        nature = _userID;
        permInd = permList.indexOf(e);
        nom = permList[permInd].userName.toString();
        nature = permList[permInd].userNature;
        Get.put(CrudController());
        state = await CrudController.insController.getState(nature, _userID);
        print("${_userID} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print(permList[permInd].userName.toString());
      }
    });
    error = "Unknown";
    if (!find) {
      tempoList.forEach((e) async {
        if (e.id == _userID.toString()) {
          tempoInd = tempoList.indexOf(e);
          String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          end = tempoList[tempoInd].endValidity;
          DateTime dt1 = DateTime.parse("$currentDate 00:00:00");
          DateTime dt2 =
              DateTime.parse("${end.toString().substring(0, 10)} 00:00:00");
          if (dt1.isBefore(dt2) || dt1.isAtSameMomentAs(dt2)) {
            find = true;
            nature = _userID;
            nom = tempoList[tempoInd].userName.toString();
            nature = tempoList[tempoInd].userNature;
            start = tempoList[tempoInd].startValidity;
            end = tempoList[tempoInd].endValidity;
            Get.put(CrudController());
            state =
                await CrudController.insController.getState(nature, _userID);
          } else {
            error = "End of validity";
          }
        }
      });
    }
    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        find
                            ? "name : $nom \n matricule : $_userID \n ${start.toString().substring(0, 10)} \n ${end.toString().substring(0, 10)}"
                            : error!,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 16.0),
                      find
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: const BorderSide(
                                                  color: Colors.green)))),
                                  onPressed: () {
                                    print(state);
                                    if (state == "in") {
                                      Get.put(CrudController());
                                      CrudController.insController
                                          .updateState("out", _userID, nature);
                                    } else {
                                      Get.put(CrudController());
                                      CrudController.insController
                                          .updateState("in", _userID, nature);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 40),
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: const BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 40),
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ],
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.not_interested,
                                color: Colors.red,
                              ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Affiche(code: _userID)));
  }
  _recherche(String id)async{
    _userID=id;
    Get.put(CrudController());
    List permList = CrudController.insController.getterPerm;
    List tempoList = CrudController.insController.getterTempo;
    int tempoInd;
    int permInd;
    bool find = false;
    permList.forEach((e) async {
      if (e.id == _userID.toString()) {
        find = true;

        print(e.id.toString());
        nature = _userID;
        permInd = permList.indexOf(e);
        nom = permList[permInd].userName.toString();
        nature = permList[permInd].userNature;
        Get.put(CrudController());
        state = await CrudController.insController.getState(nature, _userID);
        print("${state} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print("${_userID} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print(permList[permInd].userName.toString());
      }
    });
    if(find){
      Get.dialog(
        Dialog(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          find
                              ? "name : $nom \n matricule : $_userID \n"
                              : error!,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 16.0),
                        find
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.green),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: Colors.green)))),
                              onPressed: () {
                                print(state);
                                if (state == "in") {
                                  Get.put(CrudController());
                                  CrudController.insController
                                      .updateState("out", _userID, nature);
                                } else {
                                  Get.put(CrudController());
                                  CrudController.insController
                                      .updateState("in", _userID, nature);
                                }
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: Colors.red)))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        )
                            : IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.not_interested,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    error = "Unknown";
    if (!find) {
      tempoList.forEach((e) async {
        if (e.id == _userID.toString()) {
          tempoInd = tempoList.indexOf(e);
          String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          end = tempoList[tempoInd].endValidity;
          DateTime dt1 = DateTime.parse("$currentDate 00:00:00");
          DateTime dt2 =
          DateTime.parse("${end.toString().substring(0, 10)} 00:00:00");
          if (dt1.isBefore(dt2) || dt1.isAtSameMomentAs(dt2)) {
            find = true;
            nature = _userID;
            nom = tempoList[tempoInd].userName.toString();
            nature = tempoList[tempoInd].userNature;
            start = tempoList[tempoInd].startValidity;
            end = tempoList[tempoInd].endValidity;
            Get.put(CrudController());
            state =
            await CrudController.insController.getState(nature, _userID);
          } else {
            error = "End of validity";
          }
        }
      });
  }
    if(find){
      Get.dialog(
        Dialog(
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          find
                              ? "name : $nom \n matricule : $_userID \n ${start.toString().substring(0, 10)} \n ${end.toString().substring(0, 10)}"
                              : error!,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 16.0),
                        find
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.green),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: Colors.green)))),
                              onPressed: () {
                                print(state);
                                if (state == "in") {
                                  Get.put(CrudController());
                                  CrudController.insController
                                      .updateState("out", _userID, nature);
                                } else {
                                  Get.put(CrudController());
                                  CrudController.insController
                                      .updateState("in", _userID, nature);
                                }
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: Colors.red)))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        )
                            : IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.not_interested,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
  @override

  void initState() {

    // TODO: implement initState
    
    super.initState();


    //startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(preferredSize: Size(size.width, 60), child: Container(
            height: 60,
            width: size.width,
            decoration: const BoxDecoration(
                color: Color(0xFFB74848)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Security cameras',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 20),
                  ),
                  Image.asset(
                    "images/Rectangle 78.png",
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
          )),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/agentBack.png"), fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Permanent visitor',
                  style:
                  GoogleFonts.poppins(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  width: size.width * 0.8,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: SearchField(
                    searchStyle: TextStyle(fontSize: 20),
                    searchInputDecoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    suggestions: CrudController.insController.getterPerm
                        .map((el) => SearchFieldListItem(el.userName!,
                        child: GestureDetector(
                          onTap: (){
                            _recherche(el.id!);
                          },
                          child: Container(
                            height: 20,
                            width: 100,
                            color: Colors.white,
                            child: Center(
                              child: Text(el.userName!),
                            ),
                          ),
                        )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Temporal visitor',
                  style:
                  GoogleFonts.poppins(fontSize: 30, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  width: size.width * 0.8,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: SearchField(
                    searchStyle: TextStyle(fontSize: 20),
                    searchInputDecoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                    suggestions: CrudController.insController.getterTempo
                        .map((el) => SearchFieldListItem(el.userName!,
                        child: GestureDetector(
                          onTap: (){
                            _recherche(el.id!);
                          },
                          child: Container(
                            height: 20,
                            width: 100,
                            color: Colors.white,
                            child: Center(
                              child: Text(el.userName!),
                            ),
                          ),
                        )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(
                              right: 20.0),
                          child: const Divider(thickness: 2,
                            color: Colors.white,
                            height: 36,
                          )),
                    ),
                    const Text("OR",style: TextStyle(color: Colors.white),),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 20.0),
                          child: const Divider(
                            thickness: 2,
                            color: Colors.white,
                            height: 36,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => _scan(),
                  child: Container(
                    height: 50,
                    width: size.width *0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Scan',
                            style: GoogleFonts.poppins(
                                color: Color(0xFFB74848), fontSize: 20),
                          ),
                          Image.asset(
                            "images/scan.png",
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            )
          ],
        ),
      ),
    ));
  }
}
