import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kpop_shop/services/signup_service.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/icon_and_text.dart';
import 'package:kpop_shop/pages/auth/auth_text_field.dart';
import 'package:kpop_shop/pages/auth/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup-page';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _signUpFormKey = GlobalKey<FormState>();
  final SignUpService signUpService = SignUpService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }
  void signUpUser() {
    signUpService.signUpUser(
        context: context,
        email: emailController.text,
        password: passController.text,
        phone: phoneController.text,
        name: nameController.text);
  }



  @override
  Widget build(BuildContext context) {


    var singUpImages = ['img.png', 'img_1.png', 'img_2.png'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),

              Container(
                height: Dimensions.screenHeight * 0.2,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/moon.png"),
                ),
              ),
              //app logo
              SizedBox(
                height: Dimensions.screenHeight * 0.025,
              ),
              AuthTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.mail_outline),
              SizedBox(
                height: Dimensions.screenHeight * 0.025,
              ),
              AuthTextField(
                  textEditingController: phoneController,
                  hintText: "Phone number",
                  icon: Icons.phone_outlined),
              SizedBox(
                height: Dimensions.screenHeight * 0.025,
              ),

              AuthTextField(
                  textEditingController: nameController,
                  hintText: "Name",
                  icon: Icons.person_2_outlined),
              SizedBox(
                height: Dimensions.screenHeight * 0.025,
              ),
              AuthTextField(
                  textEditingController: passController,
                  hintText: "Password",
                  icon: Icons.password_outlined),
              SizedBox(
                height: Dimensions.screenHeight * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                if(_signUpFormKey.currentState!.validate()){
                  signUpUser();
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
                  text: 'Sign up',
                  size: Dimensions.font20 * 1.5,
                ),
              ),

              //sign up  button
              SizedBox(
                height: Dimensions.screenHeight * 0.01,
              ),
              RichText(
                  text: TextSpan(
                      text: 'or',
                      style: TextStyle(
                          color: Colors.grey, fontSize: Dimensions.font20))),
              Wrap(
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundImage: AssetImage(
                                'assets/images/' + singUpImages[index]),
                          ),
                        )),
              ),
              RichText(
                  text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                          color: Colors.grey, fontSize: Dimensions.font20),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, SignInPage.routeName );
                          },
                        text: ' Log in',
                        style: TextStyle(
                            color: AppColors.lightTextColor,
                            fontSize: Dimensions.font20)),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
