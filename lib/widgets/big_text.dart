import 'package:kpop_shop/utils/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigText(
      {Key? key,
      this.color = const Color(0xff1C1D21),
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: size == 0 ? Dimensions.font20 : size),
    );
  }
}

class BigAlbumNameText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigAlbumNameText(
      {Key? key,
        this.color = const Color(0xff1C1D21),
        required this.text,
        this.size = 20,
        this.overFlow = TextOverflow.ellipsis,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: size == 0 ? Dimensions.font20 : size),
    );
  }
}