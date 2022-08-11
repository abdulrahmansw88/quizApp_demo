import 'package:gsheets/gsheets.dart';

class GoogleSheetClass{
  static const String spreadSheetID = "19LqqBjUKSNJl6nlhlyOQqOrDQewC5xECkvqWq9QQVwg";

  static const credentials = r'''
  {
  "type": "service_account",
  "project_id": "abiding-cycle-335007",
  "private_key_id": "9d5964e57aae2f1659189b58193e4ebf74b02675",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCsjrNIOIdDiFdA\nsOLJ3kHHsTTD/dE8Y3jhOUHOtaejaaW9Jalugc935kqaJvO8i0bESOXCTiIa3eH8\nm5NDAFe4nV7bstlrEZ5bmiFyCQqn3L6p6QD0dj3FIv6uNvjOX+vnxClFhtYevtbr\nxUCb4sS7+ZMofcik9W/XNNrmlprWBjIBOfTSceQui8jkjulcqyoqVWlLpkTHpUD3\nmNNHk2UO0rRYftJRedS8kdunfX9cVDZyEh9cCMLEY272/BYl8YPJX00tJlCfyRMz\n4SOV+whlSypGX9JcJAjnngBWSJt9jTfPb//J/IMxlEkBEjHUJ7NcD0LU2vOgPzM4\nbakxw7XlAgMBAAECggEAFCxmCwJKKgaFW4jyfUg7J4Cbmx2QOdT6m6tzz+9OfHJ2\n+nCDPj9LL94gCE/tJzSfNDETj2OkEBZdpl3ShGmaAnl/eVmPmo6yP/elLlhJQyEH\nDK/dY+HI90RP7bJ75GC0IIyUiKOADT3MEZSmKN4E7bb6pygMGOD1eihHPosKlLfD\n1H9QspRks4Cp/TqNWNH7ZoKydnMJXIxudC5dizdPfUBvlFQCep33o0VSyGQ1gYo3\nNXI8h34QUEVeCnnetQBzzK2sjWCxoceqxJFGFY/Sn3uugaum6uhOty7WjXijAMEi\nJqPO3m33iDUoW7NgZQBzt9Xgnv16UyX3nal47cmMFwKBgQDc/SUAmnzFT4pJfKUz\n/mYb5gdvmel3Wgs+4OcXLvhaVo1PU68DTv5HIiklxZSkKNupbq7ilc2iCyHr+QLp\nzsIHlfdG7/m8XS7JVBhcDKvEv4Vcor70B9vYoYxQSM7Bp4Y7RJQkuRKrxQ1naMKL\nMr+inQKaXgoVJmuydkJzKfItAwKBgQDH5Ua/pGTxQW0uMfYyVEYmpZ7UINmxmpqU\n54cSHn23NYaBFmZ/0XI6Z2rf+v3NvRsSSMDo6D9J4GMKreuXLOK7gd7gJxdq6za6\nsFIVHqvtYh/tjB+BBIN5hmtlyfRTJ4g+0swI4KvlcK4tc4tLW4eYAbQ0sddS5aY2\n/aPN7PYY9wKBgQCy02KjB2CaJlBoQSZKWb31K4Ku66SCQWpCOqqmFws/xzRYkgZY\nrg6UL2+OskEjSjDe/cMldkXNsCaGFp4l53sZumA8lirII7udjaCctGA3OShJGyVc\nwhNETQ4HVbOB//dedJNQ2DbkqvO6z4pGLA3pIBcgJaMRFGMoKgyBttrTUwKBgQCF\n2r0GZWIGv2YJ8gDHcPFMvcjeiWTc7gcnQOaMtog+X4RC+qoGW00fWNMTSvIbi88N\n7lPnYmXG5Y/MveutXqwxHWUOOn8O5JTQbHN6mwBLxFJW8mbCMTCM9vsBvTtzV1x/\nnQ5tv2y8BjlMTDvxaUgh/LocMx5Z71ffKPdAVLXyvwKBgQC7ygutaC7b2qbVW5yA\ntYhaMvh0HRgeJEvuiTtuQFAIgJ2UZ/5QH4/AuGO/bAvZPvBUAO29s3EIP/kLC8JA\nh3IKGV2NpwsA8Y9rvE7lUsKFVI8SZM5hAuL+yTrsR+IzK5OoXqA3w1CTgzbjX6Gs\nKdFt5JkTC6TXDHexSbvOX25D4w==\n-----END PRIVATE KEY-----\n",
  "client_email": "googlesheets@abiding-cycle-335007.iam.gserviceaccount.com",
  "client_id": "102742093583776036169",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets%40abiding-cycle-335007.iam.gserviceaccount.com"
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