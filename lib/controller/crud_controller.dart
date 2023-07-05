import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mastercoding/Models/Excel Models.dart';


class CrudController extends GetxController {
  static CrudController insController = Get.find();
  FirebaseFirestore instance = FirebaseFirestore.instance;
  late CollectionReference permanentReference;
  late CollectionReference temporalReference;
  Rx<List<UserInformationPerm>> permanentList = Rx<List<UserInformationPerm>>([]);
  Rx<List<UserInformationTempo>> temporalList = Rx<List<UserInformationTempo>>([]);

 //getters

  List<UserInformationPerm> get getterPerm=>permanentList.value;
  List<UserInformationTempo> get getterTempo=>temporalList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    permanentReference = instance.collection("permanent");
    temporalReference=instance.collection("temporal");
    permanentList.bindStream(getPermList());
    temporalList.bindStream(getTempoList());


  }

  //upload data
  //upload permanent list
  void uploadPerList(List permanent) async{
    for (var element in permanent) {
      print("${element.id}");
      print("befor");
     await permanentReference.doc(element.id).set({
        'id': element.id,
        'userName': element.userName,
        'userNature': element.userNature
      });
    }
    print("doooone");
  }
  // upload temporal list
  void uploadTempList(List temporal)async{
    for (var element in temporal) {
      print("${element.id}");
      print("befor");
      await temporalReference?.doc(element.id).set({
        'id': element.id,
        'userName': element.userName,
        'userNature': element.userNature,
        'startValidity':element.startValidity,
        'endValidity':element.endValidity
      });
    }
    print("doooone");
  }

  //update visitor state
  void updateState(String state,card,type)async{
    try{
      await instance.collection(type).doc(card).update({
        'state':state
      });
      Get.snackbar("About user", "User message",
          titleText: const Text("Done"),
          messageText: Text("You can enter"));
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: Text("Check your connection"),
          messageText: Text(e.toString()));
    }


  }
  Future<String?> getState(String type,card)async{
    var docSnapshot =  await instance.collection(type).doc(card).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      // You can then retrieve the value from the Map like this:
      return data['state'];
    }else{
      return null;
    }
  }

  void updateToday(String date)async{
    await instance.collection("today").get().then((value){
      for(DocumentSnapshot doc in value.docs ){
        instance.collection("archive").doc("2023-06-14").collection("archive").doc(doc.id).set({
          'name':doc.get('name'),
          'time':doc.get('time'),
          'state':doc.get('state')
        });
          doc.reference.delete();
      }
    });
  }

  void addToPerm(String id,userName,userNature)async{
   try {
     await instance.collection("permanent").doc(id).set({
       'id': id,
       'userName': userName,
       'userNature': userNature
     });
     await instance.collection(userNature).doc(id).set({
       'carMat': "",
       'state': "out",
       'carOrWalk': "",
       'name': userName
     });
     Get.snackbar("About user", "User message",
         titleText: const Text("User added successfully"),
         messageText: const Text("Add new user"));
   }catch(e){
     Get.snackbar("About user", "User message",
         titleText: Text("Check your connection"),
         messageText: Text(e.toString()));
    }
  }
  void addToTemp(String id,userName,userNature,startVal,endVal)async{
    try{
      await instance.collection("temporal").doc(id).set({
        'id': id,
        'userName': userName,
        'userNature': userNature,
        'startValidity': "${startVal}T00:00:00.000",
        'endValidity': "${endVal}T00:00:00.000"
      });
      await instance.collection(userNature).doc(id).set(
          {'carMat': "", 'state': "out", 'carOrWalk': "", 'name': userName});
      Get.snackbar("About user", "User message",
          titleText: const Text("User added successfully"),
          messageText: const Text("Add new user"));
    }catch(e){
      Get.snackbar("About user", "User message",
          titleText: const Text("Check your connection"),
          messageText: Text(e.toString()));
    }
  }


  //Stream of temporal list
  Stream<List<UserInformationTempo>> getTempoList(){
    return temporalReference.snapshots().map((element) =>
        element.docs.map((e) => UserInformationTempo.fromMap(e)).toList());
  }
  //Stream of permanent list
  Stream<List<UserInformationPerm>> getPermList(){
    return
      permanentReference.snapshots().map((element) =>
          element.docs.map((e) => UserInformationPerm.fromMap(e)).toList());
  }


  //procedure to update or edit users information's
  void updateData(String? id,newName)async{
    await permanentReference?.doc(id).update({'userName':newName});
  }






}
