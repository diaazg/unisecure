import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mastercoding/controller/crud_controller.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/agentBack.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFB74848)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Security cameras',style: GoogleFonts.poppins(color: Colors.white,fontSize: 13),),
                        Image.asset("images/Rectangle 78.png",height: 20,width: 20,),

                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    String? name;
                    String? id;
                    String? nature;
                    String? startVal;
                    String? endVal;
                    Get.dialog(
                      Dialog(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  leading: IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  title: const Text('Add'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                    side: const BorderSide(
                                                        color: Colors.red)))),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.upload,
                                          color: Colors.white,
                                        ),
                                        label: const Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                                          child:  Text(
                                            'Import excel file from your device',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        ),
                                        label:const Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 13,horizontal:20),
                                          child:  Text(
                                            'Import temporary Authorized',
                                            style:
                                            TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey[300]),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ))),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0, right: 20.0),
                                                child: const Divider(
                                                  color: Colors.black,
                                                  height: 36,
                                                )),
                                          ),
                                          const Text("OR"),
                                          Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20.0, right: 10.0),
                                                child: const Divider(
                                                  color: Colors.black,
                                                  height: 36,
                                                )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Add Manually',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        onChanged: (x){
                                          setState(() {
                                            name=x;
                                          });
                                        },
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "This field cannot be empty!";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Full name',
                                          // border: OutlineInputBorde,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        onChanged: (x){
                                         setState(() {
                                           id=x;
                                         });
                                        },
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "This field cannot be empty!";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'ID Number',
                                          // border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        children: [
                                          const Text(
                                            'Nature:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child:
                                            DropdownButtonFormField<String>(
                                              items: [
                                                'Student',
                                                'Employee',
                                                'Visitor',
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              onChanged: (x){
                                                setState(() {
                                                  nature=x;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              onChanged: (x){
                                                setState(() {
                                                  startVal=x;
                                                });
                                              },
                                              keyboardType:
                                              TextInputType.datetime,
                                              decoration: const InputDecoration(
                                                labelText: 'Start validity',
                                                // border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          Flexible(
                                            child: TextFormField(
                                              onChanged: (x){
                                                setState(() {
                                                  endVal=x;
                                                });
                                              },
                                              keyboardType:
                                              TextInputType.datetime,
                                              decoration: const InputDecoration(
                                                labelText: 'End validity',
                                                // border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                    side: const BorderSide(
                                                        color: Colors.red)))),
                                        onPressed: () {
                                          _formKey.currentState?.save();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if(startVal==null && endVal==null ){
                                              Get.put<CrudController>(CrudController());
                                              CrudController.insController.addToPerm(id!, name, nature);
                                            }else if(startVal!=null && endVal!=null){
                                              Get.put<CrudController>(CrudController());
                                              CrudController.insController.addToTemp(id!, name, nature, startVal, endVal);
                                            }
                                          }
                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 40),
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
                          Text('Import',style: GoogleFonts.poppins(color:Color(0xFFB74848) ,fontSize: 13),),
                          Icon(Icons.add,color: Color(0xFFB74848) ,)

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today visitor',style: GoogleFonts.poppins(fontSize: 30,color: Colors.white),),
                GestureDetector(onTap: (){},child: Text('view all',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),))
              ],
            ),
            Container(
              height: size.height*0.4,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                          width: size.width*0.7,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                    color: Colors.red
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Zellagui diaa',style: GoogleFonts.poppins(fontSize: 20),),
                                  Text('walk',style: GoogleFonts.poppins(fontSize: 15,color: Colors.black),),
                                ],
                              ),
                              Center(child: Text('Student',style: GoogleFonts.poppins(fontSize: 14,color: Colors.black54),)),

                            ],
                          ),
                        ),
                        Image.asset("images/walkred.png",height: 40,width: 40,)
                      ],
                    );
                  }),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('still inside',style: GoogleFonts.poppins(fontSize: 30,color: Colors.white),),
                GestureDetector(onTap: (){},child: Text('view all',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),))
              ],
            ),
            Container(
              height: size.height*0.2,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                          width: size.width*0.7,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                    color: Colors.red
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Zellagui diaa',style: GoogleFonts.poppins(fontSize: 20),),
                                  Text('walk',style: GoogleFonts.poppins(fontSize: 15,color: Colors.black),),
                                ],
                              ),
                              Center(child: Text('Student',style: GoogleFonts.poppins(fontSize: 14,color: Colors.black54),)),

                            ],
                          ),
                        ),
                        Image.asset("images/walkred.png",height: 40,width: 40,)
                      ],
                    );
                  }),
            ),


          ],
        ),
      ),
    ));
  }
}
