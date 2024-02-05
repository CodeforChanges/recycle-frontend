import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textFieldWidget(
                label: "Name",
                controller: nameController,
                obscureText: false,
              ),
              textFieldWidget(
                label: "Nickname",
                controller: nicknameController,
                obscureText: false,
              ),
              textFieldWidget(
                label: "Email",
                controller: emailController,
                obscureText: false,
              ),
              textFieldWidget(
                label: "Password",
                controller: passwordController,
                obscureText: true,
              ),
              sizedBox(height: 20.0),
              signUpBtn(
                controller: [
                  nameController,
                  nicknameController,
                  emailController,
                  passwordController
                ],
              ),
              sizedBox(height: 20.0),
              moveSignInBtn(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar renderAppBar() => AppBar(
        title: const Text('회원가입'),
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
      );

  Widget textFieldWidget({label, obscureText, controller}) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(height: 5.0),
          TextField(
            obscureText: obscureText,
            controller: controller,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCDDC39), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              border: OutlineInputBorder(),
            ),
          )
        ]),
      );

  SizedBox sizedBox({height}) => SizedBox(
        height: height,
      );

  Widget moveSignInBtn() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("계정이 이미 있으신가요? "),
          TextButton(
            onPressed: () => Get.back(),
            child:
                const Text('로그인', style: TextStyle(color: Color(0xff008000))),
          ),
        ],
      );

  Widget signUpBtn({controller}) => SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          onPressed: () {
            // contoller
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff008000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          child: const Text(
            '회원가입',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      );
}
