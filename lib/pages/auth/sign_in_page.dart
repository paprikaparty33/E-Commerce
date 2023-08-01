import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/account/account_page.dart';
import 'package:kpop_shop/pages/home/user_home_page.dart';
import 'package:kpop_shop/services/signin_service.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/pages/auth/auth_text_field.dart';
import 'package:kpop_shop/pages/auth/sign_up_page.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin-page';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final _logInFormKey = GlobalKey<FormState>();
    final SignInService signInService = SignInService();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();





    void signInUser() {
      signInService.signInUser(
          context: context,
          email: emailController.text,
          password: passController.text,
         );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _logInFormKey,
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.07,
              ),

              Container(
                height: Dimensions.screenHeight * 0.25,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/moon.png"),
                ),
              ),
              //app logo
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              AuthTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.mail_outline),
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              AuthTextField(
                  textEditingController: passController,
                  hintText: "Password",
                  icon: Icons.password_outlined),
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  if(_logInFormKey.currentState!.validate()){

                    signInUser();

                  }
                  // Действия при нажатии кнопки "Sign up"
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
                  minimumSize: Size(
                    Dimensions.screenWidth * 0.5,
                    Dimensions.screenHeight / 12,
                  ),
                ),
                child: BigText(
                  text: 'Log in',
                  size: Dimensions.font20 * 1.5,
                ),
              ),
              //log in  button
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Don`t have an account?',
                      style: TextStyle(
                          color: Colors.grey, fontSize: Dimensions.font20),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context, SignUpPage.routeName
                                   );
                              },
                            text: ' Create',
                            style: TextStyle(
                                color: AppColors.lightTextColor, fontSize: Dimensions.font20)),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
