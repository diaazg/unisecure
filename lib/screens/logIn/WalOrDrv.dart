import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/auth_controller.dart';
import 'loginPage.dart';

class WalOrDrv extends StatefulWidget {
  final String card;
  final String type;
  const WalOrDrv({required this.card,required this.type});

  @override
  State<WalOrDrv> createState() => _WalOrDrvState();
}

class _WalOrDrvState extends State<WalOrDrv> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                height: size.height * 0.51,
                top: 0,
                right: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.put(AuthController());
                    AuthController.instance.updateEnterInfo("W", "",widget.card,widget.type);

                  },
                  child: Container(
                    height: size.height * 0.5, width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/Group 141.png"),
                          fit: BoxFit.cover),
                    ),
                    // Foreground widget here
                  ),
                ),
              ),
              Positioned(
                  height: size.height * 0.5,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      String? matriclue;
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
                                            matriclue=x;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "This field cannot be empty!";
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Car matricule',
                                            // border: OutlineInputBorde,
                                          ),
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
                                              Get.put(AuthController());
                                              AuthController.instance.updateEnterInfo("C", matriclue,widget.card,widget.type);
                                              Navigator.pop(context);
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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/Group 132.png"),
                            fit: BoxFit.cover),
                      ),
                      // Foreground widget here
                    ),
                  )),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(80),
                            ),
                            height: size.height*0.4,
                            width: size.width*0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(

                                children: [
                                  Text('Confirme your identity',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('We need to make sure this is you touch the fingerprint sensor to continue',style: GoogleFonts.ubuntu(fontSize: 20),),
                                  ),
                                  SizedBox(height: 20,),
                                  Center(
                                    child: GestureDetector(
                                      onTap: (){},
                                      child: Image.asset('images/fingre.png',height: 80,width: 80,),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'How do you want to enter',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                    height: 60,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Color(0xFFB74848)),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(onPressed: (){
                Get.put(AuthController());
                AuthController.instance.SignOut();
              }, icon: Icon(Icons.logout_outlined,color: Colors.white,)))
            ],
          ),
        ),
      ),
    ));
  }
}
