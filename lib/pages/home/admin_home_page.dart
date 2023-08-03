import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/home/main_home_page.dart';
import 'package:kpop_shop/pages/cart/cart_page.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/pages/account/account_page.dart';
import '../search/search_page.dart';
class AdminHomePage extends StatefulWidget {
  static const String routeName = '/admin-home-page';
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  int _selectedPage = 0;
  List pages = [
    MainHomePage(),
    SearchPage(searchQuery: ''),
   AddProductScreen(),
    AccountPage(),
  ];

  void onTapNav(int index){
    setState(() {
      _selectedPage=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.lightTextColor,
        unselectedItemColor: AppColors.mainColor,
        showUnselectedLabels: false,
        showSelectedLabels: false ,
        currentIndex: _selectedPage,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: 'Add product'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'User'),
        ],
      ),
    );
  }
}
