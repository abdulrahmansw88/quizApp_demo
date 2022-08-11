import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpl_interview/app_basics/app_button.dart';
import 'package:tpl_interview/app_basics/app_container.dart';
import 'package:tpl_interview/app_basics/text_field.dart';
import 'package:tpl_interview/profile/profile_controller.dart';
import 'package:tpl_interview/question_screen/question_screen.dart';

class Profile extends StatelessWidget {
  @override
  final controller = Get.put(ProfileController());
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppContainer(
                  borderRadius: 20.0,
                    shadow: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(

                        children: [
                          AppTextField(
                            controller: controller.nameController,
                        hintText: "Name",
                        labelText: "Name 2",
                      ),
                          AppTextField(
                            controller: controller.email,
                        labelText: "email",
                        hintText: "email",),
                          AppTextField(
                            controller: controller.phone,
                            labelText: "Phone Number",
                            hintText: "Phone Number",
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20.0,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: ()async{
                                await controller.insert();
                              },
                              child: AppButton(
                                height: 40.0,
                                width: 100.0,
                                text: "Next",
                              ),
                            ),
                          ),
                  ],
                ),
                    )),
              ],
            ),
          ),
      ),
    );
  }
}