import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mastercoding/excelPage.dart';
import 'package:mastercoding/screens/logIn/loginPage.dart';
import 'package:mastercoding/screens/agent/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mastercoding/screens/logIn/WalOrDrv.dart';


class AuthController extends GetxController{

  //Auth controller instance
  static AuthController instance=Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  late String uid;

  @override
  void onReady(){
    super.onReady();
    _user=Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    //our user would be notified
    ever(_user, _initialScreen);

  }
  _initialScreen(User? user) async {
    if(user==null){
      Get.offAll(()=>const loginPage());
    }else{
      String? card;
      String? type;
      uid=user.uid;
      var docSnapshot =  await store.collection("codage").doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;

        // You can then retrieve the value from the Map like this:
         card = data['card'];
         type=data['type'];
      }
      print(card);
      print(type);
      Get.offAll(()=> WalOrDrv(card: card!,type: type!,));
    }
  }

  void updateEnterInfo(String cOw , carMat,card,type)async{

   try{
     await store.collection(type).doc(card).update({
       'carOrWalk':cOw,
       'carMat':carMat
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
  void SignIn(String email, password) async {
    try {

       await auth.signInWithEmailAndPassword(
          email: email, password: password);


    } catch (e) {
      print(e.toString());
      Get.snackbar("About user", "${e.toString()}",snackPosition: SnackPosition.BOTTOM,titleText: Text("Accound creation failed",style: TextStyle(color: Colors.green),),messageText: Text("${e.toString()}"));

    }
  }
  void SignOut()async{
    await auth.signOut();
  }
}