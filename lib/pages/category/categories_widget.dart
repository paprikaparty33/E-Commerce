import 'package:flutter/material.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/small_text.dart';

import '../../utils/dimensions.dart';
import 'category_page.dart';

class Categories extends StatelessWidget {
  String categoryName;
  Categories({Key? key,
  required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Действие при нажатии кнопки
        Navigator.pushNamed(context, CategoryPage.routeName, arguments: categoryName);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        primary: AppColors.mainColor,
        onPrimary: Colors.white,
        elevation: 5.0,
        shadowColor: Colors.black26,
        side: BorderSide(color: Colors.white),
      ),
      child: Container(
        width: Dimensions.width10 * categoryName.length * 2.5,
        height: Dimensions.height15 * 2,
        child: Center(
          child: SmallText(
            text: categoryName,
            color: Colors.white,
          ),
        ),
      ),
    );



  }
}
