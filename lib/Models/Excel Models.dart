import 'package:cloud_firestore/cloud_firestore.dart';
class UserInformationPerm{
   String? id;
   String? userName;
   String? userNature;
  UserInformationPerm({required this.id,required this.userName,required this.userNature});
  UserInformationPerm.fromMap(DocumentSnapshot data){
    id=data.id;
    userName=data["userName"];
    userNature=data["userNature"];
  }
}
class UserInformationTempo{
  String? id;
  String? userName;
  String? userNature;
  String? startValidity;
  String? endValidity;
  UserInformationTempo({required this.id,required this.userName,required this.userNature,required this.startValidity,required this.endValidity});
  UserInformationTempo.fromMap(DocumentSnapshot data){
    id=data.id;
    userName=data["userName"];
    userNature=data["userNature"];
    startValidity=data["startValidity"];
    endValidity=data["endValidity"];

  }
}