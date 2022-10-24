import 'package:beehive/mainApp_screens/home_screen.dart';
import 'package:beehive/mainApp_screens/screen2.dart';
import 'package:beehive/mainApp_screens/screen3.dart';
import 'package:beehive/mainApp_screens/screen4.dart';
import 'package:flutter/material.dart';

class BottomTabHome extends StatefulWidget {
  const BottomTabHome({Key? key}) : super(key: key);

  @override
  State<BottomTabHome> createState() => _BottomTabHomeState();
}

class _BottomTabHomeState extends State<BottomTabHome> {
  int pageIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 25,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomTabBarItem(
                () {
                  setState(() {
                    currentScreen = const HomeScreen();
                    pageIndex = 0;
                  });
                },
               pageIndex == 0?Icons.home:Icons.home_outlined,
                0,
              ),
              bottomTabBarItem(
                () {
                  setState(() {
                    currentScreen = const Screen2();
                    pageIndex = 1;
                  });
                },
                pageIndex == 1?Icons.work_rounded:Icons.work_outline,
                1,
              ),

              bottomTabBarItem(
                () {
                  setState(() {
                    currentScreen = const Screen3();
                    pageIndex = 2;
                  });
                },
                pageIndex == 2?Icons.notifications:Icons.notifications_none,
                2,
              ),
              bottomTabBarItem(
                () {
                  setState(() {
                    currentScreen = const Screen4();
                    pageIndex = 3;
                  });
                },
                pageIndex == 3?Icons.favorite:Icons.favorite_border,
                3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTabBarItem(VoidCallback onTap, IconData iconData, int index) {
    return Expanded(
      child: MaterialButton(
        minWidth: 40,
        onPressed: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 25,
              color: pageIndex == index
                  ? Colors.black
                  : Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
