import 'package:get/get.dart';
import '../pages/main_nav_page.dart';
import '../pages/home_page.dart';
import '../pages/form_page.dart';
import '../pages/folder_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/main', page: () => MainNavPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/form', page: () => FormPage()),
    GetPage(name: '/folder', page: () => FolderPage()),
  ];
}