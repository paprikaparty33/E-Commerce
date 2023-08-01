import 'package:flutter/material.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = Colors.white,
      this.iconColor = const Color(0xff1C1D21),
      this.size = 40,
      this.iconSize = 20,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size/2),
          color: backgroundColor.withOpacity(0.7)
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),

    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final Function onPressed;

  const AppIconButton(
      {Key? key,
        required this.icon,
        this.backgroundColor = Colors.white,
        this.iconColor = const Color(0xff1C1D21),
        this.size = 40,
        this.iconSize = 20,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){onPressed();},
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size/2),
            color: backgroundColor.withOpacity(0.7)
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
