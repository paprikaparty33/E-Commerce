import 'package:flutter/material.dart';
import 'package:kpop_shop/pages/category/quick_view_dialog.dart';
import 'package:kpop_shop/pages/search/search_bar_widget.dart';
import 'package:kpop_shop/services/albums_service.dart';
import 'package:kpop_shop/widgets/app_icon.dart';
import 'package:kpop_shop/widgets/loader.dart';
import '../../models/album_model.dart';
import '../../services/search_service.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';
import '../album/popular_album.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = '/category-page';
  String category;

  CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController searchController = TextEditingController();

  List<Album> categoryItems = [];
  final AlbumService albumService = AlbumService();
  final SearchService searchService = SearchService();

  String status = 'All status';
  String location = 'All location';
  String sequence = 'Best match';

  List<String> filterStatus = [
    'All status',
    'Pre-order',
    'In stock',
    'Sold out'
  ];
  List<String> filterLocation = ['All location', 'KR', 'RU'];
  List<String> filterPrice = [
    'Best match',
    'Low price to high',
    'High price to low'
  ];

  bool isFavPressed = false;

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  void fetchCategory() async {
    categoryItems = await albumService.fetchCategory(context, widget.category);
    setState(() {});
  }

  void getSearch(String query) async{
    query = searchController.text;
    categoryItems = await searchService.fetchSearch(context, query);
    setState(() {

    });
  }

  void sortPriceLowToHigh() {
    categoryItems.sort((a, b) => a.price.compareTo(b.price));
    setState(() {});
  }

  void sortPriceHighToLow() {
    categoryItems.sort((a, b) => b.price.compareTo(a.price));
    setState(() {});
  }

  void sortLocation(String location) {
    categoryItems.removeWhere((element) => element.location == location);
    setState(() {});
  }

  Future openDialog(Album item) => showDialog(
      context: context,
      builder: (context) => quickViewDialog(dialogItem: item));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //TODO: 11.26
        children: [
          Stack(children: [
            Positioned(
              child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height10 * 2.5),
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){Navigator.of(context).pop();},
                          child: AppIcon(icon: Icons.arrow_back_ios_new)),
                      AnimSearchBar(
                        width: Dimensions.screenWidth * 0.72,
                        textController: searchController,

                        onSuffixTap: () {
                          setState(() {
                            searchController.clear();
                          });
                        },
                        onSubmitted: (String req) {
                          getSearch(req);
                        },
                        rtl: true,
                        color: AppColors.mainColor,
                        textFieldIconColor: AppColors.mainColor,
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        suffixIcon: Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  )),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                value: status,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                items: filterStatus
                    .map((String item) => DropdownMenuItem(
                        value: item,
                        child: BigText(
                          text: item,
                          size: 15,
                        )))
                    .toList(),
                onChanged: (String? statusVal) {
                  setState(() {
                    status = statusVal!;
                  });
                },
              ),
              // SizedBox(width: Dimensions.height40),
              DropdownButton(
                value: location,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                items: filterLocation
                    .map((String item) => DropdownMenuItem(
                        value: item,
                        child: BigText(
                          text: item,
                          size: 15,
                        )))
                    .toList(),
                onChanged: (String? locationVal) {
                  setState(() {
                    location = locationVal!;
                  });
                },
              ),
              DropdownButton(
                value: sequence,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                items: filterPrice
                    .map((String item) => DropdownMenuItem(
                        value: item,
                        child: BigText(
                          text: item,
                          size: 15,
                        )))
                    .toList(),
                onChanged: (String? locationVal) {
                  setState(() {
                    sequence = locationVal!;
                    switch (sequence) {
                      case 'Best match':
                        fetchCategory();
                        break;
                      case 'Low price to high':
                        sortPriceLowToHigh();
                        break;
                      case 'High price to low':
                        sortPriceHighToLow();
                        break;
                      default:
                        fetchCategory();
                    }
                  });
                },
              ),
            ],
          ), //FILTERS
          categoryItems == []
              ? Loader()
              :
              // the header
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.only(top: 0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                            mainAxisExtent: Dimensions.screenHeight * 0.3,
                          ),
                          itemCount: categoryItems.length,
                          itemBuilder: (context, index) {
                            final itemData = categoryItems[index];
                            return TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PopularAlbumDetail.routeName,
                                    arguments: itemData);
                              },
                              child: Container(
                                width: Dimensions.screenWidth * 0.47,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            topLeft: Radius.circular(12)),
                                        child: Image.network(
                                          itemData.images[0],
                                          height:
                                              Dimensions.screenHeight * 0.22,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: Dimensions.height10 * 0.1,
                                        top: Dimensions.height10 * 0.1,
                                        child: AppIconButton(
                                          icon: Icons.remove_red_eye_outlined,
                                          onPressed: () {
                                            openDialog(itemData);
                                          },
                                        )),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 70,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            BigText(
                                              text: itemData.name,
                                              size: 16,
                                            ),
                                            SizedBox(
                                                height: Dimensions.height10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BigText(
                                                    text:
                                                        '${itemData.price.toString()}\$')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
