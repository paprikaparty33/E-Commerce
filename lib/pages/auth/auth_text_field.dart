import 'package:flutter/material.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/icon_and_text.dart';
//TODO: добавить снекбар чтобы расшираение не перекрывало тенюшки
class AuthTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;

  const AuthTextField({Key? key, required this.textEditingController, required this.hintText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(
          left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [BoxShadow(
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(1,10),
              color: Colors.grey.withOpacity(0.2)
          )]),
      child: TextFormField(
        validator: (val) {
          if(val == null || val.isEmpty){
            return 'Enter your $hintText';
          }else  {return null;}

        },
        controller: textEditingController,

        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.pinkColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:
              BorderSide(width: 1.0, color: AppColors.pinkColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:
              BorderSide(width: 1.0, color: AppColors.pinkColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:
              BorderSide(width: 1.0, color: AppColors.pinkColor)),
        ),
      ),
    );
  }
}
