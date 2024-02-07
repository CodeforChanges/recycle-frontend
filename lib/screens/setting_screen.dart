import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recycle/components/user_information.dart';
import 'package:recycle/models/setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            UserInf(),
            menusWidget(context: context),
          ]),
        ),
      ),
    );
  }

  AppBar renderAppBar() => AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      );

  Widget menusWidget({required BuildContext context}) => Column(
      children: settings
          .map((menu) => Column(
                children: [
                  titleWidget(title: menu.title),
                  ...menu.menus
                      .map((menu) => menuWidget(
                            menu: menu.menu,
                            context: context,
                            onPress: menu.onPress,
                          ))
                      .toList()
                ],
              ))
          .toList());

  Widget titleWidget({required String title}) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.5)))),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                title,
                style:
                    const TextStyle(color: Color(0xff008000), fontSize: 17.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );

  Widget menuWidget(
      {required String menu,
      required BuildContext context,
      required void Function() onPress}) {
    return SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                menu,
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.grey, size: 16.0),
            ],
          ),
        ));
  }
}
