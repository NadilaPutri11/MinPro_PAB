import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'folder_page.dart';
import 'form_page.dart';

class MainNavPage extends StatefulWidget {
  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int index = 0;

  final pages = [
    HomePage(),
    FolderPage(),
  ];

  void changeTab(int i) {
    setState(() {
      index = i;
    });
  }

  void openForm() {
    Get.to(() => FormPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      floatingActionButton: Transform.rotate(
        angle: 0.785,
        child: FloatingActionButton(
          onPressed: openForm,
          child: Transform.rotate(
            angle: -0.785,
            child: Icon(Icons.add),
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () => changeTab(0),
              ),

              SizedBox(width: 40),

              IconButton(
                icon: Icon(Icons.folder),
                onPressed: () => changeTab(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}