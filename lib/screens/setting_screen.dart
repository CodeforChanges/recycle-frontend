import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recycle/models/follow.dart';
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
            userInfWidget(),
            menusWidget(),
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

  Widget userInfWidget() => Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                'assets/images/profile.jpg',
                width: 80.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이름',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: follows
                          .map((follow) => Row(
                                children: [
                                  Icon(
                                    follow.icon,
                                    size: 20.0,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(follow.type),
                                  ),
                                  Text(follow.count.toString()),
                                  const SizedBox(width: 10.0),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget menusWidget() => Column(
      children: settings
          .map((menu) => Column(
                children: [
                  titleWidget(title: menu.title),
                  ...menu.menus
                      .map((menu) => menuWidget(
                            menu: menu.menu,
                            onPress: () {},
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

  Widget menuWidget({required String menu, required Function onPress}) {
    return SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {},
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
