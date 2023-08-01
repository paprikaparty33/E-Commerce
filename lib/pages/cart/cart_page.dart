import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/cart/cart_item.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart-page';

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //short sintax of provider below
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['album']['price'] as int)
        .toList();

    return Scaffold(
      body: SafeArea(

        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),

                  ),
                  height: Dimensions.height45 * 1.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                )),
            user.cart.isEmpty ?
                Center(child: BigText(text: 'Your cart is empty',),)
                :
            Positioned(
                left: Dimensions.width20,
                top: Dimensions.height20 * 4 ,
                right: Dimensions.width20,
                bottom: 0,
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.zero,
                         physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                          itemCount: user.cart.length,
                          itemBuilder: (context, index) {
                            return CartItem(index: index);

                      }), SizedBox(
                        height: Dimensions.bottomHeightBar * 0.9,
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.bottomHeightBar * 0.9,
                padding: EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: Dimensions.bottomHeightBar * 0.8,
                        width: Dimensions.screenWidth * 0.3,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Center(
                          child: BigText(
                            text: '\$ ${sum.toDouble()}',
                            color: AppColors.lightTextColor,
                            size: Dimensions.font20 * 1.3,
                          ),
                        )),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Container(
                      height: Dimensions.bottomHeightBar * 0.9,
                      width: Dimensions.screenWidth * 0.55,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: BigText(
                                text: 'Check out',
                                color: Colors.white,
                                size: Dimensions.font20,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
