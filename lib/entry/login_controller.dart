import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:tpl_interview/api/sheets/google_sheet.dart';
import 'package:tpl_interview/models/department_model.dart';

class LoginController extends GetxController{


   List departmentsData=[].obs;
   TextEditingController mailController = TextEditingController(text: "Flutter");
   TextEditingController passwordController = TextEditingController(text: ".flutter");
   late DepartmentModel departmentModel;
   @override
  void onInit()async {
    // TODO: implement onInit
     init();
    super.onInit();
  }



   static final googleSheets = GSheets(GoogleSheetClass.credentials);
   static Worksheet? departmentsSheet;
   Future init()async{
     final spreadSheet = await googleSheets.spreadsheet(GoogleSheetClass.spreadSheetID);
     departmentsSheet = await _getWorkSheet(spreadSheet, "Department");
     // getDepartments();
     add();
   }

   static _getWorkSheet(Spreadsheet spreadSheet, String title)async {

     try{
       return await spreadSheet.addWorksheet(title);
     }catch(e){
       return  spreadSheet.worksheetByTitle(title);
     }
   }


   void add()async {
      departmentsData = ((await departmentsSheet!.values.map.allRows())!);
   }


  void closeFunction(){
    mailController.clear();
    passwordController.clear();
  }
}