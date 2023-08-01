import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/auth/auth_text_field.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/widgets/app_icon.dart';

import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';

class AdressPage extends StatefulWidget {
  static const String routeName = '/adress-page';
  const AdressPage({Key? key}) : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: const AppIcon(icon: Icons.arrow_back_ios_new,),
        ),
        title: BigText(
          text: "Address info",
          size: 24,
          color:  AppColors.mainColor,
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    border: Border.all(
                      color: AppColors.pinkColor,
                      width: 2.0,
                    ),
                  ),
                  height: Dimensions.screenHeight * 0.25,
                  width: Dimensions.screenWidth * 0.95,
                  child: const Image(image: AssetImage("assets/images/gmaps.png"),
                  fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                    bottom: 20,
                    right: 20,
                    child: AppIcon(icon: Icons.my_location,))
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: Dimensions.screenHeight * 0.5,
              decoration: BoxDecoration(
                  color: AppColors.pinkColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(Dimensions.radius30)
              ),
              // child: Column(
              //   children: [
              //
              //   ],
              // ),

            ),
            Container(
              height: Dimensions.bottomHeightBar * 0.65,
              width: Dimensions.screenWidth * 0.9,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor),
              child: TextButton(
                  onPressed: () {},
                  child: BigText(
                    text: 'Save',
                    color: Colors.white,
                    size: Dimensions.font20,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
