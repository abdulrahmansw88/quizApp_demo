import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:tpl_interview/api/sheets/google_sheet.dart';
import 'package:tpl_interview/app_basics/app_button.dart';
import 'package:tpl_interview/entry/login_screen.dart';

class QuestionController extends GetxController{
  int submitted = 0;
  Duration duration =  const Duration(minutes: 4);
  TextEditingController answer = TextEditingController();
  late Timer _timer;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  final RxInt _questionNo = 0.obs;
  final RxBool _visible = false.obs;
  final RxInt _selectedOption = 4.obs;
  // get submitted => _submitted;

  get questionNo => _questionNo;
  setQuestionNo(int value)=> _questionNo.value = value;
  get visible=> _visible;
  get selectedOption => _selectedOption;
  setSelectedOption(int value) => _selectedOption.value = value;
  setVisible(bool value)=> _visible.value = value;
  RxString mcqOption = ''.obs;
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  List questionsData=[].obs;
  List<Map<String, dynamic>> answers = [];

  @override
  void onInit() {
    init();
    // TODO: implement onInit
    super.onInit();
  }

  Future<dynamic> defaultDialog(String text, bool isDismissible) {
    return Get.defaultDialog(
      barrierDismissible: isDismissible,
        title: "Alert",
        content:  Text(
          text
        ),
        actions: [
          GestureDetector(
       onTap: (){
         submitAnswer(answers).then((value) {
            Get.offAll(()=> LoginScreen());
            _timer.cancel();
            answers.clear();
         });
         },
            child: AppButton(
                height: 35.0,
                width: 90.0,
                text: "submit"
            ),
      )
        ]
      );
  }

  static final googleSheets = GSheets(GoogleSheetClass.credentials);
  static Worksheet? questionSheet;
  static Worksheet? answerSheet;
  Future init()async{
    final spreadSheet = await googleSheets.spreadsheet(GoogleSheetClass.spreadSheetID);
    questionSheet = await _getWorkSheet(spreadSheet, "Flutter Test");
    answerSheet = await _getWorkSheet(spreadSheet, "Android");
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

Future submitAnswer(List<Map<String, dynamic>> row)async{
  await answerSheet!.values.map.appendRows(row);
}
  void add()async {
    questionsData = ((await questionSheet!.values.map.allRows())!);
    setVisible(true);
    startTimer();
  }

  void startTimer(){
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(duration > const Duration(seconds: 0)){
        duration = duration - const Duration(seconds: 1);
      }else{
        defaultDialog("Your Time is out..!", false);
        timer.cancel();
      }
      seconds.value = duration.inSeconds.remainder(60);
      minutes.value = duration.inMinutes.remainder(60);
    });
  }

  Future addRow(int index)async{
    final row = {
      "question" : "${questionsData[index]["Question"]}",
      "answers": questionsData[index]["type"] == "mcq"
          ? mcqOption.value
          : answer.text.toString(),
      "type":questionsData[index]["type"] == "mcq"
          ? "mcq"
          : "open" ,
      "optionValue" : questionsData[index]["type"] == "mcq"
          ? selectedOption.value.toInt()
          : 5,
      "controller" : questionsData[index]["type"] == "mcq"
          ? ""
          : answer.text.toString(),
    };
    answers.insert(index, row);
  }
}