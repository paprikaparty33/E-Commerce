import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/category/categories_widget.dart';
import 'package:kpop_shop/services/albums_service.dart';
import 'package:kpop_shop/utils/colors.dart';
import 'package:kpop_shop/widgets/big_text.dart';
import 'package:kpop_shop/widgets/loader.dart';
import 'package:kpop_shop/widgets/small_text.dart';
import 'package:kpop_shop/widgets/icon_and_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/services/admin_service.dart';
import 'package:kpop_shop/models/album_model.dart';

import '../album/popular_album.dart';

class PromoBody extends StatefulWidget {

  const PromoBody({Key? key}) : super(key: key);

  @override
  State<PromoBody> createState() => _PromoBodyState();
}

class _PromoBodyState extends State<PromoBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currItemValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  bool isNewArrivalsPressed = false;
  bool isPopularPressed = true;
  List<Album> newArrivals = [];
  List<Album> popular = [];
  final AlbumService albumService = AlbumService();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currItemValue = pageController.page!;
      });
    });
    fetchNewArrivals();
  }

  void fetchNewArrivals() async {
    newArrivals = await albumService.fetchNewArrivals(context);
    popular = await albumService.fetchPopular(context);
    setState(() {});
  }

  // @override
  // void dispose() {
  //   pageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return (newArrivals == null || popular == null) //в скобки потом возбмешь для проверки испопюляр
        ? const Loader(

    )
        : isPopularPressed ? Column(
            children: [
              Container(
                height: Dimensions.screenHeight / 2.85,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: 5,
                    itemBuilder: (context, position) {
                      return _carouselItem(position);
                    }),
              ), //PAGEVIEW SLIDER LEFT RIGHT
               DotsIndicator(
                dotsCount: 5,
                position: _currItemValue,
                decorator: DotsDecorator(
                  color: Colors.black26,
                  // Inactive color
                  activeColor: AppColors.mainColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ), //DOTS

              SizedBox(
                height: Dimensions.width20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Categories(categoryName: 'Albums'),
                  SizedBox(width: Dimensions.width15,),
                  Categories(categoryName: 'Photocards'),
                  SizedBox(width: Dimensions.width15,),
                  Categories(categoryName: 'Merch'),

                ],
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
                                fontSize: isPopularPressed ? 18.0 : 16.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          isPopularPressed = true;
                          isNewArrivalsPressed = false;
                        });
                      },
                      child: Transform.scale(
                        scale: isPopularPressed ? 1 : 0.7,
                        child: BigText(text: 'Popular'),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    //margin: const EdgeInsets.only(bottom: ),
                    SmallText(text: '|'),

                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
                                fontSize: isNewArrivalsPressed ? 18.0 : 16.0)),
                      ),
                      onPressed: () {
                        setState(() {
                          isNewArrivalsPressed = true;
                          isPopularPressed = false;
                        });
                      },
                      child: Transform.scale(
                        scale: isNewArrivalsPressed ? 1 : 0.7,
                        child: BigText(
                          text: 'New Arrivals',
                        ),
                      ),
                    ),
                  ],
                ),
              ), //POPULAR TEXT
              ListView.builder(
                padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popular.length,
                  itemBuilder: (context, index) {
                    final albumData = popular[index];
                    return TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      onPressed: () {
              Navigator.pushNamed(context, PopularAlbumDetail.routeName, arguments: albumData);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.width10),
                        child: Row(
                          children: [
                            Container(
                                width: Dimensions.listViewImgSize,
                                height: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white30,
                                  image: DecorationImage(
                                    image: NetworkImage(albumData.images[0]),
                                    fit: BoxFit.cover,
                                  ),
                                ) //IMAGES SECTION (POPULAR ITEM LEFT)
                                ),
                            Expanded(
                              //обвернули в экспандед, чтобы растянулся налево и
                              // направо динамически. иначе наш контейнер просто палка длиною 100 пх
                              //но все еще остался отступ справа, потому что у родительского
                              // контейнера, в котором Row, установлены маржинс
                              child: Container(
                                height: Dimensions.listVeiwTextContSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: albumData.name),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SmallText(text: 'Jewel Ver.'),
                                          SizedBox(width: Dimensions.width45),
                                          SmallText(text: 'Random')
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                              icon: Icons.circle_sharp,
                                              text: albumData.status,
                                              iconColor: AppColors.mainColor),
                                          SizedBox(width: Dimensions.width10),
                                          IconAndText(
                                              icon: Icons.location_on,
                                              text: albumData.location,
                                              iconColor: AppColors.mainColor),
                                          SizedBox(width: Dimensions.width10),
                                          IconAndText(
                                              icon: Icons.access_time_rounded,
                                              text: albumData.getDeliveryTime(
                                                  albumData.location,
                                                  albumData.status),
                                              iconColor: AppColors.mainColor)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ), //POPULAR ITEM RIGHT
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
      //СМЕНА ВИДЖЕТА ТУТ
          ) : Column(
      children: [
        Container(
          height: Dimensions.screenHeight / 2.85,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _carouselItem(position);
              }),
        ), //PAGEVIEW SLIDER LEFT RIGHT
         DotsIndicator(
          dotsCount: 5,
          position: _currItemValue,
          decorator: DotsDecorator(
            color: Colors.black26,
            // Inactive color
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ), //DOTS

        SizedBox(
          height: Dimensions.width20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Categories(categoryName: 'Albums'),
            SizedBox(width: Dimensions.width15,),
            Categories(categoryName: 'Photocards'),
            SizedBox(width: Dimensions.width15,),
            Categories(categoryName: 'Merch'),

          ],
        ),

        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(

                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                  overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                          fontSize: isPopularPressed ? 18.0 : 16.0)),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    isPopularPressed = true;
                    isNewArrivalsPressed = false;
                  });
                },
                child: Transform.scale(
                  scale: isPopularPressed ? 1 : 0.7,
                  child: BigText(text: 'Popular'),
                ),
              ),
              SizedBox(
                width: Dimensions.width20,
              ),
              //margin: const EdgeInsets.only(bottom: ),
              SmallText(text: '|'),

              SizedBox(
                width: Dimensions.width10,
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                  overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                          fontSize: isNewArrivalsPressed ? 18.0 : 16.0)),
                ),
                onPressed: () {
                  setState(() {
                    isNewArrivalsPressed = true;
                    isPopularPressed = false;
                  });
                },
                child: Transform.scale(
                  scale: isNewArrivalsPressed ? 1 : 0.7,
                  child: BigText(
                    text: 'New Arrivals',
                  ),
                ),
              ),
            ],
          ),
        ), //POPULAR TEXT
        ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: newArrivals.length,
            itemBuilder: (context, index) {
              final albumData = newArrivals[index];
              return TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                  overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, PopularAlbumDetail.routeName, arguments: albumData);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.width10),
                  child: Row(
                    children: [
                      Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20),
                            color: Colors.white30,
                            image: DecorationImage(
                              image: NetworkImage(albumData.images[0]),
                              fit: BoxFit.cover,
                            ),
                          ) //IMAGES SECTION (POPULAR ITEM LEFT)
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.listVeiwTextContSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      Dimensions.radius20),
                                  bottomRight: Radius.circular(
                                      Dimensions.radius20)),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(text: albumData.name),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    SmallText(text: 'JAPPAPA Ver.'),
                                    SizedBox(width: Dimensions.width45),
                                    SmallText(text: 'Random')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndText(
                                        icon: Icons.circle_sharp,
                                        text: albumData.status,
                                        iconColor: AppColors.mainColor),
                                    SizedBox(width: Dimensions.width10),
                                    IconAndText(
                                        icon: Icons.location_on,
                                        text: albumData.location,
                                        iconColor: AppColors.mainColor),
                                    SizedBox(width: Dimensions.width10),
                                    IconAndText(
                                        icon: Icons.access_time_rounded,
                                        text: albumData.getDeliveryTime(
                                            albumData.location,
                                            albumData.status),
                                        iconColor: AppColors.mainColor)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ), //POPULAR ITEM RIGHT
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
    //pageview - скролл между виджетами(pages). можно выставить scro;;axis
    //onpagechanged функция позволяет отслеживать текущую страницу
    // и делать с нейчото (выводить анекдот в консоль напр)
    //pagecontroller помогает управлять переходами нашего pageview
    // и следить за текущей page без onpagechanged
  }

  Widget _carouselItem(int index) {
    Matrix4 matrix4 = Matrix4.identity(); //штучка для анимаций, 4 оси
    if (index == _currItemValue.floor()) {
      //выбираем моменты
      //когда _сurrentItemValue - целое число и равняется индексу (там по скейлу
      //виджет принимает обычный размер в цифрах 1, 2, 0 и тд.
      var currScale = 1 - (_currItemValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      //_currItemValue-index для того чтобы получить ОДИН МИНУС НОЛЬ
      //this equation is only TRUE for centered item
    } else if (index == _currItemValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currItemValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currItemValue.floor() - 1) {
      var currScale = 1 - (_currItemValue - index) * (1 - _scaleFactor);
      //тут везде какаято дикая математика работающая с индексом текущей и соседних страниц
      //и с их валью и чото мы там шаманим и получаем слева и справа скейл 0.8 а посередке 1
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 1);
    }
//TODO: отследи индекс во всех уравнениях,
    // посчитай вручную. у тебя все получится!

    return Transform(
      transform: matrix4,
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        onPressed: () {},
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewTopContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color:
                      index.isEven ? AppColors.pinkColor : AppColors.skinColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/bss.png"))),
            ), //TOP CONTAINER
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: 280,
                margin: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Second Wind'),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(Icons.star,
                                    color: AppColors.mainColor, size: 15)),
                          ),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: '4.5'),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: '10023'),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: 'purchases')
                        ],
                      ),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(
                              icon: Icons.circle_sharp,
                              text: 'Normal',
                              iconColor: AppColors.mainColor),
                          SizedBox(width: Dimensions.width10),
                          IconAndText(
                              icon: Icons.location_on,
                              text: 'KR',
                              iconColor: AppColors.mainColor),
                          SizedBox(width: Dimensions.width10),
                          IconAndText(
                              icon: Icons.access_time_rounded,
                              text: '30-50 days',
                              iconColor: AppColors.mainColor)
                        ],
                      )
                    ],
                  ),
                ),
              ), //BOTTOM CONTAINER
            ),
          ],
        ),
      ),
    );
  }
}
