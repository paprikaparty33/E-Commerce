import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/home/main_home_page.dart';
import 'package:kpop_shop/pages/cart/cart_page.dart';
import 'package:kpop_shop/pages/search/search_page.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/pages/account/account_page.dart';
import 'package:kpop_shop/pages/auth/sign_in_page.dart';

class UserHomePage extends StatefulWidget {
  static const String routeName = '/user-home-page';

  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedPage = 0;
  List pages = [
    MainHomePage(),
    SearchPage(searchQuery: ''),
    CartPage(),
    AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedPage = index;
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
        showSelectedLabels: false,
        currentIndex: _selectedPage,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'User'),
        ],
      ),
    );
  }
}
//TODO: style navbar with persistentbottomnavbar pubdev
