import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/auth/sign_in_page.dart';
import 'package:kpop_shop/providers/user_provider.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/pages/account/account_widget.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/icon_and_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/error_handling.dart';
import 'adress/adress_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    void logOut(BuildContext context) async {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString('x-auth-token', '');
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInPage.routeName,
          (route) => false,
        );
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: BigText(
          text: "Profile",
          size: 24,
          color: AppColors.mainColor,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            //profile
            Container(
              height: Dimensions.screenHeight * 0.2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: const Image(
                      image: AssetImage("assets/images/avatar.png"),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(90)
                        ),
                          
                          child: IconButton(
                            onPressed: () {},

                            icon: const Icon(Icons.camera_alt_outlined),
                            color: AppColors.whiteColor,
                          )))
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height15 * 2,
            ),
            //name
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    AccountWidget(
                        onPressed: () {},
                        appIcon: AppIcon(
                          icon: Icons.person_outlined,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(text: user.name)),
                    SizedBox(
                      height: Dimensions.height15 * 2,
                    ),
                    //phone
                    AccountWidget(
                        onPressed: () {},
                        appIcon: AppIcon(
                          icon: Icons.phone_outlined,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: user.phone,
                        )),
                    SizedBox(
                      height: Dimensions.height15 * 2,
                    ),
                    //email
                    AccountWidget(
                        onPressed: () {},
                        appIcon: AppIcon(
                          icon: Icons.mail_outlined,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: user.email,
                        )),
                    SizedBox(
                      height: Dimensions.height15 * 2,
                    ),
                    //adress
                    AccountWidget(
                        onPressed: () {
                          Navigator.pushNamed(context, AdressPage.routeName);
                        },
                        appIcon: AppIcon(
                          icon: Icons.location_on_outlined,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: user.address,
                        )),
                    SizedBox(
                      height: Dimensions.height15 * 2,
                    ),
                    //support
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                      ),
                      onPressed: () {},
                      child: AccountWidget(
                          onPressed: () {},
                          appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            size: Dimensions.height10 * 5,
                            iconSize: Dimensions.height10 * 5 / 2,
                          ),
                          bigText: BigText(
                            text: 'Support',
                          )),
                    ),
                    SizedBox(
                      height: Dimensions.height15 * 2,
                    ),
                    //supportProvider.of<UserProvider>(context).dispose();
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                      ),
                      onPressed: () {
                        logOut(context);
                      },
                      child: AccountWidget(
                          onPressed: () {
                            logOut(context);
                          },
                          appIcon: AppIcon(
                            icon: Icons.logout_outlined,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            size: Dimensions.height10 * 5,
                            iconSize: Dimensions.height10 * 5 / 2,
                          ),
                          bigText: BigText(
                            text: 'Log out',
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
