import 'package:gsheets/gsheets.dart';

class GoogleSheetClass{
  static const String spreadSheetID = "";

  static const credentials = r'''
  {
  "type": "service_account",
  "project_id": "abiding-cycle-335007",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}
  ''';

  static final googleSheets = GSheets(credentials);
  static Worksheet? departmentsSheet;
   Future init()async{
    final spreadSheet = await googleSheets.spreadsheet(spreadSheetID);
    departmentsSheet = await _getWorkSheet(spreadSheet, "Department");
    getDepartments();
    add();
  }

 static _getWorkSheet(Spreadsheet spreadSheet, String title)async {

    try{
      return await spreadSheet.addWorksheet(title);
    }catch(e){
      return  spreadSheet.worksheetByTitle(title);
    }
  }

  late  List _departmentsList= [];
  List get getDepartmentsSheet=> _departmentsList;
  set setDepartmentList(List list){

    _departmentsList = list;
  }
   Future insert(List<Map<String, dynamic>> rowValue)async{

    if(departmentsSheet==null) return ;
    await departmentsSheet!.values.map.appendRows(rowValue).then((value) => print(value));
    // getDepartments();
  }

  void add()async {
    _departmentsList == (await departmentsSheet!.values.map.allRows())!;
  }
   Future getDepartments() async{
    setDepartmentList =  (await departmentsSheet!.values.map.allRows())!;
  }
}


///googlesheets@abiding-cycle-335007.iam.gserviceaccount.com
