import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/add_del_edit_product/edit_product_page.dart';
import 'package:kpop_shop/providers/album_provider.dart';
import 'package:kpop_shop/services/cart_service.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/icon_and_text.dart';
import 'package:provider/provider.dart';

import '../../models/album_model.dart';
import '../../providers/user_provider.dart';
import '../cart/cart_page.dart';

class PopularAlbumDetail extends StatefulWidget {
  static const String routeName = '/album-detail-page';
  final Album album;

  const PopularAlbumDetail({Key? key, required this.album}) : super(key: key);

  @override
  State<PopularAlbumDetail> createState() => _PopularAlbumDetailState();
}

class _PopularAlbumDetailState extends State<PopularAlbumDetail> {
  CartService cartService = CartService();

  bool isFavPressed = false;

  double quantity = 1;


  @override
  Widget build(BuildContext context) {
    final cart = context.watch<UserProvider>().user.cart;


    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.album.images.length,
                    itemBuilder: (context, item) {
                      return Container(
                        height: 435,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          image: DecorationImage(
                            image: NetworkImage(widget.album.images[item]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 165,
                  width: 100,
                )
//TODO: HARDCODED SIZEDBOX
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height40,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Provider.of<UserProvider>(context).user.type == 'admin'
                    ? AppIconButton(
                        icon: Icons.edit,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EditProductScreen.routeName,
                              arguments: widget.album);
                        })
                    : AppIconButton(
                        icon: Icons.shopping_cart_outlined,
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartPage.routeName);
                        },
                      )
              ],
            ),
          ), //TODO: 4.35 VIEDO SLIVERS
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.965,
            minChildSize: widget.album.images.length == 1 ? 0.42 : 0.22,
            builder: (context, controller) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ]),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 15, bottom: 90),
                      child: Column(
                        children: [
                          BigAlbumNameText(text: widget.album.name),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          SmallText(text: 'Release date: 20.05.2023'),
                          //BigText(text: '1 450.00 RUB'),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                children: List.generate(
                                    5,
                                    (index) => Icon(Icons.star,
                                        color: AppColors.mainColor, size: 20)),
                              ),
                              SizedBox(width: Dimensions.width10),
                              SmallText(text: '4.5'),
                              SizedBox(width: Dimensions.width20),
                              SmallText(text: '10023'),
                              SizedBox(width: Dimensions.width10),
                              SmallText(text: 'purchases'),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconAndText(
                                  icon: Icons.circle_sharp,
                                  text: widget.album.status,
                                  iconColor: AppColors.mainColor),
                              SizedBox(width: Dimensions.width10),
                              IconAndText(
                                  icon: Icons.location_on,
                                  text: widget.album.location,
                                  iconColor: AppColors.mainColor),
                              SizedBox(width: Dimensions.width10),
                              IconAndText(
                                  icon: Icons.access_time_rounded,
                                  text: widget.album.getDeliveryTime(
                                      widget.album.location,
                                      widget.album.status),
                                  iconColor: AppColors.mainColor)
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height40,
                          ),
                          SmallText(text: '''В альбом входит: 
                                     - CD 
                                     - фотобук (80 стр.)
                                     - тексты песен (4 стр.)
                                     - фотокарточка (2 из 24 возможных)
                                     - мини-плакат (1 из 8 возможных)
                                     - наклейка (1 из 8 возможных)
                                               
             
 Дополнительно только в лимитированной версии:

                                      - мини-плакат(1 из 8 возможных)
                                      - закладка на 4 фото
                                                
 Дополнительно только по предзаказу:

                                      - набор из полароида и любовного письма (1 из 8 возможных)
                                      - сложенный плакат '''),
                          SmallText(
                              text:
                                  '''Просим Вас обратить внимание, что на карточках, фотобуках и другом наполнении могут быть небольшие следы от взаимодействия с другим наполнением (полосы, потертости и др)

Также в некоторых фотобуках могут плохо держаться и даже вываливаться страницы, т.к. станицы вклеены а не прошиты, такая технология производства.

Это не является браком'''),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

              //  Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       height: Dimensions.bottomHeightBar,
              //       padding: EdgeInsets.only(
              //           top: Dimensions.height20, bottom: Dimensions.height20),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(Dimensions.radius20),
              //               topRight: Radius.circular(Dimensions.radius20)),
              //           color: Colors.grey.shade200),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Container(
              //             height: Dimensions.bottomHeightBar * 0.9,
              //             width: Dimensions.screenWidth * 0.3,
              //             decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.circular(Dimensions.radius20),
              //                 color: Colors.white),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [
              //                 IconButton(
              //                   icon: Icon(Icons.remove),
              //                   color: AppColors.lightTextColor,
              //                   onPressed: () {
              //                     quantity -= 1;
              //                     setState(() {});
              //                   },
              //                 ),
              //                 BigText(text: '${quantity.floor()}'),
              //                 IconButton(
              //                   icon: Icon(Icons.add),
              //                   color: AppColors.lightTextColor,
              //                   onPressed: () {
              //                     quantity += 1;
              //                     setState(() {});
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //           InkWell(
              //             onTap: () {
              //               cartService.addToCart(
              //                   context, widget.album, quantity);
              //             },
              //             child: Container(
              //               height: Dimensions.bottomHeightBar * 0.9,
              //               width: Dimensions.screenWidth * 0.4,
              //               decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.circular(Dimensions.radius20),
              //                   color: AppColors.mainColor),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                 children: [
              //                   BigText(
              //                     text:
              //                         'Go to cart',
              //                     color: Colors.white,
              //                     size: Dimensions.font20 * 0.8,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           Container(
              //             height: Dimensions.bottomHeightBar * 0.9,
              //             width: Dimensions.screenWidth * 0.15,
              //             decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.circular(Dimensions.radius20),
              //                 color: Colors.white),
              //             child: IconButton(
              //                 onPressed: () {
              //                   setState(() {
              //                     isFavPressed = !isFavPressed;
              //                   });
              //                 },
              //                 icon: Icon(
              //                   isFavPressed
              //                       ? Icons.favorite
              //                       : Icons.favorite_outline_outlined,
              //                   color: AppColors.mainColor,
              //                 )),
              //           ),
              //         ],
              //       ),
              //     ),
              //   )
              // ,
          Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: Dimensions.bottomHeightBar,
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height20, bottom: Dimensions.height20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(Dimensions.radius20),
                                              topRight: Radius.circular(Dimensions.radius20)),
                                          color: Colors.grey.shade200),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: Dimensions.bottomHeightBar * 0.9,
                                            width: Dimensions.screenWidth * 0.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  color: AppColors.lightTextColor,
                                                  onPressed: () {
                                                    quantity -= 1;
                                                    setState(() {});
                                                  },
                                                ),
                                                BigText(text: '${quantity.floor()}'),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  color: AppColors.lightTextColor,
                                                  onPressed: () {
                                                    quantity += 1;
                                                    setState(() {});
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cartService.addToCart(
                                                  context, widget.album, quantity);
                                            },
                                            child: Container(
                                              height: Dimensions.bottomHeightBar * 0.9,
                                              width: Dimensions.screenWidth * 0.4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(Dimensions.radius20),
                                                  color: AppColors.mainColor),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text:
                                                        '\$ ${widget.album.price} | Add to cart',
                                                    color: Colors.white,
                                                    size: Dimensions.font20 * 0.8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: Dimensions.bottomHeightBar * 0.9,
                                            width: Dimensions.screenWidth * 0.15,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isFavPressed = !isFavPressed;
                                                  });
                                                },
                                                icon: Icon(
                                                  isFavPressed
                                                      ? Icons.favorite
                                                      : Icons.favorite_outline_outlined,
                                                  color: AppColors.mainColor,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )

        ],
      ),
    );
  }
}
