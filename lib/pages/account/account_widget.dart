import 'package:flutter/material.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/icon_and_text.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  final Function onPressed;
 const AccountWidget({Key? key, required this.appIcon, required this.bigText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.width10,
          bottom: Dimensions.width10,
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width30,
          ),
          bigText,
        ],
      ),
    );
  }
}
