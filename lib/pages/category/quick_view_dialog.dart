import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import '../../services/cart_service.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class quickViewDialog extends StatelessWidget {
  Album dialogItem;

  quickViewDialog({Key? key, required this.dialogItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartService cartService = CartService();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        height: Dimensions.screenHeight * 0.55,
        width: Dimensions.screenWidth * 0.5,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.network(
                      dialogItem.images[0],
                      // height: Dimensions.screenHeight * 0.25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigAlbumNameText(text: dialogItem.name),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: '${dialogItem.price.toString()}\$',
                            size: 17,
                            color: AppColors.lightTextColor,
                          ),
                          SizedBox(width: Dimensions.width30),
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(Icons.star,
                                    color: AppColors.mainColor, size: 15)),
                          ),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: '4.5'),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(
                              icon: Icons.circle_sharp,
                              text: dialogItem.status,
                              iconColor: AppColors.mainColor),
                          // SizedBox(width: Dimensions.width10),
                          IconAndText(
                              icon: Icons.location_on,
                              text: dialogItem.location,
                              iconColor: AppColors.mainColor),
                          //  SizedBox(width: Dimensions.width10),
                          IconAndText(
                              icon: Icons.access_time_rounded,
                              text: dialogItem.getDeliveryTime(
                                  dialogItem.location, dialogItem.status),
                              iconColor: AppColors.mainColor)
                        ],
                      )
                    ],
                  ),
                  TextButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.zero)),
                      onPressed: () {
                        cartService.addToCart(context, dialogItem, 1);
                      },
                      child: Container(
                        height: Dimensions.screenHeight * 0.06,
                        //  width: Dimensions.screenWidth * 0.9,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor),
                        child: Center(
                          child: BigText(
                            text: 'Add to cart',
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Positioned(
              top: -15,
              right: -5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppIconButton(
                    icon:
                        // isFavPressed
                        //     ? Icons.favorite
                        //     :
                        Icons.favorite_outline_outlined,
                    onPressed: () {
                      // setState(() {
                      //   isFavPressed = !isFavPressed;
                      // });
                    },
                  ),
                  AppIconButton(
                    icon: Icons.close,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
