import 'package:beehive/mainApp_screens/home_screen.dart';
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
                Icons.home_rounded,
                0,
              ),
              bottomTabBarItem(
                () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                Icons.work_history_outlined,
                1,
              ),
              bottomTabBarItem(
                () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                Icons.mark_as_unread_outlined,
                2,
              ),
              bottomTabBarItem(
                () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                Icons.person_outline,
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
