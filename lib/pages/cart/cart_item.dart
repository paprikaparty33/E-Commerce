import 'package:flutter/material.dart';
import 'package:kpop_shop/services/cart_service.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:kpop_shop/models/album_model.dart';
import '../../providers/user_provider.dart';
import '../album/popular_album.dart';

class CartItem extends StatefulWidget {
  final int index;

  const CartItem({Key? key, required this.index}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final _itemCart = context.watch<UserProvider>().user.cart[widget.index];
    final item = Album.fromMap(_itemCart['album']);
    final quantity = _itemCart['quantity'];
    double increace = 1;

    void increaseQuantity(Album album) {
      cartService.addToCart(context, album, increace);
    }

    void decreaseQuantity(Album album) {
      cartService.removeFromCart(context: context, album: album);
    }

    return item.getDeliveryTime(item.location, item.status) == 'Not available'
        ? Container(
            margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
                bottom: Dimensions.width20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PopularAlbumDetail.routeName,
                        arguments: item);
                  },
                  child: Container(
                      width: Dimensions.listViewImgSize * 0.8,
                      height: Dimensions.listViewImgSize * 0.8,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white30,
                        image: DecorationImage(
                          image: NetworkImage(item.images[0]),
                          fit: BoxFit.cover,
                        ),
                      ) //IMAGES SECTION (POPULAR ITEM LEFT)
                      ),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.listVeiwTextContSize * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            bottomRight: Radius.circular(Dimensions.radius20)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: item.name, color: Colors.red,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(text: 'Not available', color: Colors.red,),
                                ],
                              ),
                              Container(
                                height: Dimensions.listVeiwTextContSize * 0.35,
                                width: Dimensions.screenWidth * 0.27,
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20 * 0.5)),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.remove,
                                        color: AppColors.whiteColor,
                                      ),
                                      onTap: () {
                                        decreaseQuantity(item);
                                      },
                                    ),
                                    BigText(
                                      text: '${quantity}',
                                      color: Colors.white,
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                      onTap: () {
                                        increaseQuantity(item);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ), //POPULAR ITEM RIGHT
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
                bottom: Dimensions.width20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PopularAlbumDetail.routeName,
                        arguments: item);
                  },
                  child: Container(
                      width: Dimensions.listViewImgSize * 0.8,
                      height: Dimensions.listViewImgSize * 0.8,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white30,
                        image: DecorationImage(
                          image: NetworkImage(item.images[0]),
                          fit: BoxFit.cover,
                        ),
                      ) //IMAGES SECTION (POPULAR ITEM LEFT)
                      ),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.listVeiwTextContSize * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            bottomRight: Radius.circular(Dimensions.radius20)),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: item.name),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(text: 'JAPPAPA Ver.'),
                                  SmallText(text: 'Random'),
                                ],
                              ),
                              Container(
                                height: Dimensions.listVeiwTextContSize * 0.35,
                                width: Dimensions.screenWidth * 0.27,
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20 * 0.5)),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.remove,
                                        color: AppColors.whiteColor,
                                      ),
                                      onTap: () {
                                        decreaseQuantity(item);
                                      },
                                    ),
                                    BigText(
                                      text: '${quantity}',
                                      color: Colors.white,
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.whiteColor,
                                      ),
                                      onTap: () {
                                        increaseQuantity(item);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ), //POPULAR ITEM RIGHT
                )
              ],
            ),
          );
  }
}
