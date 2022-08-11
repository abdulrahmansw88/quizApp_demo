
import 'package:flutter/material.dart';
import 'package:tpl_interview/api/sheets/google_sheet.dart';
import 'package:tpl_interview/app_basics/app_container.dart';
import 'package:tpl_interview/models/department_model.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Home"),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children:   [
            Text("Select Department"),
            CardWidget(title: "Mobile Application",),
            GestureDetector(
                onTap: ()async{
                  final row = {
                  "id": "Paul",
                   "answers":"ABC"
                };
                  await GoogleSheetClass().insert([row]);
                },
                child: CardWidget(title: "Web Development",)),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
   const CardWidget({
    this.title="",
    Key? key,
  }) : super(key: key);

 final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Card(
        elevation: 3.0,
        shape:  BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child:Text(title, style: const TextStyle(
          fontSize: 24.0,
        ),)),
        borderOnForeground: true,
      ),
    );
  }
}
