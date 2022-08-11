import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpl_interview/app_basics/app_button.dart';
import 'package:tpl_interview/app_basics/text_field.dart';
import 'package:tpl_interview/entry/login_controller.dart';
import 'package:tpl_interview/profile/profile.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final _controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset("assets/logo.png"),
              ),
            const SizedBox(height: 40.0),
            AppTextField(
              hintText: "user name",
              labelText: "user name",
              controller: _controller.mailController,
            ),
            AppTextField(
              controller: _controller.passwordController,
              labelText: "password",
              hintText: "password",
              obscureText: true,
            ),
             const SizedBox(height: 50.0),
              InkWell(

                  child:AppButton(text: "Start Test ", height: 40.0, width: 170.0,),
                onTap: (){
                    for(int i = 0; i<_controller.departmentsData.length; i++){
                      if(_controller.departmentsData[i]['username'] == _controller.mailController.text ){
                        if(_controller.departmentsData[i]['password'] == _controller.passwordController.text) {
                          Get.to(()=> Profile())!.then((value) => _controller.closeFunction());
                        }else{
                          print("Password not matched");
                        }
                        print("User exists: ${_controller.departmentsData[i]['username']} ");
                      }
                    }
                },
              ),
          ],
        ),
      ),
    );
  }
}