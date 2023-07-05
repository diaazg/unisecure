import 'package:flutter/material.dart';

class pageReso extends StatefulWidget {
  const pageReso({Key? key}) : super(key: key);

  @override
  State<pageReso> createState() => _pageResoState();
}

class _pageResoState extends State<pageReso> {
  Map<String,String>informations={
    "212131030432":"Rafik halalled \n esi sba student",
    "212135066704":"Diaa Zellagui\n esi sba student"
  };
  @override
  Widget build(BuildContext context) {
    List val=informations.values.toList();
    List kk=informations.keys.toList();

    Size size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Center(
        child: Container(
          height:size.height ,
          width: size.width,
          child: Column(
            children: [
              Text(informations.values.first.toString())
            ],
          ),
        ),
      ),
    ));
  }
}
