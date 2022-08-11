import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:tpl_interview/app_basics/app_container.dart';
import 'package:tpl_interview/app_basics/text_field.dart';
import 'question_screen_controller.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({Key? key}) : super(key: key);
  final controller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white70,
                spreadRadius: 10.0,
                blurRadius: 2,
                offset:  Offset(3, 1),
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
                onPressed: () {

                  if (controller.questionNo.value > 0) {
                    controller.setQuestionNo(controller.questionNo.value-1);
                    if(controller.answers[controller.questionNo.value]["type"] == "mcq"){
                      controller.setSelectedOption(controller.answers[controller.questionNo.value]["optionValue"]);
                    }else if(controller.answers[controller.questionNo.value]["type"] == "open"){
                      controller.answer.text = controller.answers[controller.questionNo.value]["controller"];
                    }
                  }
                },
                label:  Text('Back', style: buildTextStyle(fontSize: 18.0, color : Colors.white)),
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                style: ElevatedButton.styleFrom(primary: Colors.orange)),
          /// ----->
          Obx(()=>
              ElevatedButton.icon(
                  label:
                  Text(controller.questionNo.value == controller.questionsData.length-1
                      ? "Submit":"Next", style: buildTextStyle(fontSize
                      : 18.0, color : Colors.white)),
                  icon: const  Icon(Icons.chevron_right, color: Colors.white),
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  onPressed: () async {
                    controller.addRow(controller.questionNo.value).then((value){
                      try{
                        if(controller.answers.elementAt(controller.questionNo.value).isNotEmpty){
                          if(controller.answers[controller.questionNo.value]["type"] == "mcq"){
                            controller.setSelectedOption(controller.answers[controller.questionNo.value]["optionValue"]);
                          }else if(controller.answers[controller.questionNo.value]["type"] == "open"){
                            controller.answer.text = controller.answers[controller.questionNo.value]["controller"];
                          }else{
                            return null;
                          }
                        }
                      }catch(e){
                        controller.selectedOption.value = 4;
                        controller.answer.clear();
                        print("Exception$e");
                      }
                      controller.answer.clear();
                      controller.setSelectedOption(5);
                      if (controller.questionNo.value < controller.questionsData.length-1) {
                        controller.setQuestionNo(controller.questionNo.value+1);
                      }
                  });

                  if(controller.questionNo.value == controller.questionsData.length-1){
                    controller.defaultDialog("Are you sure you want to Submit Test", true);
                  }
                }

              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.orange,
                        Colors.deepOrangeAccent,
                        Colors.orange,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ))),
          ),
          Positioned(
            top: 10,
            left: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(100.0)),
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(100.0)),
            ),
          ),
          Positioned(
            top: 140,
            right: 70,
            // left: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(100.0)),
            ),
          ),
          Positioned(
              top: 180,
              left: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  AppContainer(
                      // padding: 20.0,
                      borderRadius: 20.0,
                      shadow: 2.0,
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          Obx(() => Text(
                              "Question ${controller.questionNo.value +1 }/${controller.questionsData.length}")),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: Obx(() => Visibility(
                                visible: controller.visible.value,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: Text(
                                  controller.questionsData.isEmpty
                                      ? ""
                                      : "${controller.questionsData[controller.questionNo.value]['Question']}",
                                  style: buildTextStyle(fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ))),
                          )
                        ],
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Obx(() =>
                          Visibility(
                            visible: controller.visible.value,
                            child: controller.questionsData.isEmpty ?const Text("") : controller.questionsData[controller.questionNo.value]["type"] == "mcq" ?
                            Column(children: List.generate(4, (index) => buildCard(index, context))) :
                            AppTextField(
                                labelText: "Give your Answer Here",
                                controller: controller.answer,
                                border: true,
                              maxLines: 4,
                            ),
                            replacement: const Center(child: Text("")),
                      ),
                    ),
                  ),
                ],
              )),
          //==> Time
          Positioned.fill(
              top: 130,
              // right: 20.0,
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 55,
                  width: 100,
                  child: Container(
                    // borderRadius: 100.0,
                    // shadow: 5.0,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      children: [
                       const SizedBox(height: 5.0),
                        Text(
                          "Time",
                          style: buildTextStyle(fontSize: 20.0),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text(
                                  controller
                                      .twoDigits(controller.minutes.value),
                                  style: buildTextStyle(fontSize: 20.0),
                                )),
                           const SizedBox(width: 5.0),
                            const Text(":"),
                            const SizedBox(width: 5.0),
                            Obx(() => Text(
                                  controller
                                      .twoDigits(controller.seconds.value),
                                  style: buildTextStyle(fontSize: 20.0),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
// this is test commit from AR
  Card buildCard(int index, context) {
    return Card(
      elevation: controller.selectedOption.value == index ? 0 : 3,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side:
      BorderSide(color: controller.selectedOption.value == index ?
      Theme.of(context).primaryColor : Colors.white,
      width: 3.0,
      )) ,
      child: RadioListTile(
          title: Text(controller.questionsData[controller.questionNo.value]
          ['Options'].toString().split(",")[index]),
          value: index,
          groupValue: controller.selectedOption.value,
          onChanged: (value) {
            controller.mcqOption.value= controller.questionsData[controller.questionNo.value]
            ['Options'].toString().split(",")[value.hashCode] ;
            controller.setSelectedOption(value.hashCode);
          }),
    );
  }
  TextStyle buildTextStyle({double? fontSize, Color? color}) => TextStyle(fontSize: fontSize, color: color);
}
