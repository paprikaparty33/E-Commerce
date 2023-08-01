import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpop_shop/models/album_model.dart';
import 'package:kpop_shop/pages/add_del_edit_product/edit_product_page.dart';
import 'package:kpop_shop/pages/album/popular_album.dart';
import 'package:kpop_shop/pages/auth/sign_in_page.dart';
import 'package:kpop_shop/pages/auth/sign_up_page.dart';
import 'package:kpop_shop/pages/cart/cart_page.dart';
import 'package:kpop_shop/pages/home/user_home_page.dart';

import '../pages/account/adress/adress_page.dart';
import '../pages/home/admin_home_page.dart';
import '../pages/category/category_page.dart';
import '../pages/search/search_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const SignInPage(),
      );
      //sign in

    case SignUpPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const SignUpPage(),
      );
      //sign up

    case UserHomePage.routeName:
      return MaterialPageRoute(
        builder: (_) => const UserHomePage(),
      );
      //user home

    case AdminHomePage.routeName:
      return MaterialPageRoute(
        builder: (_) => const AdminHomePage(),
      );
      //admin home

    case PopularAlbumDetail.routeName:
      var album = routeSettings.arguments as Album;
      return MaterialPageRoute(
    settings: routeSettings,
        builder: (_) => PopularAlbumDetail(album: album),
      );
      //popular album

    case EditProductScreen.routeName:
      var album = routeSettings.arguments as Album;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditProductScreen(album: album),
      );
      //edit product

    case CartPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CartPage(),
      );
      //cart

    case CategoryPage.routeName:
      String category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryPage(category: category),
      );
      //categories

    // case SearchPage.routeName:
    //   Map<String, String> arguments = routeSettings.arguments as Map<String, String>;
    //   String searchQuery = arguments['searchQuery'] as String;
    //   String searchType = arguments['searchType'] as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SearchPage(searchQuery: searchQuery, searchType: searchType),
    //   );
    case SearchPage.routeName:
     String searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchPage(searchQuery: searchQuery),
      );
      //search
    case AdressPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AdressPage(),
      );
  //adress

    default:
      return MaterialPageRoute(builder: (_) =>
      const Scaffold(backgroundColor: Colors.white,
        body: Center(
          child: Text('Screen does not exist'),
        ),));
  }
}