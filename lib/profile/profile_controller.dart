import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:tpl_interview/api/sheets/google_sheet.dart';
import 'package:tpl_interview/question_screen/question_screen.dart';

class ProfileController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  static final googleSheets = GSheets(GoogleSheetClass.credentials);
  static Worksheet? userSheet;

  Future init()async{
    final spreadSheet = await googleSheets.spreadsheet(GoogleSheetClass.spreadSheetID);
    userSheet = await _getWorkSheet(spreadSheet, "Android");
  }

  static _getWorkSheet(Spreadsheet spreadSheet, String title)async {

    try{
      return await spreadSheet.addWorksheet(title);
    }catch(e){
      return  spreadSheet.worksheetByTitle(title);
    }

  }

  Future addHeaderRow()async{
    await userSheet!.values.insertRow(1, ["name", "email", "phone", "date", "question", "answers"]);

  }
  // List<Map<String, dynamic>> rowValue
  Future insert()async{
    await addHeaderRow();
    final row = [{
      "name": nameController.text.toString(),
      "email":email.text.toString(),
      "phone": phone.text.toString(),
      "date" : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    }];
    await userSheet!.values.map.appendRows(row).then((value){

      Get.to(()=> QuestionScreen());
      clearControllers();
    });
    // getDepartments();
  }

  void clearControllers(){
    nameController.clear();
    email.clear();
    phone.clear();
  }
  @override
  void onInit() async {
    await init();
    super.onInit();
  }
}