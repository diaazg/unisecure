import 'package:excel/excel.dart';

import 'package:file_picker/file_picker.dart';

import 'dart:io';

import 'Models/Excel Models.dart';

//if we put 1 as input that's mean upload permanent list
// else if we put 2 that's mean upload temporal list
// the list should be empty
understandFunction()async {
  final pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
    allowMultiple: false,
  );

  /// file might be picked

  if (pickedFile != null) {
    var file = '${pickedFile.files.first.path}';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print("\n");
      print(excel.tables[table]!.maxCols);
      print("\n");
      print(excel.tables[table]!.maxRows);
      int i;
      for (i = 1; i < excel.tables[table]!.maxRows; i++) {

        print("Roooow $i");
        print("\n");
        print("\n");
        print("\n");
        print(
            'ID : ${excel.tables[table]!.row(i).elementAt(0)?.value.toString()}      name : ${excel.tables[table]!.row(i).elementAt(1)?.value.toString()}     Nature : ${excel.tables[table]!.row(i).elementAt(2)?.value.toString()}');
        var informations;// creat it in page
        informations.add(UserInformationPerm(
            id: excel.tables[table]!
                .row(i)
                .elementAt(0)
                ?.value
                .toString(),
            userName: excel.tables[table]!
                .row(i)
                .elementAt(1)
                ?.value
                .toString(),
            userNature: excel.tables[table]!
                .row(i)
                .elementAt(2)
                ?.value
                .toString()));
        print("\n");
      }
    }
  }
}
uploadExcelToDataBase(int choose,List modelList)async {
  final pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
    allowMultiple: false,
  );

  /// file might be picked

  if (pickedFile != null) {
    var file = '${pickedFile.files.first.path}';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      int i;
      for (i = 1; i < excel.tables[table]!.maxRows; i++) {
        if(choose==1){
          modelList.add(UserInformationPerm(
              id: excel.tables[table]!
                  .row(i)
                  .elementAt(0)
                  ?.value
                  .toString(),
              userName: excel.tables[table]!
                  .row(i)
                  .elementAt(1)
                  ?.value
                  .toString(),
              userNature: excel.tables[table]!
                  .row(i)
                  .elementAt(2)
                  ?.value
                  .toString()));
        }else{
          modelList.add(UserInformationTempo(
              id: excel.tables[table]!
                  .row(i)
                  .elementAt(0)
                  ?.value
                  .toString(),
              userName: excel.tables[table]!
                  .row(i)
                  .elementAt(1)
                  ?.value
                  .toString(),
              userNature: excel.tables[table]!
                  .row(i)
                  .elementAt(2)
                  ?.value
                  .toString(), startValidity: excel.tables[table]!
              .row(i)
              .elementAt(3)
              ?.value
              .toString() , endValidity:  excel.tables[table]!
              .row(i)
              .elementAt(4)
              ?.value
              .toString()));
        }

      }
    }
  }
}