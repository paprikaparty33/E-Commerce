import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/search/search_bar_widget.dart';
import 'package:kpop_shop/providers/user_provider.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/pages/home/promo_body.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Positioned(

              child: Container(

                margin: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(

                     children: [
                       Icon(
                         Icons.location_on_outlined,

                         color: AppColors.lightTextColor,
                         size: Dimensions.iconSize16 * 2,
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           BigText(
                             text: 'Krasnodar',
                             color: AppColors.mainColor,
                           ),
                           SmallText(text: '15th of June')
                         ],
                       ),
                     ],
                   ),
                    Container(
                      margin: EdgeInsets.only(right: Dimensions.height10),
                      height: Dimensions.height45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image(image: AssetImage("assets/images/avatar.png"),),
                      ),
                    )
                  ],
                ),
              ), ) ]
            ),
          ),
          // the header
          Expanded(
              child: SingleChildScrollView(
                  child:PromoBody())),
          //pageveiw horiz plus dots
          //обвернули все в счсв чтобы вся страница скролилась, а не только популяр часть
        ],
      ),
    );
  }
}
