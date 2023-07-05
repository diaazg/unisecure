import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'Models/Excel Models.dart';
import 'controller/auth_controller.dart';
import 'controller/crud_controller.dart';
import 'listView.dart';
import 'package:get/get.dart';
import 'fonctionsPrincipal.dart';

class excelPgae extends StatefulWidget {
  const excelPgae({Key? key}) : super(key: key);

  @override
  State<excelPgae> createState() => _excelPgaeState();
}

class _excelPgaeState extends State<excelPgae> {
  List<UserInformationPerm> modelListPerm = [];
  List<UserInformationTempo> modelListTempo = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadExcelToDataBase(1, modelListPerm);
                },
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text('upload perm list',
                        style: GoogleFonts.ubuntu(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  uploadExcelToDataBase(2, modelListTempo);
                },
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text('upload temporal list',
                        style: GoogleFonts.ubuntu(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (modelListPerm.isNotEmpty) {
                      CrudController.insController.uploadPerList(modelListPerm);
                    }
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text('upload permanent to data base ',
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                          )),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    if (modelListTempo.isNotEmpty) {
                      CrudController.insController.uploadTempList(modelListTempo);
                    }
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text('upload tempo to data base ',
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                          )),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Get.put(AuthController());
                    AuthController.instance.SignOut();
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text('sign out',
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                          )),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Get.to(ViewData());
                  },
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text('show data',
                          style: GoogleFonts.ubuntu(
                            fontSize: 20,
                          )),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
