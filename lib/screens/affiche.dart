import 'package:flutter/material.dart';
import 'package:mastercoding/controller/crud_controller.dart';
import 'package:get/get.dart';

class Affiche extends StatefulWidget {
  final String code;
  const Affiche({required this.code});

  @override
  State<Affiche> createState() => _AfficheState();
}

class _AfficheState extends State<Affiche> {
  String name="not find";

  String? nom;
  @override
  void initState() {
    Get.put(CrudController());
    List codes=  CrudController.insController.getterPerm;
    int ind;
    codes.forEach((e) {if (e.id==widget.code.toString()){
      print(e.id.toString());
      name=widget.code;
      ind=codes.indexOf(e);
      nom=codes[ind].userName.toString();
      name=codes[ind].userNature;
      print("${widget.code} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(codes[ind].userName.toString());

    }});
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Center(
        child: Container(
          height:size.height ,
          width: size.width,
          child: Column(
            children: [
              Text(name),
              nom==null?Text('not find'):Text(nom!),
            ],
          ),
        ),
      ),
    ));
  }
}



