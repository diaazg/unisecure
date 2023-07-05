import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/crud_controller.dart';

class ViewData extends StatelessWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child: Obx(() => ListView.builder(
                itemCount: CrudController.insController.getterPerm.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                      "${CrudController.insController.getterPerm[index]!.userName}"),
                  subtitle: Text(
                      "${CrudController.insController.getterPerm[index]!.id}"),
                  leading: Text(
                      "${CrudController.insController.getterPerm[index]!.userNature}"),
                  trailing: GestureDetector(
                    onTap: () {
                      CrudController.insController.updateData(
                          CrudController.insController.getterPerm[index]!.id,
                          'newName');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.red,
                      child: Icon(
                        Icons.update,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              )),
            ),
            SizedBox(height: 10,),
            Container(
              height: 400,
              child: Obx(() => ListView.builder(
                itemCount: CrudController.insController.getterTempo.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                      "${CrudController.insController.getterTempo[index]!.userName}"),
                  subtitle: Text(
                      "${CrudController.insController.getterTempo[index]!.startValidity}"),
                  leading: Text(
                      "${CrudController.insController.getterTempo[index]!.userNature}"),
                  trailing: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.red,
                      child: Icon(
                        Icons.update,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    ));
  }
}
