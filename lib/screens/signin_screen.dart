import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:recycle/controller/auth_service.dart';
import 'package:recycle/controller/post_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  _asyncMethod() async {
    if (await storage.read(key: "access_token") != null) {
      if (!mounted) return;
      await AuthService.to.getUser();
      Get.offAllNamed('/');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _asyncMethod(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: renderAppBar(),
              body: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(40.0),
                child: Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      // logo(),
                      TextFieldWidget(
                        icon: Icons.alternate_email_outlined,
                        hintText: 'Email',
                        controller: emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      sizedBox(),
                      TextFieldWidget(
                        icon: Icons.lock,
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                      sizedBox(),
                      signInBtn(
                          emailController: emailController,
                          passwordController: passwordController),
                      sizedBox(),
                      moveSignUpBtn(),
                    ])),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  AppBar renderAppBar() => AppBar(
        automaticallyImplyLeading: false,
        title: const Text('로그인'),
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
      );

  // Image logo() => Image(
  //       image: AssetImage('/'),
  //       width: 80.0,
  //     );

  TextField TextFieldWidget(
          {obscureText, controller, keyboardType, icon, hintText}) =>
      TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffCDDC39), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Icon(icon),
          ),
          hintText: hintText,
        ),
      );

  Widget signInBtn({emailController, passwordController}) => SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () async {
          final result = await AuthService.to.signIn(
            emailController.text,
            passwordController.text,
          );
          if (result) {
            await AuthService.to.getUser();
            await PostController.to.initPostToken();
            PostController.to.getPosts();
            Get.offAllNamed('/');
            return;
          }
          Get.snackbar('로그인 실패', '이메일 또는 비밀번호를 확인해주세요.',
              snackPosition: SnackPosition.BOTTOM);
          return;
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff008000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: const Text(
          '로그인',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Widget moveSignUpBtn() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('(앱 이름)가 처음이신가요?'),
          const SizedBox(
            width: 20.0,
          ),
          TextButton(
              onPressed: () => Get.offAllNamed('/signup'),
              child: const Text(
                '회원가입',
                style: TextStyle(color: Color(0xff008000)),
              ))
        ],
      );

  SizedBox sizedBox() {
    return const SizedBox(
      height: 20.0,
    );
  }
}
