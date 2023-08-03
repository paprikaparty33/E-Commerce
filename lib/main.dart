import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpop_shop/helper/router.dart';
import 'package:kpop_shop/pages/add_del_edit_product/add_product_page.dart';
import 'package:kpop_shop/pages/auth/sign_in_page.dart';
import 'package:kpop_shop/pages/home/main_home_page.dart';
import 'package:kpop_shop/pages/home/user_home_page.dart';
import 'package:kpop_shop/pages/auth/sign_up_page.dart';
import 'package:kpop_shop/providers/album_provider.dart';
import 'package:kpop_shop/providers/user_provider.dart';
import 'package:kpop_shop/services/signin_service.dart';
import 'package:provider/provider.dart';

main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) =>
        UserProvider()
      ,
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignInService signInService = SignInService();

  @override
  void initState() {
    super.initState();
    signInService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //getmaterialapp will get the context when the app gets initialized for the first time
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty  ? Provider.of<UserProvider>(context).user.type == 'user'
      ? UserHomePage() : AdminHomePage() : SignInPage()
    );
  }
}
