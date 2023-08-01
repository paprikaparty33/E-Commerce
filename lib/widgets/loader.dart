import 'package:flutter/material.dart';
import 'package:kpop_shop/utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.mainColor,
      ),
    );
  }
}
